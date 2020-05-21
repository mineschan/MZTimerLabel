//
//  MZTimerLabel.swift
//  Version 0.5.2
//  Created by MineS Chan (mines.chan) on 2013-10-16
//  Updated to Swift by Noor ul Ain Ali(noorulain17) on 21/05/20.
//
//  Copyright (c) 2014- MineS Chan. All rights reserved.
//

// This code is distributed under the terms and conditions of the MIT license.

// Copyright (c) 2014 MineS Chan
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation
import UIKit

/**********************************************
 MZTimerLabel TimerType Enum
 **********************************************/

@objc enum MZTimerLabelType: Int {
    case stopwatch
    case timer
}

/**********************************************
 Delegate Methods
 @optional
 
 - timerLabel:finishedCountDownTimerWith:
 ** MZTimerLabel Delegate method for finish of countdown timer
 
 - timerLabel:countingTo:timerType:
 ** MZTimerLabel Delegate method for monitoring the current counting progress
 
 - timerLabel:customTextToDisplayAt:
 ** MZTimerLabel Delegate method for overriding the text displaying at the time, implement this for your very custom display format
 **********************************************/

@objc protocol MZTimerLabelDelegate: NSObjectProtocol {
    @objc optional func timerLabel(_ timerLabel: MZTimerLabel, finishedCountDownTimerWith countTime: TimeInterval)
    @objc optional func timerLabel(_ timerLabel: MZTimerLabel, countingTo: TimeInterval, timerType: MZTimerLabelType)
    @objc optional func timerLabel(_ timerLabel: MZTimerLabel, customTextToDisplayAt time: TimeInterval) -> String?
    @objc optional func timerLabel(_ timerLabel: MZTimerLabel, customAttributedTextToDisplayAt time: TimeInterval) -> NSAttributedString?
}

/**********************************************
 MZTimerLabel Class Definition
 **********************************************/
@objc class MZTimerLabel: UILabel {
    private let kHourFormatReplace = "!!!*"
    private let kDefaultFireIntervalNormal = 0.1
    private let kDefaultFireIntervalHighUse = 0.01
    
    private var timeUserValue: TimeInterval = 0
    private var startCountDate: Date? = nil
    private var pausedTime: Date?
    private var date1970 = Date(timeIntervalSince1970: 0)
    
    private var timeToCountOff = Date()
    
    private var timer: Timer?
    lazy private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_GB")
        formatter.timeZone = TimeZone(identifier: "GMT") //timeZoneWithName
        formatter.dateFormat = self.timeFormat
        return formatter
    }()

    /*NSBlock for finish of countdown timer */
    private(set) var endedBlock: ((TimeInterval) -> Void)?

    /*Delegate for finish of countdown timer */
    weak var delegate: MZTimerLabelDelegate?
    
    /*Time format wish to display in label*/
    var timeFormat = "HH:mm:ss" {
        didSet {
            self.dateFormatter.dateFormat = timeFormat
            self.updateLabel()
        }
    }
    
    /*Target label object, default self if you do not initWithLabel nor set*/
    weak var timeLabel: UILabel?
    
    /*Used for replace text in range */
    var textRange: Range<String.Index>?
    
    var attributesForTextInRange: [NSAttributedString.Key: Any]?
    
    /*Type to choose from stopwatch or timer*/
    var timerType: MZTimerLabelType = .timer {
        didSet {
            self.updateLabel()
        }
    }
    
    /*Is The Timer Running?*/
    private(set) var counting: Bool = false
    
    /*Do you want to reset the Timer after countdown?*/
    var resetTimerAfterFinish: Bool = false
    
    /*Do you want the timer to count beyond the HH limit from 0-23 e.g. 25:23:12 (HH:mm:ss) */
    var shouldCountBeyondHHLimit: Bool = false {
        didSet {
            self.updateLabel()
        }
    }
    
    /*--------Init methods to choose*/
    init(frame: CGRect = .zero, label: UILabel? = nil, timerType: MZTimerLabelType = MZTimerLabelType.timer) {
        super.init(frame: frame)
        if label == nil {
            self.timeLabel = self
        } else {
            self.timeLabel = label
        }
        self.timerType = timerType
        self.updateLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.timeLabel = self
    }
    
    /*--------Timer control methods to use*/
    func start() {
        //    #if NS_BLOCKS_AVAILABLE
        //    -(void)startWithEndingBlock:(void(^)(NSTimeInterval countTime))end;
        //    use it if you are not going to use delegate
        //    #endif
        timer?.invalidate()
        timer = nil
        if timeFormat.contains("SS") {
            timer = Timer(timeInterval: kDefaultFireIntervalHighUse, target: self, selector: #selector(updateLabel), userInfo: nil, repeats: true)
        } else {
            timer = Timer(timeInterval: kDefaultFireIntervalNormal, target: self, selector: #selector(updateLabel), userInfo: nil, repeats: true)
        }
        if let validTimer = timer {
            RunLoop.current.add(validTimer, forMode: .common)
        }
        
        if startCountDate == nil {
            startCountDate = Date()
            if self.timerType == .stopwatch && timeUserValue >= 0 {
                startCountDate = startCountDate?.addingTimeInterval(-1 * timeUserValue)
            }
        }
        if let validPausedTime = pausedTime,
            let validStartCountDate = startCountDate {
            let countedTime = validPausedTime.timeIntervalSince(validStartCountDate)
            startCountDate = Date().addingTimeInterval(-1 * countedTime)
            pausedTime = nil
        }
        counting = true
        timer?.fire()
    }
    
    // if NS_BLOCKS_AVAILABLE
    func start(with endingBlock: ((TimeInterval) -> Void)?) {
        self.endedBlock = endingBlock
        self.start()
    }
    
    func pause() {
        if counting {
            timer?.invalidate()
            timer = nil
            counting = false
            pausedTime = Date()
        }
    }
    
    func reset() {
        pausedTime = nil
        timeUserValue = (self.timerType == .stopwatch) ? 0 : timeUserValue
        startCountDate = self.counting ? Date() : nil
        self.updateLabel()
    }
    
    func addTimeCounted(by time: TimeInterval) {
        if timerType == .timer {
            self.setCountDown(time: time + timeUserValue)
        } else if timerType == .stopwatch,
            let newStartDate = startCountDate?.addingTimeInterval(-1 * time) {
            if Date().timeIntervalSince(newStartDate) <= 0 {
                //prevent less than 0
                startCountDate = Date()
            } else {
                startCountDate = newStartDate
            }
        }
        self.updateLabel()
    }
    
    
    /*--------Getter methods*/
    func getTimeCounted() -> TimeInterval {
        guard let validStartCountDate = startCountDate else {
            return 0
        }
        var countedTime = Date().timeIntervalSince(validStartCountDate)
        if let validPausedTime = pausedTime {
            let pauseCountedTime = Date().timeIntervalSince(validPausedTime)
            countedTime -= pauseCountedTime
        }
        return countedTime
    }
    
    func getTimeRemaining() -> TimeInterval {
        if timerType == .timer {
            return (timeUserValue - self.getTimeCounted())
        }
        return 0
    }
    
    func getCountDownTime() -> TimeInterval {
        if timerType == .timer {
            return timeUserValue
        }
        return 0
    }
    
    // MARK: - Cleanup
    
    override func removeFromSuperview() {
        timer?.invalidate()
        timer = nil
        super.removeFromSuperview()
    }
    
    // MARK: - Getter and Setter Method
    
    func setStopWatch(time: TimeInterval) {
        self.timeUserValue = (time < 0) ? 0 : time
        if timeUserValue > 0 {
            self.startCountDate = Date().addingTimeInterval(-1 * timeUserValue)
            self.pausedTime = Date()
            self.updateLabel()
        }
    }
    
    func setCountDown(time: TimeInterval) {
        self.timeUserValue = (time < 0) ? 0 : time
        timeToCountOff = date1970.addingTimeInterval(timeUserValue)
        self.updateLabel()
    }
    
    func setCountDownTo(date: Date) {
        let timeLeft = date.timeIntervalSince(Date())
        
        if timeLeft > 0 {
            self.timeUserValue = timeLeft
            self.timeToCountOff = date1970.addingTimeInterval(timeLeft)
        } else {
            self.timeUserValue = 0
            self.timeToCountOff = date1970.addingTimeInterval(0)
        }
        self.updateLabel()
    }
    
    deinit {
        timer?.invalidate()
    }
}

private extension MZTimerLabel {
    @objc func updateLabel() {
        var timeDiff: TimeInterval = 0
        if let startDate = startCountDate {
            timeDiff = Date().timeIntervalSince(startDate)
        }
        var timeToShow = Date()
        var timerEnded = false
        
        /***MZTimerLabelTypeStopWatch Logic***/
        if timerType == .stopwatch {
            if counting {
                timeToShow = date1970.addingTimeInterval(timeDiff)
            } else {
                //  timeToShow = date1970.addingTimeInterval(!startCountDate)?0:timeDiff)
                if let _ = startCountDate {
                    timeToShow = date1970.addingTimeInterval(timeDiff)
                } else {
                    timeToShow = date1970.addingTimeInterval(0)
                }
            }
            delegate?.timerLabel?(self, countingTo: timeDiff, timerType: timerType)
        } else {
            /***MZTimerLabelTypeTimer Logic***/
            if counting {
                let timeLeft = timeUserValue - timeDiff
                delegate?.timerLabel?(self, countingTo: timeLeft, timerType: timerType)
                if timeDiff >= timeUserValue {
                    self.pause()
                    timeToShow = date1970.addingTimeInterval(0)
                    startCountDate = nil
                    timerEnded = true
                } else {
                    timeToShow = timeToCountOff.addingTimeInterval(timeDiff * -1) //added 0.999 to make it actually counting the whole first second
                }
            } else {
                timeToShow = timeToCountOff
            }
        }
        //setting text value
        if let validDelegate = delegate,
            validDelegate.responds(to: #selector(MZTimerLabelDelegate.timerLabel(_:customTextToDisplayAt:))) {
            let atTime = timerType == .stopwatch ? timeDiff : ((timeUserValue - timeDiff) < 0 ? 0 : (timeUserValue - timeDiff))
            if let customText = delegate?.timerLabel?(self, customTextToDisplayAt: atTime), !customText.isEmpty {
                self.timeLabel?.text = customText
            } else {
                self.timeLabel?.text = self.dateFormatter.string(from: timeToShow)
            }
        } else if let validDelegate = delegate,
                validDelegate.responds(to: #selector(MZTimerLabelDelegate.timerLabel(_:customAttributedTextToDisplayAt:))) {
            let atTime = timerType == .stopwatch ? timeDiff : ((timeUserValue - timeDiff) < 0 ? 0 : (timeUserValue - timeDiff))
            if let customText = delegate?.timerLabel?(self, customAttributedTextToDisplayAt: atTime),
                !customText.string.isEmpty {
                self.timeLabel?.attributedText = customText
            } else {
                self.timeLabel?.text = self.dateFormatter.string(from: timeToShow)
            }
        } else {
            if shouldCountBeyondHHLimit {
                var beyondFormat = String(timeFormat)
                beyondFormat = beyondFormat.replacingOccurrences(of: "HH", with: kHourFormatReplace)
                beyondFormat = beyondFormat.replacingOccurrences(of: "H", with: kHourFormatReplace)
                self.dateFormatter.dateFormat = beyondFormat
                let hours = (timerType == .stopwatch) ? self.getTimeCounted() / 3600 : self.getTimeRemaining() / 3600
                let formattedDate = self.dateFormatter.string(from: timeToShow)
                let beyondedDate = formattedDate.replacingOccurrences(of: kHourFormatReplace, with: String(format: "%02.0f", hours))
                self.timeLabel?.text = beyondedDate
                self.dateFormatter.dateFormat = timeFormat
            } else {
                if let validRange = textRange, !validRange.isEmpty {
                    if let attributes = self.attributesForTextInRange,
                        !attributes.isEmpty {
                        let attrTextInRange = NSAttributedString(string: self.dateFormatter.string(from: timeToShow), attributes: attributes)
                        let attributedString = NSMutableAttributedString(string: self.text ?? "")
                        let nsRange = NSRange(validRange, in: self.text ?? "")
                        // Replace content in range with the new content
                        attributedString.replaceCharacters(in: nsRange, with: attrTextInRange)
                        self.timeLabel?.attributedText = attributedString
                    } else {
                        let labelText = self.text?.replacingCharacters(in: validRange, with: self.dateFormatter.string(from: timeToShow))
                        self.timeLabel?.text = labelText
                    }
                } else {
                    self.timeLabel?.text = self.dateFormatter.string(from: timeToShow)
                }
            }
        }
        
        if timerEnded {
            delegate?.timerLabel?(self, finishedCountDownTimerWith: timeUserValue)
            //if NS_BLOCKS_AVAILABLE
            self.endedBlock?(timeUserValue)
            if resetTimerAfterFinish {
                self.reset()
            }
        }
    }
}

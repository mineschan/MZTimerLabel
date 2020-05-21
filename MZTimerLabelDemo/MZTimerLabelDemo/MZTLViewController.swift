//
//  MZTLViewController.swift
//  MZTimerLabelDemo
//
//  Created by mines.chan on 16/10/13.
//  Converted to Swift by noorulain17 on 21/05/20.
//
//  Copyright (c) 2014- MineS Chan. All rights reserved.
//

import UIKit

class MZTLViewController: UIViewController, MZTimerLabelDelegate {
    
    var timerExample3: MZTimerLabel?
    var timerExample4: MZTimerLabel?
    var timerExample5: MZTimerLabel?
    var timerExample6: MZTimerLabel?
    var timerExample7: MZTimerLabel?
    var timerExample8: MZTimerLabel?
    var timerExample9: MZTimerLabel?
    var timerExample10: MZTimerLabel?
    var timerExample11: MZTimerLabel?
    var timerExample12: MZTimerLabel?
    var timerExample13: MZTimerLabel?

    @IBOutlet weak var demoView: UIScrollView?

    /*Controls for Example 1*/
    @IBOutlet weak var lblTimerExample1: MZTimerLabel?

    /*Controls for Example 3*/
    @IBOutlet weak var lblTimerExample3: UILabel!

    /*Controls for Example 4*/
    @IBOutlet weak var lblTimerExample4: UILabel!
    @IBOutlet weak var btnStartPauseExample4: UIButton!
    
    /*Controls and Methods for Example 5*/
    @IBOutlet weak var lblTimerExample5: UILabel!
    @IBOutlet weak var btnStartPauseExample5: UIButton!
    
    /*Controls and Methods for Example 6*/
    @IBOutlet weak var lblTimerExample6: UILabel!
    @IBOutlet weak var btnStartCountdownExample6: UIButton!
    
    /*Controls and Methods for Example 7*/
    @IBOutlet weak var lblTimerExample7: UILabel!
    @IBOutlet weak var btnStartCountdownExample7: UIButton!
    
    /*Controls and Methods for Example 8*/
    @IBOutlet weak var lblTimerExample8: UILabel!
    @IBOutlet weak var btnStartCountdownExample8: UIButton!
    @IBOutlet weak var btnAdd2SrcExample8: UIButton!
    
    /*Controls and Methods for Example 9*/
    @IBOutlet weak var lblTimerExample9: UILabel!

    /*Controls and Methods for Example 10*/
    @IBOutlet weak var lblTimerExample10: UILabel!

    /*Controls and Methods for Example 11*/
    @IBOutlet weak var lblTimerExample11: UILabel!
    
    /*Controls and Methods for Example 12*/
    @IBOutlet weak var lblTimerExample12: UILabel!
    
    /*Controls and Methods for Example 13*/
    @IBOutlet weak var lblTimerExample13: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MZTimerLabel Demo"
        demoView?.contentSize = CGSize(width: self.view.frame.size.width, height: 1700)
        
        /*******************************************
         * ------Example 1-----
         * Use timer on existing and styled MZTimerLabel from Storyboard/Xib, simplest usage.
         * REMARKS:initialize without TimerType using .stopwatch as default
         ********************************************/
        lblTimerExample1?.timerType = .stopwatch
        lblTimerExample1?.start()
        
        /*******************************************
         * ------Example 2-----
         * Using MZTimerLabel instance only and set difference time format
         ********************************************/
        let timer2 = MZTimerLabel(frame: CGRect(x: 0, y: 155, width: self.view.frame.size.width, height: 40), timerType: .stopwatch)
        demoView?.addSubview(timer2)
        //do some styling
        timer2.timeLabel?.backgroundColor = UIColor.clear
        timer2.timeLabel?.font = UIFont.systemFont(ofSize: 28.0)
        timer2.timeLabel?.textColor = UIColor.brown
        timer2.timeLabel?.textAlignment = .center
        //fire
        timer2.start()
        
        /*******************************************
         * ------Example 3-----
         * Count Down Timer
         ********************************************/
        timerExample3 = MZTimerLabel(label: lblTimerExample3, timerType: .timer)
        timerExample3?.setCountDown(time: 30*60) //** Or you can use timer3.setCountDownTo(date:aDate)
        timerExample3?.start()

        /*******************************************
         * ------Example 4-----
         * Stopwatch with controls and time format
         * Adjust starting Value
         ********************************************/
        timerExample4 = MZTimerLabel(label: lblTimerExample4, timerType: .stopwatch)
        timerExample4?.timeFormat = "HH:mm:ss SS"
            
        /*******************************************
         * ------Example 5-----
         * Countdown with controls and time format
         ********************************************/
        timerExample5 = MZTimerLabel(label: lblTimerExample5, timerType: .timer)
        timerExample5?.setCountDown(time: 10)
        
        /*******************************************
         * ------Example 6-----
         * Countdown finish callback with classic delegate way
         * implement - timerLabelEndCountDownTimer:withTime:
         ********************************************/
        timerExample6 = MZTimerLabel(label: lblTimerExample6, timerType: .timer)
        timerExample6?.setCountDown(time: 5)
        timerExample6?.resetTimerAfterFinish = true
        timerExample6?.delegate = self
        
        /*******************************************
         * ------Example 7-----
         * Countdown finish callback with convenient callback block
         * and showing how to set text of label after.
         ********************************************/
        timerExample7 = MZTimerLabel(label: lblTimerExample7, timerType: .timer)
        timerExample7?.setCountDown(time: 0)
        timerExample7?.resetTimerAfterFinish = false //IMPORTANT, if you needs custom text with finished, please do not set resetTimerAfterFinish to true.
        timerExample7?.timeFormat = "mm:ss SS"
        
        /*******************************************
         * ------Example 8-----
         * Stopwatch with progress delegate that will change the text to red color if time counted > 10
         * Button to add 2 seconds each time you press.
         ********************************************/
        timerExample8 = MZTimerLabel(label: lblTimerExample8)
        timerExample8?.timeFormat = "mm:ss"
        
        /*******************************************
         * ------Example 9-----
         * Use delegate to determine what text to be shown in corresponding time
         * This one display days as additional hours, see implementation below
         ********************************************/
        timerExample9 = MZTimerLabel(label: lblTimerExample9, timerType: .timer)
        timerExample9?.setCountDown(time: 3600*24*2)
        timerExample9?.delegate = self
        timerExample9?.start()
        
        /*******************************************
         * ------Example 10-----
         * Modify current counting timer of a stopwatch, see implementation below
         ********************************************/
        timerExample10 = MZTimerLabel(label: lblTimerExample10, timerType: .stopwatch)
        timerExample10?.start()
        
        /*******************************************
         * ------Example 11-----
         * Modify current counting timer of a countdown timer, see implementation below
         ********************************************/
        timerExample11 = MZTimerLabel(label: lblTimerExample11, timerType: .timer)
        timerExample11?.setCountDown(time: 3600)
        timerExample11?.start()
        
        /*******************************************
         * ------Example 12-----
         * You may need more than 23 hours display in some situation, like if you prefer showing 48 hours rather than 2days.
         * As MZTimerLabel uses DateFormatter to convert the time difference to String, there is no format string support
         * this purpose, so you may implement custom display text demo on example 9. Or set the property `shouldCountBeyondHHLimit` of
         * MZTimerLabel.
         * REMARKS: Only `HH` and `H` in the format string will be affected. Other hour format like "h", "k", "K" remain their own behaviour.
         ********************************************/
        timerExample12 = MZTimerLabel(label: lblTimerExample12, timerType: .stopwatch)
        timerExample12?.setStopWatch(time: 86395)
        timerExample12?.shouldCountBeyondHHLimit = true
        
        /*******************************************
         * ------Example 13-----
         * Countdown timer in text in custom range
         ********************************************/
        timerExample13 = MZTimerLabel(label: lblTimerExample13, timerType: .timer)
        timerExample13?.setCountDown(time: 999)
        let text = "timer here in text"
        let r = text.range(of: "here")
        let fgColor = UIColor.red
        let attributesForRange = [NSAttributedString.Key.foregroundColor: fgColor]
        timerExample13?.attributesForTextInRange = attributesForRange
        timerExample13?.text = text
        timerExample13?.textRange = r
        timerExample13?.timeFormat = "ss";
        timerExample13?.resetTimerAfterFinish = true
        timerExample13?.start()
    }
    
    /*******************************************
     * Method for Example 3
     ********************************************/
    @IBAction func getTimerCounted(_ sender: Any?) {
        guard let timeCounted = timerExample3?.getTimeCounted() else {
            return
        }
        let msg = String(format: "Timer of Example 3 counted: %f seconds", timeCounted)
        let alertController = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "Awesome!", style: .default) { _ in }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func getTimerRemain(_ sender: Any?) {
        guard let timeRemain = timerExample3?.getTimeRemaining() else {
            return
        }
        let msg = String(format: "Timer of Example 3 remaining: %f seconds", timeRemain)
        let alertController = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "Awesome!", style: .default) { _ in }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    /*******************************************
    * Method for Example 4
    ********************************************/
    @IBAction func startOrResumeStopwatch(_ sender: Any?) {
        if timerExample4?.counting ?? false {
            timerExample4?.pause()
            btnStartPauseExample4.setTitle("Resume", for: .normal)
        } else {
            timerExample4?.start()
            btnStartPauseExample4.setTitle("Pause", for: .normal)
        }
    }
    
    @IBAction func resetStopWatch(_ sender: Any?) {
        timerExample4?.reset()
        if !(timerExample4?.counting ?? false) {
            btnStartPauseExample4.setTitle("Start", for: .normal)
        }
    }
        
    /*******************************************
     * Method for Example 5
     ********************************************/
    @IBAction func startOrResumeCountDown(_ sender: Any?) {
        if timerExample5?.counting ?? false {
            timerExample5?.pause()
            btnStartPauseExample5.setTitle("Resume", for: .normal)
        }else{
            timerExample5?.start()
            btnStartPauseExample5.setTitle("Pause", for: .normal)
        }
    }
    
    @IBAction func resetCountDown(_ sender: Any?) {
        timerExample5?.reset()
        if !(timerExample5?.counting ?? false) {
            btnStartPauseExample5.setTitle("Start", for: .normal)
        }
    }
    
    /*******************************************
     * Method for Example 6
     ********************************************/
    @IBAction func startCountDownWithDelegate(_ sender: Any?) {
        if !(timerExample6?.counting ?? false) {
            timerExample6?.start()
        }
    }

    /*******************************************
     * Method for Example 7
     ********************************************/
    @IBAction func startCountDownWithBlock(_ sender: Any?) {
        if !(timerExample7?.counting ?? false) {
            timerExample7?.start(with: { [weak self] (countTime) in
                self?.timerExample7?.timeLabel?.text = "Timer Finished!"
                
                //or you can do this
                /*let msg = String(format: "Countdown of Example 7 finished!\nTime counted: %i seconds", countTime)
                let alertController = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
                let action = UIAlertAction(title: "Awesome!", style: .default) { _ in }
                alertController.addAction(action)
                self?.present(alertController, animated: true, completion: nil)
                 */
            })
            timerExample7?.start()
        }
    }
    
    /*******************************************
     * Method for Example 8
     ********************************************/
    @IBAction func startStopWatchWithProgressDelegate(_ sender: Any?) {
        timerExample8?.delegate = self
        timerExample8?.start()
    }

    /*******************************************
     * Method for Example 10
     ********************************************/
    @IBAction func add2SecondToCountingStopwatch(_ sender: Any?) {
        timerExample10?.addTimeCounted(by: 2)
    }
    
    @IBAction func minus2SecondToCountingStopwatch(_ sender: Any?) {
        timerExample10?.addTimeCounted(by: -2)
    }

    /*******************************************
    * Method for Example 11
    ********************************************/
    @IBAction func add2SecondToCountingTimer(_ sender: Any?) {
        timerExample11?.addTimeCounted(by: 2)
    }
    
    @IBAction func minus2SecondToCountingTimer(_ sender: Any?) {
        timerExample11?.addTimeCounted(by: -2)
    }
    
    /*******************************************
    * Method for Example 12
    ********************************************/
    @IBAction func startStopwatchBeyond23Hours(_ sender: Any?) {
        timerExample12?.start()
    }
    
    @IBAction func toggleStopwatchBeyond24Hours(_ sender: Any?) {
        timerExample12?.shouldCountBeyondHHLimit = !(timerExample12?.shouldCountBeyondHHLimit ?? false)
    }
    
    // MARK: - MZTimerLabel DELEGATE Methods
    
    /*******************************************
    * Delegate Method for Example 6
    ********************************************/
    func timerLabel(_ timerLabel: MZTimerLabel, finishedCountDownTimerWith countTime: TimeInterval) {
        let msg = String(format: "Countdown of Example 6 finished!\nTime counted: %i seconds", countTime)
        let alertController = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "Awesome!", style: .default) { _ in }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }

    /*******************************************
    * Delegate Method for Example 8
    ********************************************/
    func timerLabel(_ timerLabel: MZTimerLabel, countingTo: TimeInterval, timerType: MZTimerLabelType) {
        if timerLabel == timerExample8 && countingTo > 10 {
            timerLabel.timeLabel?.textColor = UIColor.red
        }
    }
    
    /*******************************************
    * Delegate Method for Example 9
    ********************************************/
    func timerLabel(_ timerLabel: MZTimerLabel, customTextToDisplayAt time: TimeInterval) -> String? {
        if timerLabel == timerExample9 {
            let second: Int = Int(time.truncatingRemainder(dividingBy: 60))
            let minute: Int = Int((time / 60).truncatingRemainder(dividingBy: 60))
            let hours: Int = Int(time / 3600)
            return String(format: "%02dh %02dm %02ds", hours, minute, second)
        } else {
            return nil
        }
    }
    
}

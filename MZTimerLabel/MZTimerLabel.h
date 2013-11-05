//
//  MZTimerLabel.h
//  Version 0.2
//  Created by MineS Chan on 2013-10-16
//  Updated 2013-11-05

// This code is distributed under the terms and conditions of the MIT license. 

// Copyright (c) 2013 MineS Chan
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

#import <UIKit/UIKit.h>


/**********************************************
 MZTimerLabel TimerType Enum
 **********************************************/
typedef enum{
    MZTimerLabelTypeStopWatch,
    MZTimerLabelTypeTimer
}MZTimerLabelType;


/**********************************************
 Delegate Methods
 @optional
 
  - timerLabel:finshedCountDownTimerWithTimeWithTime:
    ** MZTimerLabel Delegate method for finish of countdown timer

 - timerLabelCountingTo:timertype:
    ** MZTimerLabel Delegate method for monitering the current counting progress
**********************************************/
 
@class MZTimerLabel;
@protocol MZTimerLabelDelegate <NSObject>
@optional
-(void)timerLabel:(MZTimerLabel*)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime;
-(void)timerLabel:(MZTimerLabel*)timerlabel countingTo:(NSTimeInterval)time timertype:(MZTimerLabelType)timerType;
@end




/**********************************************
 MZTimerLabel Class Defination
 **********************************************/

@interface MZTimerLabel : UILabel{
    
#if NS_BLOCKS_AVAILABLE
    void (^endedBlock)(NSTimeInterval);
#endif
    
    NSTimeInterval timeUserValue;
    
    NSDate *startCountDate;
    NSDate *pausedTime;
    
    NSDate *date1970;
    NSDate *timeToCountOff;
}

/*Delegate for finish of countdown timer */
@property (strong) id<MZTimerLabelDelegate> delegate;

/*Time format wish to display in label*/
@property (nonatomic,strong) NSString *timeFormat;

/*Target label obejct, default self if you do not initWithLabel nor set*/
@property (strong) UILabel *timeLabel;

/*Type to choose from stopwatch or timer*/
@property (assign) MZTimerLabelType timerType;

/*is The Timer Running?*/
@property (assign,readonly) BOOL counting;

/*do you reset the Timer after countdown?*/
@property (assign) BOOL resetTimerAfterFinish;


/*--------Init method to choose*/
-(id)initWithTimerType:(MZTimerLabelType)theType;
-(id)initWithLabel:(UILabel*)theLabel andTimerType:(MZTimerLabelType)theType;
-(id)initWithLabel:(UILabel*)theLabel;


/*--------Timer control method to use*/
-(void)start;
#if NS_BLOCKS_AVAILABLE
-(void)startWithEndingBlock:(void(^)(NSTimeInterval countTime))end; //use it if you are not going to use delegate
#endif
-(void)pause;
-(void)reset;

/*--------Setter methods*/
-(void)setCountDownTime:(NSTimeInterval)time;
-(void)setStopWatchTime:(NSTimeInterval)time;


@end



//
//  MZTimerLabel.h
//  Version 0.4.1
//  Created by MineS Chan on 2013-10-16
//  Updated 2014-03-27

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

#import "MZTimerLabel.h"


#define kDefaultTimeFormat  @"HH:mm:ss"
#define kDefaultFireIntervalNormal  0.1
#define kDefaultFireIntervalHighUse  0.02
#define kDefaultTimerType MZTimerLabelTypeStopWatch

@interface MZTimerLabel(){
    
#if NS_BLOCKS_AVAILABLE
    void (^endedBlock)(NSTimeInterval);
#endif
    NSTimeInterval timeUserValue;
    NSDate *startCountDate;
    NSDate *pausedTime;
    NSDate *date1970;
    NSDate *timeToCountOff;
}

@property (strong) NSTimer *timer;
@property (nonatomic,strong) NSDateFormatter *dateFormatter;

- (void)setup;
- (void)updateLabel;

@end

#pragma mark - Initialize method

@implementation MZTimerLabel

@synthesize timeFormat = _timeFormat;

- (id)initWithTimerType:(MZTimerLabelType)theType{
    return [self initWithLabel:nil andTimerType:theType];
}

- (id)initWithLabel:(UILabel *)theLabel andTimerType:(MZTimerLabelType)theType
{
    self = [super init];
    
    if(self){
        self.timeLabel = theLabel;
        self.timerType = theType;
        [self setup];
    }
    return self;
}

- (id)initWithLabel:(UILabel*)theLabel{
    return [self initWithLabel:theLabel andTimerType:kDefaultTimerType];
}

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
	if (self) {
        [self setup];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self) {
        [self setup];
	}
	return self;
}

#pragma mark - Getter and Setter Method

- (void)setStopWatchTime:(NSTimeInterval)time{
    
    timeUserValue = (time < 0) ? 0 : time;
    if(timeUserValue > 0){
        startCountDate = [[NSDate date] dateByAddingTimeInterval:-timeUserValue];
        pausedTime = [NSDate date];
        [self updateLabel];
    }
}

- (void)setCountDownTime:(NSTimeInterval)time{
    
    timeUserValue = (time < 0)? 0 : time;
    timeToCountOff = [date1970 dateByAddingTimeInterval:timeUserValue];
    [self updateLabel];
}

-(void)setCountDownToDate:(NSDate*)date{
    NSTimeInterval timeLeft = (int)[date timeIntervalSinceDate:[NSDate date]];
    
    if (timeLeft > 0) {
        timeUserValue = timeLeft;
        timeToCountOff = [date1970 dateByAddingTimeInterval:timeLeft];
    }else{
        timeUserValue = 0;
        timeToCountOff = [date1970 dateByAddingTimeInterval:0];
    }
    [self updateLabel];

}

- (void)setTimeFormat:(NSString *)timeFormat{
    
    if ([timeFormat length] != 0) {
        _timeFormat = timeFormat;
        self.dateFormatter.dateFormat = timeFormat;
    }
    [self updateLabel];
}

- (NSString*)timeFormat
{
    if ([_timeFormat length] == 0 || _timeFormat == nil) {
        _timeFormat = kDefaultTimeFormat;
    }
    
    return _timeFormat;
}

- (NSDateFormatter*)dateFormatter{
    
    if (_dateFormatter == nil) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
        [_dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
        _dateFormatter.dateFormat = self.timeFormat;
    }
    return _dateFormatter;
}

- (UILabel*)timeLabel
{
    if (_timeLabel == nil) {
        _timeLabel = self;
    }
    return _timeLabel;
}


-(void)addTimeCountedByTime:(NSTimeInterval)timeToAdd
{
    startCountDate = [startCountDate dateByAddingTimeInterval:-timeToAdd];
    [self updateLabel];
}


- (NSTimeInterval)getTimeCounted
{
    NSTimeInterval countedTime = [[NSDate date] timeIntervalSinceDate:startCountDate];
    
    if(pausedTime != nil){
        NSTimeInterval pauseCountedTime = [[NSDate date] timeIntervalSinceDate:pausedTime];
        countedTime -= pauseCountedTime;
    }
    return countedTime;
}

#pragma mark - Timer Control Method


-(void)start{
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
    if ([self.timeFormat rangeOfString:@"SS"].location != NSNotFound) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:kDefaultFireIntervalHighUse target:self selector:@selector(updateLabel) userInfo:nil repeats:YES];
    }else{
        _timer = [NSTimer scheduledTimerWithTimeInterval:kDefaultFireIntervalNormal target:self selector:@selector(updateLabel) userInfo:nil repeats:YES];
    }
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
    if(startCountDate == nil){
        startCountDate = [NSDate date];
        
        if (self.timerType == MZTimerLabelTypeStopWatch && timeUserValue > 0) {
            startCountDate = [startCountDate dateByAddingTimeInterval:(timeUserValue<0)?0:-timeUserValue];
        }
    }
    if(pausedTime != nil){
        NSTimeInterval countedTime = [pausedTime timeIntervalSinceDate:startCountDate];
        startCountDate = [[NSDate date] dateByAddingTimeInterval:-countedTime];
        pausedTime = nil;
    }
    
    _counting = YES;
    [_timer fire];
}

#if NS_BLOCKS_AVAILABLE
-(void)startWithEndingBlock:(void(^)(NSTimeInterval))end{
    [self start];
    endedBlock = end;
}
#endif
    
-(void)pause{
    [_timer invalidate];
    _timer = nil;
    _counting = NO;
    pausedTime = [NSDate date];
}

-(void)reset{
    pausedTime = nil;
    timeUserValue = (self.timerType == MZTimerLabelTypeStopWatch)? 0 : timeUserValue;
    startCountDate = (self.counting)? [NSDate date] : nil;
    [self updateLabel];
}


#pragma mark - Private method

-(void)setup{
    date1970 = [NSDate dateWithTimeIntervalSince1970:0];
    [self updateLabel];
}


-(void)updateLabel{
    
    NSTimeInterval timeDiff = [[[NSDate alloc] init] timeIntervalSinceDate:startCountDate];
    NSDate *timeToShow = [NSDate date];
    
    /***MZTimerLabelTypeStopWatch Logic***/
    
    if(_timerType == MZTimerLabelTypeStopWatch){
        
        if (_counting) {
            timeToShow = [date1970 dateByAddingTimeInterval:timeDiff];
        }else{
            timeToShow = [date1970 dateByAddingTimeInterval:(!startCountDate)?0:timeDiff];
        }
        
        if([_delegate respondsToSelector:@selector(timerLabel:countingTo:timertype:)]){
            [_delegate timerLabel:self countingTo:timeDiff timertype:_timerType];
        }
    
    }else{
        
    /***MZTimerLabelTypeTimer Logic***/
        
        if (_counting) {
            
            if([_delegate respondsToSelector:@selector(timerLabel:countingTo:timertype:)]){
                NSTimeInterval timeLeft = timeUserValue - timeDiff;
                [_delegate timerLabel:self countingTo:timeLeft timertype:_timerType];
            }
                        
            if(timeDiff >= timeUserValue){
                [self pause];
                timeToShow = [date1970 dateByAddingTimeInterval:0];
                pausedTime = nil;
                startCountDate = nil;
                
                if([_delegate respondsToSelector:@selector(timerLabel:finshedCountDownTimerWithTime:)]){
                    [_delegate timerLabel:self finshedCountDownTimerWithTime:timeUserValue];
                }
                
#if NS_BLOCKS_AVAILABLE
                if(endedBlock != nil){
                    endedBlock(timeUserValue);
                }
#endif
                if(_resetTimerAfterFinish){
                    [self reset];
                    return;
                }
                
            }else{
                
                timeToShow = [timeToCountOff dateByAddingTimeInterval:(timeDiff*-1)+0.999]; //added 0.999 to make it actually counting the whole first second
            }
        }else{
            timeToShow = timeToCountOff;
        }
    }

    //setting text value
    if ([_delegate respondsToSelector:@selector(timerLabel:customTextToDisplayAtTime:)]) {
        NSTimeInterval atTime = (_timerType == MZTimerLabelTypeStopWatch) ? timeDiff : (timeUserValue - timeDiff);
        NSString *customtext = [_delegate timerLabel:self customTextToDisplayAtTime:atTime];
        if ([customtext length]) {
            self.timeLabel.text = customtext;
            return;
        }
    }
    
    NSString *strDate = [self.dateFormatter stringFromDate:timeToShow];
    self.timeLabel.text = strDate;
    
}

@end

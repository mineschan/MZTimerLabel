//
//  MZTimerLabel.m
//  Version 0.1
//  Created by MineS Chan on 2013-10-16
//

#import "MZTimerLabel.h"


#define kDefaultTimeFormat  @"HH:mm:ss"
#define kDefaultFireInterval  0.01


@interface MZTimerLabel()

@property (strong) NSTimer *timer;

-(void)setup;
-(void)updateLabel:(NSTimer*)timer;

@end

#pragma mark - Initialize method

@implementation MZTimerLabel

-(id)init{
    self = [super init];
    if (self) {
        _timeLabel = self;
        _timerType = MZTimerLabelTypeStopWatch;
    }
    return self;
}

-(id)initWithTimerType:(MZTimerLabelType)theType{
    return [self initWithLabel:nil andTimerType:theType];
}

-(id)initWithLabel:(UILabel *)theLabel andTimerType:(MZTimerLabelType)theType
{
    self = [super init];
    
    if(self){
        _timeLabel = theLabel;
        _timerType = theType;
        _timeValue = 0;
        [self setup];
    }
    return self;
}

-(id)initWithLabel:(UILabel*)theLabel{
    
    self = [super init];
    
    if(self){
        _timeLabel = theLabel;
        _timeValue = 0;
        _timerType = MZTimerLabelTypeStopWatch;
        [self setup];
    }
    return self;
}

#pragma mark - Getter and Setter Method
-(BOOL)isCounting{
    return _counting;
}

-(void)setTimeValue:(NSTimeInterval)timeValue{
    
    if (_timerType == MZTimerLabelTypeStopWatch && timeValue < 0) {
        timeValue = 0;
    }else if(_timerType == MZTimerLabelTypeTimer){
        timeValue += 0.98;
    }
    timeUserValue = timeValue;
    _timeValue = timeValue;
    
    [self updateLabel:nil];
}

-(void)setTimeFormat:(NSString *)timeFormat{
    
    _timeFormat = timeFormat;
    [self setup];
}

#pragma mark - Timer Control Method


-(void)start{
    [self setup];
    if(_timer == nil){
        _timer = [NSTimer scheduledTimerWithTimeInterval:kDefaultFireInterval target:self selector:@selector(updateLabel:) userInfo:nil repeats:YES];
        _counting = YES;
    }
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
}

-(void)reset{
    
    if(_timerType == MZTimerLabelTypeStopWatch){
        _timeValue = 0.000f;
    }else if(_timerType == MZTimerLabelTypeTimer){
        _timeValue = timeUserValue;
    }
    [self updateLabel:nil];
}


#pragma mark - Private method

-(void)setup{
    
    if ([_timeFormat length] == 0) {
        _timeFormat = kDefaultTimeFormat;
    }
    
    if(_timeLabel == nil){
        _timeLabel = self;
    }
    
    _timeValue = timeUserValue;
    
    _timeLabel.adjustsFontSizeToFitWidth = YES;
    [self updateLabel:nil];
}


-(void)updateLabel:(NSTimer*)timer{
    
    if (_timerType == MZTimerLabelTypeStopWatch) {
        
        if(_timer) _timeValue += kDefaultFireInterval;
        
    }else if(_timerType == MZTimerLabelTypeTimer){
        
        if(_timer) _timeValue -= kDefaultFireInterval;

        if(_timeValue <= 0){
            [self pause];
           
            if([_delegate respondsToSelector:@selector(timerLabelEndCountDownTimer:withTime:)]){
                [_delegate timerLabelEndCountDownTimer:self withTime:timeUserValue];
            }
            
#if NS_BLOCKS_AVAILABLE
            if(endedBlock != nil){
                endedBlock(timeUserValue);
            }
#endif
            if(_resetTimerAfterFinish){
                [self reset];
            }else{
                _timeValue = 0;
            }
        }
        
    }
    
    

    
    
    NSDate *timeStart = [NSDate dateWithTimeIntervalSince1970:0];
    NSDate *timeEnd = [timeStart dateByAddingTimeInterval:_timeValue];
   
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:_timeFormat];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSString *strDate = [dateFormatter stringFromDate:timeEnd];
    
    _timeLabel.text = strDate;
}

@end

//
//  MZTLViewController.m
//  MZTimerLabelDemo
//
//  Created by mines.chan on 16/10/13.
//  Copyright (c) 2014 MineS Chan. All rights reserved.
//

#import "MZTLViewController.h"
#import "MZTimerLabel.h"

@interface MZTLViewController ()

@end

@implementation MZTLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSArray* demoNib = [[NSBundle mainBundle] loadNibNamed:@"DemoView" owner:self options:nil];
    UIView *demoView = [demoNib lastObject];
    ((UIScrollView *)self.view).contentSize = CGSizeMake(self.view.frame.size.width, demoView.frame.size.height);
    
    
    /*******************************************
     * ------Example 1-----
     * Use timer on existing and styled MZTimerLabel from Storyboard/Xib, simplest usage.
     * REMARKS:initialize without TimerType using MZTimerLabelTypeStopWatch as default
     ********************************************/
    [_lblTimerExample1 start];
    
    /*******************************************
     * ------Example 2-----
     * Using MZTimerLabel instance only and set differene time format
     ********************************************/
    MZTimerLabel *timer2 = [[MZTimerLabel alloc] initWithFrame:CGRectMake(0, 155, self.view.frame.size.width, 40)];
    timer2.timerType = MZTimerLabelTypeStopWatch;
    [self.view addSubview:timer2];
    //do some styling
    timer2.timeLabel.backgroundColor = [UIColor clearColor];
    timer2.timeLabel.font = [UIFont systemFontOfSize:28.0f];
    timer2.timeLabel.textColor = [UIColor brownColor];
    timer2.timeLabel.textAlignment = NSTextAlignmentCenter; //UITextAlignmentCenter is deprecated in iOS 7.0
    //fire
    [timer2 start];
    
    
    /*******************************************
     * ------Example 3-----
     * Count Down Timer
     ********************************************/
    MZTimerLabel *timer3 = [[MZTimerLabel alloc] initWithLabel:_lblTimerExample3 andTimerType:MZTimerLabelTypeTimer];
    [timer3 setCountDownTime:30*60]; //** Or you can use [timer3 setCountDownToDate:aDate];
    [timer3 start];

    
    /*******************************************
     * ------Example 4-----
     * Stopwatch with controls and time format
     * Adjust starting Value
     ********************************************/
    timerExample4 = [[MZTimerLabel alloc] initWithLabel:_lblTimerExample4 andTimerType:MZTimerLabelTypeStopWatch];
    [timerExample4 setStopWatchTime:5];
    timerExample4.timeFormat = @"HH:mm:ss SS";
    
    
    /*******************************************
     * ------Example 5-----
     * Countdown with controls and time format
     ********************************************/
    timerExample5 = [[MZTimerLabel alloc] initWithLabel:_lblTimerExample5 andTimerType:MZTimerLabelTypeTimer];
    [timerExample5 setCountDownTime:10];

    
    /*******************************************
     * ------Example 6-----
     * Countdown finish callback with classic delegate way
     * implement - timerLabelEndCountDownTimer:withTime:
     ********************************************/
    timerExample6 = [[MZTimerLabel alloc] initWithLabel:_lblTimerExample6 andTimerType:MZTimerLabelTypeTimer];
    [timerExample6 setCountDownTime:5];
    timerExample6.delegate = self;
    
    /*******************************************
     * ------Example 7-----
     * Countdown finish callback with convenient callback block
     ********************************************/
    timerExample7 = [[MZTimerLabel alloc] initWithLabel:_lblTimerExample7 andTimerType:MZTimerLabelTypeTimer];
    [timerExample7 setCountDownTime:5];
    timerExample7.resetTimerAfterFinish = YES;
    timerExample7.timeFormat = @"mm:ss SS";
    
    /*******************************************
     * ------Example 8-----
     * Stopwatch with progress delegate that will change the text to red color if time counted > 10
     * Button to add 2 seconds each time you press.
     ********************************************/
    timerExample8 = [[MZTimerLabel alloc] initWithLabel:_lblTimerExample8];
    timerExample8.timeFormat = @"mm:ss";
    
    
    /*******************************************
     * ------Example 9-----
     * Use delegate to determine what text to be shown in corresponding time
     * This one display days as addtional hours, see implementation at line number 218
     ********************************************/
   
    timerExample9 = [[MZTimerLabel alloc] initWithLabel:_lblTimerExample9 andTimerType:MZTimerLabelTypeTimer];
    [timerExample9 setCountDownTime:3600*24*2];
    timerExample9.delegate = self;
    [timerExample9 start];

}

/*******************************************
 * Method for Example 4
 ********************************************/
- (IBAction)startOrResumeStopwatch:(id)sender {

    if([timerExample4 counting]){
        [timerExample4 pause];
        [_btnStartPauseExample4 setTitle:@"Resume" forState:UIControlStateNormal];
    }else{
        [timerExample4 start];
        [_btnStartPauseExample4 setTitle:@"Pause" forState:UIControlStateNormal];
    }
}

- (IBAction)resetStopWatch:(id)sender {
    [timerExample4 reset];
    
    if(![timerExample4 counting]){
        [_btnStartPauseExample4 setTitle:@"Start" forState:UIControlStateNormal];
    }
}


/*******************************************
 * Method for Example 5
 ********************************************/

- (IBAction)startOrResumeCountDown:(id)sender {
    
    if([timerExample5 counting]){
        [timerExample5 pause];
        [_btnStartPauseExample5 setTitle:@"Resume" forState:UIControlStateNormal];
    }else{
        [timerExample5 start];
        [_btnStartPauseExample5 setTitle:@"Pause" forState:UIControlStateNormal];
    }
    
}

- (IBAction)resetCountDown:(id)sender {
    [timerExample5 reset];
    
    if(![timerExample5 counting]){
        [_btnStartPauseExample5 setTitle:@"Start" forState:UIControlStateNormal];
    }
}

/*******************************************
 * Method for Example 6
 ********************************************/
- (IBAction)startCountDownWithDelegate:(id)sender {
    
    if(![timerExample6 counting]){
        [timerExample6 start];
    }
}

- (void)timerLabel:(MZTimerLabel*)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime{
    
    NSString *msg = [NSString stringWithFormat:@"Countdown of Example 6 finished!\nTime counted: %i seconds",(int)countTime];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:msg delegate:nil cancelButtonTitle:@"Awesome!" otherButtonTitles:nil];
    [alertView show];
}


/*******************************************
 * Method for Example 7
 ********************************************/
- (IBAction)startCountDownWithBlock:(id)sender {
    
    if(![timerExample7 counting]){
        [timerExample7 startWithEndingBlock:^(NSTimeInterval countTime) {
            
            NSString *msg = [NSString stringWithFormat:@"Countdown of Example 7 finished!\nTime counted: %i seconds",(int)countTime];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:msg delegate:nil cancelButtonTitle:@"Awesome!" otherButtonTitles:nil];
            [alertView show];
        }];
    }
    
}

/*******************************************
 * Method for Example 8
 ********************************************/

- (void)timerLabel:(MZTimerLabel *)timerlabel countingTo:(NSTimeInterval)time timertype:(MZTimerLabelType)timerType{
    
    if([timerlabel isEqual:timerExample8] && time > 10){
        timerlabel.timeLabel.textColor = [UIColor redColor];
    }
    
}

- (IBAction)startStopWatchWithProgressDelegate:(id)sender{
    timerExample8.delegate = self;
    [timerExample8 start];
}

- (IBAction)add2SecondToCountingObject
{
    [timerExample8 addTimeCountedByTime:2];
}


/*******************************************
 * Method for Example 9
 ********************************************/

- (NSString*)timerLabel:(MZTimerLabel *)timerLabel customTextToDisplayAtTime:(NSTimeInterval)time
{
    if([timerLabel isEqual:timerExample9]){
        int second = (int)time  % 60;
        int minute = ((int)time / 60) % 60;
        int hours = time / 3600;
        return [NSString stringWithFormat:@"%02dh %02dm %02ds",hours,minute,second];
    }
    else
    return nil;
}


@end

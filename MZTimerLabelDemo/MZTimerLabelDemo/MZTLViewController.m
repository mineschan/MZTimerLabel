//
//  MZTLViewController.m
//  MZTimerLabelDemo
//
//  Created by mines.chan on 16/10/13.
//  Copyright (c) 2013 MineS Chan. All rights reserved.
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
    ((UIScrollView *)self.view).contentSize = CGSizeMake(self.view.frame.size.width, 920);
    
    
    /*******************************************
     * ------Example 1-----
     * Use timer on existing and styled UILabel, simplest usage. 
     * REMARKS:initialize without TimerType using MZTimerLabelTypeStopWatch as default
     ********************************************/
    MZTimerLabel *timer1 = [[MZTimerLabel alloc]initWithLabel:_lblTimerExample1];
    timer1.delegate = self;
    [timer1 setStopWatchTime:10];
    [timer1 start];
    
    
    /*******************************************
     * ------Example 2-----
     * Using itselfs as the label and set differene time format
     ********************************************/
    MZTimerLabel *timer2 = [[MZTimerLabel alloc] initWithTimerType:MZTimerLabelTypeStopWatch];
    [self.view addSubview:timer2];
        //do some styling
    timer2.frame = CGRectMake(0, 155, self.view.frame.size.width, 40);
    timer2.backgroundColor = [UIColor clearColor];
    timer2.font = [UIFont systemFontOfSize:28.0f];
    timer2.textColor = [UIColor brownColor];
    timer2.textAlignment = NSTextAlignmentCenter; //UITextAlignmentCenter is deprecated in iOS 7.0
        //fire
    [timer2 start];
    
    
    /*******************************************
     * ------Example 3-----
     * Count Down Timer
     ********************************************/
    MZTimerLabel *timer3 = [[MZTimerLabel alloc] initWithLabel:_lblTimerExample3 andTimerType:MZTimerLabelTypeTimer];
    [timer3 setCountDownTime:15];
    [timer3 start];

    
    /*******************************************
     * ------Example 4-----
     * Stopwatch with controls and time format
     * Reveals using implement method belows
     ********************************************/
    timerExample4 = [[MZTimerLabel alloc] initWithLabel:_lblTimerExample4 andTimerType:MZTimerLabelTypeStopWatch];
    timerExample4.timeFormat = @"HH:mm:ss SS";
    
    
    /*******************************************
     * ------Example 5-----
     * Countdown with controls and time format
     * Reveals using implement method belows
     ********************************************/
    timerExample5 = [[MZTimerLabel alloc] initWithLabel:_lblTimerExample5 andTimerType:MZTimerLabelTypeTimer];
    [timerExample5 setCountDownTime:5];
    
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

-(void)timerLabel:(MZTimerLabel*)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime{
    
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



@end

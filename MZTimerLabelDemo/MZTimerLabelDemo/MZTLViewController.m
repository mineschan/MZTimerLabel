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
    timerExample3 = [[MZTimerLabel alloc] initWithLabel:_lblTimerExample3 andTimerType:MZTimerLabelTypeTimer];
    [timerExample3 setCountDownTime:30*60]; //** Or you can use [timer3 setCountDownToDate:aDate];
    [timerExample3 start];

    
    /*******************************************
     * ------Example 4-----
     * Stopwatch with controls and time format
     * Adjust starting Value
     ********************************************/
    timerExample4 = [[MZTimerLabel alloc] initWithLabel:_lblTimerExample4 andTimerType:MZTimerLabelTypeStopWatch];
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
    timerExample6.resetTimerAfterFinish = YES;
    timerExample6.delegate = self;
    
    /*******************************************
     * ------Example 7-----
     * Countdown finish callback with convenient callback block
     * and showing how to set text of label after.
     ********************************************/
    timerExample7 = [[MZTimerLabel alloc] initWithLabel:_lblTimerExample7 andTimerType:MZTimerLabelTypeTimer];
    [timerExample7 setCountDownTime:0];
    timerExample7.resetTimerAfterFinish = NO; //IMPORTANT, if you needs custom text with finished, please do not set resetTimerAfterFinish to YES.
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
     * This one display days as addtional hours, see implementation below
     ********************************************/
   
    timerExample9 = [[MZTimerLabel alloc] initWithLabel:_lblTimerExample9 andTimerType:MZTimerLabelTypeTimer];
    [timerExample9 setCountDownTime:3600*24*2];
    timerExample9.delegate = self;
    [timerExample9 start];
    
    /*******************************************
     * ------Example 10-----
     * Modify current couting timer of a stopwatch, see implemention below
     ********************************************/
    
    timerExample10 = [[MZTimerLabel alloc] initWithLabel:_lblTimerExample10 andTimerType:MZTimerLabelTypeStopWatch];
    [timerExample10 start];
    
    /*******************************************
     * ------Example 11-----
     * Modify current couting timer of a countdown timer, see implemention below
     ********************************************/
    
    timerExample11 = [[MZTimerLabel alloc] initWithLabel:_lblTimerExample11 andTimerType:MZTimerLabelTypeTimer];
    [timerExample11 setCountDownTime:3600];
    [timerExample11 start];
    
    /*******************************************
     * ------Example 12-----
     * You may need more than 23 hours display in some situation, like if you prefer showing 48 hours rather than 2days.
     * As MZTimerLabel uses NSDateFormatter to convert the time difference to String, there is no format string support 
     * this purpose, so you may implement custom display text demo om example 9. Or set the property `shouldCountBeyondHHLimit` of
     * MZTimerLabel. 
     * REMARKS: Only `HH` and `H` in the format string will be affected. Other hour format like "h", "k", "K" remain their own behaviour.
     ********************************************/
    
    timerExample12 = [[MZTimerLabel alloc] initWithLabel:_lblTimerExample12 andTimerType:MZTimerLabelTypeStopWatch];
    [timerExample12 setStopWatchTime:86395];
    [timerExample12 setShouldCountBeyondHHLimit:YES];
    
    /*******************************************
     * ------Example 13-----
     * Countdown timer in text in custom range
     ********************************************/
    
    timerExample13 = [[MZTimerLabel alloc] initWithLabel:_lblTimerExample13 andTimerType:MZTimerLabelTypeTimer];
    [timerExample13 setCountDownTime:999];
    NSString* text = @"timer here in text";
    NSRange r = [text rangeOfString:@"here"];
    
    UIColor* fgColor = [UIColor redColor];
    NSDictionary* attributesForRange = @{
                            NSForegroundColorAttributeName: fgColor,
                            };
    timerExample13.attributedDictionaryForTextInRange = attributesForRange;
    timerExample13.text = text;
    timerExample13.textRange = r;
    timerExample13.timeFormat = @"ss";
    timerExample13.resetTimerAfterFinish = YES;
    [timerExample13 start];

}

/*******************************************
 * Method for Example 3
 ********************************************/

- (IBAction)getTimerCounted:(id)sender {
    
    NSTimeInterval timeCounted = [timerExample3 getTimeCounted];
    
    NSString *msg = [NSString stringWithFormat:@"Timer of Example 3 counted: %f seconds",timeCounted];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:msg delegate:nil cancelButtonTitle:@"Awesome!" otherButtonTitles:nil];
    [alertView show];
}

- (IBAction)getTimerRemain:(id)sender {
    
    NSTimeInterval timeRemain = [timerExample3 getTimeRemaining];
    
    NSString *msg = [NSString stringWithFormat:@"Timer of Example 3 remaining: %f seconds",timeRemain];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:msg delegate:nil cancelButtonTitle:@"Awesome!" otherButtonTitles:nil];
    [alertView show];
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
            timerExample7.timeLabel.text = @"Timer Finished!";
        }];
        
        //or you can do this
        /*
        timerExample7.endedBlock = ^(NSTimeInterval countTime) {
            NSString *msg = [NSString stringWithFormat:@"Countdown of Example 7 finished!\nTime counted: %i seconds",(int)countTime];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:msg delegate:nil cancelButtonTitle:@"Awesome!" otherButtonTitles:nil];
            [alertView show];
        };
        [timerExample7 start];
         */
    }
    
}

/*******************************************
 * Method for Example 8
 ********************************************/

/*****THIS IS MZTimerLabel DELEGATE Method*****/
- (void)timerLabel:(MZTimerLabel *)timerlabel countingTo:(NSTimeInterval)time timertype:(MZTimerLabelType)timerType{
    
    if([timerlabel isEqual:timerExample8] && time > 10){
        timerlabel.timeLabel.textColor = [UIColor redColor];
    }
    
}

- (IBAction)startStopWatchWithProgressDelegate:(id)sender{
    timerExample8.delegate = self;
    [timerExample8 start];
}

/*******************************************
 * Delegate Method for Example 9
 ********************************************/

/*****THIS IS MZTimerLabel DELEGATE Method*****/
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

/*******************************************
 * Method for Example 10
 ********************************************/

- (IBAction)add2SecondToCountingStopwatch:(id)sender {
    [timerExample10 addTimeCountedByTime:2];
}

- (IBAction)minus2SecondToCountingStopwatch:(id)sender {
    [timerExample10 addTimeCountedByTime:-2];
}

/*******************************************
 * Method for Example 11
 ********************************************/

- (IBAction)add2SecondToCountingTimer:(id)sender {
    [timerExample11 addTimeCountedByTime:2];
}

- (IBAction)minus2SecondToCountingTimer:(id)sender {
    [timerExample11 addTimeCountedByTime:-2];
}

/*******************************************
 * Method for Example 12
 ********************************************/

- (IBAction)startStopwatchBeyond23Hours:(id)sender {
    [timerExample12 start];
}

- (IBAction)toggleStopwatchBeyond24Hours:(id)sender {
    [timerExample12 setShouldCountBeyondHHLimit:!timerExample12.shouldCountBeyondHHLimit];
}

@end

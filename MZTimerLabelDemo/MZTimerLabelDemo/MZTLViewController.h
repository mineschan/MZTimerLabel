//
//  MZTLViewController.h
//  MZTimerLabelDemo
//
//  Created by mines.chan on 16/10/13.
//  Copyright (c) 2014 MineS Chan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZTimerLabel.h"

@interface MZTLViewController : UIViewController<MZTimerLabelDelegate>{
    MZTimerLabel *timerExample3;
    MZTimerLabel *timerExample4;
    MZTimerLabel *timerExample5;
    MZTimerLabel *timerExample6;
    MZTimerLabel *timerExample7;
    MZTimerLabel *timerExample8;
    MZTimerLabel *timerExample9;
    MZTimerLabel *timerExample10;
    MZTimerLabel *timerExample11;
    MZTimerLabel *timerExample12;
    MZTimerLabel *timerExample13;
}

/*Controls for Example 1*/
@property (weak, nonatomic) IBOutlet MZTimerLabel *lblTimerExample1;


/*Controls for Example 3*/
@property (weak, nonatomic) IBOutlet UILabel *lblTimerExample3;
- (IBAction)getTimerCounted:(id)sender;
- (IBAction)getTimerRemain:(id)sender;


/*Controls and Methods for Example 4*/
@property (weak, nonatomic) IBOutlet UILabel *lblTimerExample4;
@property (weak, nonatomic) IBOutlet UIButton *btnStartPauseExample4;
- (IBAction)startOrResumeStopwatch:(id)sender;
- (IBAction)resetStopWatch:(id)sender;


/*Controls and Methods for Example 5*/
@property (weak, nonatomic) IBOutlet UILabel *lblTimerExample5;
@property (weak, nonatomic) IBOutlet UIButton *btnStartPauseExample5;
- (IBAction)startOrResumeCountDown:(id)sender;
- (IBAction)resetCountDown:(id)sender;


/*Controls and Methods for Example 6*/
@property (weak, nonatomic) IBOutlet UILabel *lblTimerExample6;
@property (weak, nonatomic) IBOutlet UIButton *btnStartCountdownExample6;
- (IBAction)startCountDownWithDelegate:(id)sender;


/*Controls and Methods for Example 7*/
@property (weak, nonatomic) IBOutlet UILabel *lblTimerExample7;
@property (weak, nonatomic) IBOutlet UIButton *btnStartCountdownExample7;
- (IBAction)startCountDownWithBlock:(id)sender;

/*Controls and Methods for Example 8*/
@property (weak, nonatomic) IBOutlet UILabel *lblTimerExample8;
@property (weak, nonatomic) IBOutlet UIButton *btnStartCountdownExample8;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd2SrcExample8;
- (IBAction)startStopWatchWithProgressDelegate:(id)sender;

/*Controls and Methods for Example 9*/
@property (weak, nonatomic) IBOutlet UILabel *lblTimerExample9;

/*Controls and Methods for Example 10*/
@property (weak, nonatomic) IBOutlet UILabel *lblTimerExample10;

- (IBAction)add2SecondToCountingStopwatch:(id)sender;
- (IBAction)minus2SecondToCountingStopwatch:(id)sender;

/*Controls and Methods for Example 11*/
@property (weak, nonatomic) IBOutlet UILabel *lblTimerExample11;
- (IBAction)add2SecondToCountingTimer:(id)sender;
- (IBAction)minus2SecondToCountingTimer:(id)sender;

/*Controls and Methods for Example 12*/
@property (weak, nonatomic) IBOutlet UILabel *lblTimerExample12;
- (IBAction)startStopwatchBeyond23Hours:(id)sender;
- (IBAction)toggleStopwatchBeyond24Hours:(id)sender;

/*Controls and Methods for Example 13*/
@property (weak, nonatomic) IBOutlet UILabel *lblTimerExample13;

@end

MZTimerLabel
============


![License](https://cocoapod-badges.herokuapp.com/l/MZTimerLabel/badge.(png|svg))
![Platforms](https://cocoapod-badges.herokuapp.com/p/MZTimerLabel/badge.png)
[![Cocoapod Latest Version](http://img.shields.io/cocoapods/v/MZTimerLabel.svg?style=flat)](https://cocoapods.org/?q=MZTimerLabel)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Downloads with CocoaPods](https://img.shields.io/cocoapods/dt/MZTimerLabel.svg)](https://cocoapods.org/pods/MZTimerLabel)


<img align="center" src="https://raw.github.com/mineschan/MZTimerLabel/master/demo.gif" alt="ScreenShot" width="300">
<img align="center" src="https://raw.github.com/mineschan/MZTimerLabel/master/MZTimerLabel_Demo2.png" alt="ScreenShot2" width="300">

### Purpose

MZTimerLabel is a UILabel subclass, which is a handy way to use UILabel as a countdown timer or stopwatch just like that in Apple Clock App with just __2 lines of code__. MZTimerLabel also provides delegate method for you to define the action when the timer finished.

Author: [MineS Chan](https://github.com/mineschan/) and awesome [contributors](https://github.com/mineschan/MZTimerLabel/graphs/contributors).

_Remark: This is my first iOS plugin project on GitHub, please accept my apologize if any bad coding._

### Requirements
* iOS 10.0+
* Swift 5.0

### Installations

#### Manual

1. Download or clone MZTimerLabel, add `MZTimerLabel.swift` source files into your project.
2. `import MZTimerLabel` wherever you need it.

#### CocoaPods

(Unfamiliar with [CocoaPods](http://cocoapods.org/) yet? It's a dependency management tool for iOS and Mac, check it out!)

```
pod 'MZTimerLabel'
```

#### Carthage
Another dependency manager is [Carthage](http://github.com/Carthage/Carthage), which does not have a centralized repository.

```
github "mineschan/MZTimerLabel"
```

### Easy Example

To use MZTimerLabel as a stopwatch and counter, you need only __2 lines__.
 ```objective-c
    MZTimerLabel *stopwatch = [[MZTimerLabel alloc] initWithLabel:aUILabel];
    [stopwatch start];
 ```
 
 ```swift
    let stopwatch = MZTimerLabel(label: aUILabel)
    stopwatch.start()
 ```

Easy? If you are looking for a timer, things is just similar.
 ```objective-c
    MZTimerLabel *timer = [[MZTimerLabel alloc] initWithLabel:aUILabel andTimerType:MZTimerLabelTypeTimer];
    [timer setCountDownTime:60];
    [timer start];
 ```
 
 ```swift
    let timer = MZTimerLabel(label: aUILabel, timerType: .timer)
    timer.setCountDown(time:60)
    timer.start()
 ```

Now the timer will start counting from 60 to 0 ;)

### Custom Appearance

As MZTimerLabel is a UILabel subclass, you can directly allocate it as a normal UILabel and customize `timeLabel` property just like usual.

 ```objective-c
    MZTimerLabel *redStopwatch = [[MZTimerLabel alloc] init];
    redStopwatch.frame = CGRectMake(100,50,100,20);
    redStopwatch.timeLabel.font = [UIFont systemFontOfSize:20.0f];
    redStopwatch.timeLabel.textColor = [UIColor redColor];
    [self.view addSubview:redStopwatch];
    [redStopwatch start];
 ```
 
 ```swift
    let redStopwatch = MZTimerLabel()
    redStopwatch.frame = CGRect(x: 100, y:50, width: 100, height: 20)
    redStopwatch.timeLabel.font = UIFont(systemFontOf: 20.0)
    redStopwatch.timeLabel.textColor = UIColor.red
    self.view.addSubview(redStopwatch)
    redStopwatch.start()
 ```
 
MZTimerLabel uses `00:00:00 (HH:mm:ss)` as time format, if you prefer using another format such as including milliseconds.Your can set your time format like below.

```objective-c
    timerExample.timeFormat = @"HH:mm:ss SS";
```

```swift
    timerExample.timeFormat = "HH:mm:ss SS"
```
 
 
### Control the timer

You can start, pause, reset your timer with your custom control, set your control up and call these methods:

```
func start()
func pause()
func reset()
```

#### Getter and Setters

You may control the time value and behaviours at the beginning or during runtime with these properties and methods

```
var shouldCountBeyondHHLimit: Bool   //see example #12
var resetTimerAfterFinish: Bool      //see example #7

func setCountDown(time: TimeInterval)
func setStopWatch(time: TimeInterval)
func setCountDownTo(date: Date)
func addTimeCounted(by time: TimeInterval)  //see example #10, #11
```

And if you want to have information of the timer, here is how.

```
private(set) var counting: Bool         //see example #4-7

func getTimeCounted() -> TimeInterval   //see example #3
func getTimeRemaining() -> TimeInterval //see example #3
func getCountDownTime() -> TimeInterval
```

### Timer Finish Handling

Usually when you need a timer, you need to deal with it after it finished. Following are 2 examples showing how to do it using `delegate` and `block` methods.

#### Delegate

First, set the delegate of the timer label.

`timer.delegate = self;`

And then implement `MZTimerLabelDelegate` protocol in your dedicated class

`@interface ViewController : UIViewController<MZTimerLabelDelegate>`
or
`class ViewController : UIViewController, MZTimerLabelDelegate`

Finally, implement the delegate method `timerLabel(_ timerLabel: MZTimerLabel, finishedCountDownTimerWith countTime: TimeInterval)`


 ```objective-c
 -(void)timerLabel:(MZTimerLabel*)timerLabel finishedCountDownTimerWithCountTime:(NSTimeInterval)countTime{
    //time is up, what should I do master?
 }
 ```
 
 ```swift
 func timerLabel(_ timerLabel: MZTimerLabel, finishedCountDownTimerWith countTime: TimeInterval) {
    //time is up, what should I do master?
 }
 ```
 
#### Blocks
 
 Block is a very convenient way to handle the callbacks, MZTimerLabel makes your life even easier.
 
 ```objective-c
 
    MZTimerLabel *timer = [[MZTimerLabel alloc] initWithLabel:aUILabel andTimerType:MZTimerLabelTypeTimer];
    [timer setCountDownTime:60]; 
    [timer startWithEndingBlock:^(NSTimeInterval countTime) {
        //oh my gosh, it's awesome!!
    }];
 
 ```
 
 ```swift
 
    let timer = MZTimerLabel(label: aUILabel timerType: .timer)
    timer.setCountDown(time: 60) 
    timer.start(with: { (countTime) in
        //oh my gosh, it's awesome!!
    })
 
```

 
### More Examples

Please check the demo project I provided, with well explained example code inside.
 
### License
This code is distributed under the terms and conditions of the [MIT license](LICENSE). 


### What's coming up next?

1. ~~Submit to CocoaPods~~
2. ~~Better performance.~~
3. ~~Swift 5 conversion~~
4. __Your suggestions! :D__

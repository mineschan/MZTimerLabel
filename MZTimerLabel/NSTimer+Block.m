//
//  NSTimer+Block.m
//  SuperCalculator
//
//  Created by Peng Wang on 2016/12/14.
//  Copyright © 2016年 youdao. All rights reserved.
//

#import "NSTimer+Block.h"

@implementation NSTimer (Block)

+ (NSTimer*)scheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(void(^)())block repeats:(BOOL)repeats{
  
    return [self scheduledTimerWithTimeInterval:interval
                                         target:self
                                       selector:@selector(blockInvoke:)
                                       userInfo:[block copy]
                                        repeats:repeats];
}

+ (void)blockInvoke:(NSTimer*)timer {
    
    void (^block)() = timer.userInfo;
    if (block) {
        block();
    }
}

@end

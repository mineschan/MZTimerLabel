//
//  NSTimer+Block.h
//  SuperCalculator
//
//  Created by Peng Wang on 2016/12/14.
//  Copyright © 2016年 youdao. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 NSTimer (Block) is used to solving retain cycle below ios10.0
 
 if is ios10.0 ,we can use method:
 + (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block API_AVAILABLE(macosx(10.12), ios(10.0), watchos(3.0), tvos(10.0));
 
 */
@interface NSTimer (Block)

+ (NSTimer*)scheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(void(^)())block repeats:(BOOL)repeats;

@end

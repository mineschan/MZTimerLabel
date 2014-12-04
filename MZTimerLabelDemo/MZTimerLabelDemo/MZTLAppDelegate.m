//
//  MZTLAppDelegate.m
//  MZTimerLabelDemo
//
//  Created by mines.chan on 16/10/13.
//  Copyright (c) 2013 MineS Chan. All rights reserved.
//

#import "MZTLAppDelegate.h"
#import "MZTLViewController.h"

@implementation MZTLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	_window.rootViewController = _navController;
	[_window makeKeyAndVisible];
    return YES;
}
@end

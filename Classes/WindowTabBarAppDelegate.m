//
//  WindowTabBarAppDelegate.m
//  WindowTabBar
//
//  Created by zaab on 04/011/10.
//  Copyright fizaboun 2010. All rights reserved.
//

#import "WindowTabBarAppDelegate.h"

@implementation WindowTabBarAppDelegate

@synthesize window , tabbarController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    

    // Override point for customization after application launch
	
    [window addSubview:tabbarController.view];
	[window makeKeyAndVisible];
	
	return YES;
}


- (void)dealloc {
	[tabbarController release];
    [window release];
    [super dealloc];
}


@end

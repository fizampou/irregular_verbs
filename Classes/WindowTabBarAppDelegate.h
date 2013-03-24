//
//  WindowTabBarAppDelegate.h
//  WindowTabBar
//
//  Created by zaab on 04/011/10.
//  Copyright fizaboun 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WindowTabBarAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UITabBarController *tabbarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic,retain) IBOutlet UITabBarController *tabbarController;

@end


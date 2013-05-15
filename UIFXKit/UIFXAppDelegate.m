//
//  UIFXAppDelegate.m
//  UIFXKit
//
//  Created by Tyler Casselman on 5/11/13.
//  Copyright (c) 2013 Casselman Consulting. All rights reserved.
//

#import "UIFXAppDelegate.h"
#import "UIFXWindow.h"
@interface UIFXAppDelegate ()
@property (strong, nonatomic) UIFXWindow *fxWindow;
@end

@implementation UIFXAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    return YES;
}

- (UIWindow *)window
{
    if (self.fxWindow == nil) {
        self.fxWindow = [[UIFXWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    return self.fxWindow;
}

@end

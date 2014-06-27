//
//  RNAppDelegate.m
//  Recipe Network
//
//  Created by Guy Ben Aharon on 6/15/14.
//  Copyright (c) 2014 Guyb. All rights reserved.
//

#import "RNAppDelegate.h"

@implementation RNAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Start with splash screen on app openning
    [self startSplashScreen];
    
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [RNAppData saveData:[RNAppData favData]];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [RNAppData saveData:[RNAppData favData]];
}

-(void)startSplashScreen
{
    // Creates and designs the main view for the splash screen
    UIView *view =[[UIView alloc] initWithFrame:self.window.frame];
    [view setBackgroundColor:[UIColor brownColor]];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake((view.frame.size.width-170)/2, (view.frame.size.height-50)/2, 200, 100)];
    [title setFont:[UIFont fontWithName:@"Helvetica-bold" size:24]];
    [title setText:@"Recipe Network"];
    [title setTextColor:[UIColor whiteColor]];
    [view addSubview:title];
    [view bringSubviewToFront:title];
    
    // Adds splash screen to the window
    [self.window.rootViewController.view addSubview:view];
    [self.window.rootViewController.view bringSubviewToFront:view];
    
    // Starts splash view animation
    [UIView animateWithDuration:1.5f delay:2.0f options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         view.alpha = .0f;
                     } completion:^(BOOL finished){
                         if(finished)
                         {
                             [view removeFromSuperview];
                         }
                     }];
}

@end

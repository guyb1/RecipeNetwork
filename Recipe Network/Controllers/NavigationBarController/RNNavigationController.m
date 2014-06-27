//
//  RNNavigationController.m
//  Recipe Network
//
//  Created by Guy Ben Aharon on 6/23/14.
//  Copyright (c) 2014 Guyb. All rights reserved.
//

#import "RNNavigationController.h"

@interface RNNavigationController ()

@end

@implementation RNNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Sets colors and settings of the navigation controller
    self.navigationBar.barTintColor = [UIColor brownColor];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    self.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationBar setTranslucent:NO];
}

// Used to set the upper time and battery color to white
-(UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

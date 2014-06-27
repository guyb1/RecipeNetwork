//
//  RNTabBarController.m
//  Recipe Network
//
//  Created by Guy Ben Aharon on 6/19/14.
//  Copyright (c) 2014 Guyb. All rights reserved.
//

#import "RNTabBarController.h"

@interface RNTabBarController ()

@end

@implementation RNTabBarController

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

    self.tabBar.translucent = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

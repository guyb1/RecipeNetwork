//
//  RNAboutViewController.m
//  Recipe Network
//
//  Created by Guy Ben Aharon on 6/24/14.
//  Copyright (c) 2014 Guyb. All rights reserved.
//

#import "RNAboutViewController.h"

@interface RNAboutViewController ()

@end

@implementation RNAboutViewController

@synthesize imgBackground;

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
    
    // Sets top title text
    [self.navigationItem setTitle:@"About us"];
    
    // Sets the picture in the view
    // Picture is set by pattern
    [imgBackground setBackgroundColor:[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

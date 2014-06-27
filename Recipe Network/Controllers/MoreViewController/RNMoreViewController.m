//
//  RNMoreViewController.m
//  Recipe Network
//
//  Created by Guy Ben Aharon on 6/23/14.
//  Copyright (c) 2014 Guyb. All rights reserved.
//

#import "RNMoreViewController.h"

@interface RNMoreViewController ()

@end

@implementation RNMoreViewController

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
    
    // Sets the list view items
    menuData = [NSArray arrayWithObjects:@"Restaurants nearby", @"Share RecipeNetwork", @"About", nil];
    menuPictures = [NSArray arrayWithObjects:@"crown.png", @"letter.png", @"about.png", nil];
    
    // Sets the background image
    [imgBackground setBackgroundColor:[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [menuData count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Creates and sets the cell for a specific index
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menuCell"];
    [cell.textLabel setText:[menuData objectAtIndex:indexPath.row]];
    [cell.imageView setImage:[UIImage imageNamed:[menuPictures objectAtIndex:indexPath.row]]];
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigates to Restaurants Nearby
    if(indexPath.row == 0)
    {
        RNMapViewController* mapController = [self.storyboard instantiateViewControllerWithIdentifier:@"mapView"];
        
        [[self navigationController] pushViewController:mapController animated:YES];
    }
    // Navigates to Share RecipeNetwork
    else if(indexPath.row == 1)
    {
        RNShareViewController* shareController = [self.storyboard instantiateViewControllerWithIdentifier:@"shareView"];
        
        [[self navigationController] pushViewController:shareController animated:YES];
    }
    // Navigates to About
    else
    {
        RNAboutViewController* aboutController = [self.storyboard instantiateViewControllerWithIdentifier:@"aboutView"];
    
        [[self navigationController] pushViewController:aboutController animated:YES];
    }
    
    // Removes selection from the selected option
    [tableView deselectRowAtIndexPath:indexPath animated:FALSE];
}


@end

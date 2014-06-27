//
//  RNDetailViewController.m
//  Recipe Network
//
//  Created by Guy Ben Aharon on 6/16/14.
//  Copyright (c) 2014 Guyb. All rights reserved.
//

#import "RNDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "RNAppData.h"

@interface RNDetailViewController ()

@end

@implementation RNDetailViewController

@synthesize recipe;
@synthesize viewIngredients;
@synthesize viewRecipe;
@synthesize viewImage;
@synthesize btnAddToFav;

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
    self.navigationItem.title = self.recipe.Title;
    
    // Sets recipe's image using AFNetworking library
    // Used for set an image from a url
    [viewImage setImageWithURL:[NSURL URLWithString:[recipe.Picture stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    // Sets the recipe text and ingredients
    viewRecipe.text = recipe.Text;
    viewIngredients.text = recipe.Ingredients;
    
    // Sets favorite button
    if([RNAppData isFavorite:recipe.ID])
    {
        [btnAddToFav setTitle:@"Remove from favorites" forState:UIControlStateNormal];
    }
    else
    {
        [btnAddToFav setTitle:@"Add to favorites" forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(IBAction) clickAddToFav :(UIButton *)sender
{
    // Checks if already in favorites or not
    if([sender.titleLabel.text hasPrefix:@"R"])
    {
        [btnAddToFav setTitle:@"Add to favorites" forState:UIControlStateNormal];
        [[RNAppData favData] removeObject:recipe];
    }
    else
    {
        [btnAddToFav setTitle:@"Remove from favorites" forState:UIControlStateNormal];
        [[RNAppData favData] addObject:recipe];
    }
}

@end

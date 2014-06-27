//
//  RNDetailViewController.h
//  Recipe Network
//
//  Created by Guy Ben Aharon on 6/16/14.
//  Copyright (c) 2014 Guyb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNRecipe.h"

@interface RNDetailViewController : UIViewController

@property (nonatomic, strong) RNRecipe *recipe;
@property (nonatomic, strong) IBOutlet UIImageView *viewImage;
@property (nonatomic, strong) IBOutlet UITextView *viewIngredients;
@property (nonatomic, strong) IBOutlet UITextView *viewRecipe;

@property (nonatomic, strong) IBOutlet UIButton *btnAddToFav;

-(IBAction) clickAddToFav :(UIButton *)sender;

@end

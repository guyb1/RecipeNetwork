//
//  RNFavTableViewController.m
//  Recipe Network
//
//  Created by Guy Ben Aharon on 6/21/14.
//  Copyright (c) 2014 Guyb. All rights reserved.
//

#import "RNFavTableViewController.h"
#import "RNCustomTableCell.h"
#import "RNRecipe.h"
#import "UIImageView+AFNetworking.h"
#import "RNAppData.h"
#import "RNDetailViewController.h"

@interface RNFavTableViewController ()

@end

@implementation RNFavTableViewController

@synthesize tableData;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpLeftSwipe];
        [self.tableView registerNib:[UINib nibWithNibName:@"RNCustomTableCell" bundle:nil] forCellReuseIdentifier:@"RNCustomTableCell"];
    
    // Gets the favorites array
    tableData = [RNAppData favData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Checks if the edit is for delete items
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Removes selected recipe from the table data
        [self.tableData removeObjectAtIndex:indexPath.row];
        
        // Removes selected recipe from table view with animation
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"RNCustomTableCell";
    
    RNCustomTableCell *cell = (RNCustomTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier  forIndexPath:indexPath];
    
    if(cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:simpleTableIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    
    // Configures the cell
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    // Gets recipe for current cell
    RNRecipe *recipe = (RNRecipe *)tableData[indexPath.row];
    
    // Creates functions actions and sets tags title button
    cell.btnTitle.tag =indexPath.row;
    [cell.btnTitle addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // Sets cell's image using AFNetworking library
    // Used for set an image from a url
    cell.thumbnailImageView.image = nil;
    [cell.thumbnailImageView setImageWithURL:[NSURL URLWithString:[recipe.Picture stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    // Sets another properties for the cell
    cell.prepTimeLabel.text = recipe.PrepTime;
    [cell.btnTitle setTitle:recipe.Title forState:UIControlStateNormal];
    
    // Hides likes from custom cell. Irrelevant for favorites table.
    cell.likes.hidden = YES;
    cell.btnLike.hidden = YES;
    
    return cell;
}

-(void) setUpLeftSwipe{
    // Sets swipe to delete
    UISwipeGestureRecognizer *editingRecognizer;
    editingRecognizer =[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeCell:)];
    [editingRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.tableView addGestureRecognizer:editingRecognizer];
    
    // Sets double tap to exit edit mode
    UITapGestureRecognizer *stopEditingRecognizer;
    stopEditingRecognizer =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchCell:)];
    [stopEditingRecognizer setNumberOfTouchesRequired:1];
    [stopEditingRecognizer setNumberOfTapsRequired:2];
    [self.tableView addGestureRecognizer:stopEditingRecognizer];
}

-(void)swipeCell: (UIGestureRecognizer*) sender{
    RNCustomTableCell *cell = (RNCustomTableCell*)[sender view];
    [cell setEditing:YES animated:YES];
}

-(void)touchCell: (UIGestureRecognizer*) sender{
    RNCustomTableCell *cell = (RNCustomTableCell*)[sender view];
    [cell setEditing:NO animated:YES];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.tableView reloadData];
}

-(void)titleClick:(UIButton*)sender
{
    // Gets detail controller
    RNDetailViewController* detailController = [self.storyboard instantiateViewControllerWithIdentifier:@"detailView"];
    
    // Sets the recipe to present in the detail controller
    detailController.recipe = [self.tableData objectAtIndex:sender.tag];
    
    // Navigate to the detail controller
    [[self navigationController] pushViewController:detailController animated:YES];
}

@end

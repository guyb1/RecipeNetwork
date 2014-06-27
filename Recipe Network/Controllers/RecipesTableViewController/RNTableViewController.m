//
//  RNTableViewController.m
//  Recipe Network
//
//  Created by Guy Ben Aharon on 6/15/14.
//  Copyright (c) 2014 Guyb. All rights reserved.
//

#import "RNTableViewController.h"
#import "RNDetailViewController.h"
#import "RNWSManager.h"
#import "RNRecipe.h"
#import "UIImageView+AFNetworking.h"

@interface RNTableViewController ()

@end

@implementation RNTableViewController

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
    
    // Inits 'Pull to Refresh'
    [self initRefreshControl];
    [self.tableView registerNib:[UINib nibWithNibName:@"RNCustomTableCell" bundle:nil] forCellReuseIdentifier:@"RNCustomTableCell"];
    
    // Load recipes from the server
    [RNWSManager getRecipes:-1:7:self append:NO];
    
}

-(void) initRefreshControl
{
    // Creates and sets Refresh Control for the view
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl setAttributedTitle:[[NSAttributedString alloc] initWithString:@"Pull to refresh"]];
    [refreshControl addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
}

-(void) refreshView: (UIRefreshControl *) refresh
{
    [refresh setAttributedTitle:[[NSAttributedString alloc] initWithString:@"Refreshing recepies..."]];
    
    // Load recipes from the server
    [RNWSManager getRecipes:-1:7:self append:NO];
    
    // Sets 'last update label'
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, h:mm a"];
    NSString *lastUpdate = [NSString stringWithFormat:@"Last update on %@", [formatter stringFromDate:[NSDate date]]];
    [refresh setAttributedTitle:[[NSAttributedString alloc] initWithString:lastUpdate]];
    
    [refresh endRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [tableData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"RNCustomTableCell";
    
    // Gets reusable custom cell if exists
    RNCustomTableCell *cell = (RNCustomTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier forIndexPath:indexPath];
    
    // If not, creates
    if(cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:simpleTableIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    
    // Configures the cell
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    // Creates functions actions and sets tags for each button
    cell.btnTitle.tag =indexPath.row;
    [cell.btnTitle addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.btnLike.tag =indexPath.row;
        [cell.btnLike addTarget:self action:@selector(likeClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // Gets recipe for current cell
    RNRecipe *recipe = (RNRecipe *)tableData[indexPath.row];
    
    // Sets cell's image using AFNetworking library
    // Used for set an image from a url
    cell.thumbnailImageView.image = nil;
    [cell.thumbnailImageView setImageWithURL:[NSURL URLWithString:[recipe.Picture stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    // Sets another properties for the cell
    cell.prepTimeLabel.text = recipe.PrepTime;
    [cell.btnTitle setTitle:recipe.Title forState:UIControlStateNormal];
    cell.likes.text = [@(recipe.Likes) stringValue];
    
    if(recipe.DidLike)
    {
        [cell.btnLike setTitle:@"Liked" forState:UIControlStateNormal];
    }
    else
    {
        [cell.btnLike setTitle:@"Like" forState:UIControlStateNormal];
    }
    
    return cell;
}

-(void)likeClick:(UIButton*)sender
{
    // get recipe
    RNRecipe *recipe = ((RNRecipe*)[tableData objectAtIndex:sender.tag]);
    
    // use rnwsmanager with like method
    NSIndexPath *index = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    RNCustomTableCell *cell = (RNCustomTableCell*)[self.tableView cellForRowAtIndexPath:index];
    
    [RNWSManager makeLike:recipe :cell];
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

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Used for lazy loading. Checks if the displayed cell is the last one.
    // If it is, loads more cells from server and appends them to the list.
    NSInteger lastRow = [tableData count] - 1;
    if([indexPath row] == lastRow)
    {
        long recipeID = ((RNRecipe*)tableData[tableData.count-1]).ID;
        [RNWSManager getRecipes:recipeID:4:self append:YES];
    }
}

@end

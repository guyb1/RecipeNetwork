//
//  RNTableViewController.h
//  Recipe Network
//
//  Created by Guy Ben Aharon on 6/15/14.
//  Copyright (c) 2014 Guyb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNCustomTableCell.h"


@interface RNTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *tableData;

-(void)titleClick:(UIButton*)sender;
-(void)likeClick:(UIButton*)sender;

@end

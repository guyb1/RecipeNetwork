//
//  RNFavTableViewController.h
//  Recipe Network
//
//  Created by Guy Ben Aharon on 6/21/14.
//  Copyright (c) 2014 Guyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RNFavTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *tableData;

-(void)titleClick:(UIButton*)sender;

@end

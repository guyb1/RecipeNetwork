//
//  RNMoreViewController.h
//  Recipe Network
//
//  Created by Guy Ben Aharon on 6/23/14.
//  Copyright (c) 2014 Guyb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNMapViewController.h"
#import "RNAboutViewController.h"
#import "RNShareViewController.h"

@interface RNMoreViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    NSArray *menuData;
    NSArray *menuPictures;
}

@property (nonatomic,strong) IBOutlet UIImageView *imgBackground;
@property (nonatomic, strong) IBOutlet UITableView *tblMenu;


@end

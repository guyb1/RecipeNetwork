//
//  RNShareViewController.h
//  Recipe Network
//
//  Created by Guy Ben Aharon on 6/24/14.
//  Copyright (c) 2014 Guyb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNContactTableViewCell.h"
#import "RNContact.h"
#import <AddressBook/AddressBook.h>

@interface RNShareViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    NSArray *contactsData;
}

@property (nonatomic, strong) IBOutlet UITableView *tblTableView;

-(IBAction)sendClick:(id)sender;

@end

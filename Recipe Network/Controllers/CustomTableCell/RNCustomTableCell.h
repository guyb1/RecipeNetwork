//
//  RNCostumTableCell.h
//  Recipe Network
//
//  Created by Guy Ben Aharon on 6/15/14.
//  Copyright (c) 2014 Guyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RNCustomTableCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIButton *btnTitle;
@property (nonatomic, strong) IBOutlet UILabel *prepTimeLabel;
@property (nonatomic, strong) IBOutlet UIImageView *thumbnailImageView;
@property (nonatomic, strong) IBOutlet UILabel *likes;
@property (nonatomic, strong) IBOutlet UIButton *btnLike;

@end

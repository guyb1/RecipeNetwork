//
//  RNCostumTableCell.m
//  Recipe Network
//
//  Created by Guy Ben Aharon on 6/15/14.
//  Copyright (c) 2014 Guyb. All rights reserved.
//

#import "RNCustomTableCell.h"

@implementation RNCustomTableCell

@synthesize btnTitle;
@synthesize prepTimeLabel;
@synthesize thumbnailImageView;
@synthesize likes;
@synthesize btnLike;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

    }
    return self;
}

- (void)awakeFromNib
{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end

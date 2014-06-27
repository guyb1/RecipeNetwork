//
//  RNRecipe.h
//  Recipe Network
//
//  Created by Guy Ben Aharon on 6/18/14.
//  Copyright (c) 2014 Guyb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RNRecipe : NSObject <NSCoding>

@property (nonatomic) long ID;
@property (nonatomic, strong) NSString *Title;
@property (nonatomic, strong) NSString *Picture;
@property (nonatomic, strong) NSString *Ingredients;
@property (nonatomic, strong) NSString *Description;
@property (nonatomic, strong) NSString *Text;
@property (nonatomic, strong) NSString *PrepTime;
@property (nonatomic) NSInteger Likes;
@property (nonatomic) bool DidLike;

@end

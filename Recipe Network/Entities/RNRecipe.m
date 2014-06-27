//
//  RNRecipe.m
//  Recipe Network
//
//  Created by Guy Ben Aharon on 6/18/14.
//  Copyright (c) 2014 Guyb. All rights reserved.
//

#import "RNRecipe.h"

@implementation RNRecipe

@synthesize ID;
@synthesize Title;
@synthesize Picture;
@synthesize Ingredients;
@synthesize Description;
@synthesize Text;
@synthesize PrepTime;
@synthesize Likes;
@synthesize DidLike;

- (id)init
{
    self = [super init];
    
    return self;
}

-(void) encodeWithCoder:(NSCoder *)aCoder
{
    // Used for saved an object of RNRecipe type to file, serialization
    [aCoder encodeInt64:self.ID forKey:@"ID"];
    [aCoder encodeObject:self.Title forKey:@"Title"];
    [aCoder encodeObject:self.Picture forKey:@"Picture"];
    [aCoder encodeObject:self.Ingredients forKey:@"Ingredients"];
    [aCoder encodeObject:self.Description forKey:@"Description"];
    [aCoder encodeObject:self.Text forKey:@"Text"];
    [aCoder encodeObject:self.PrepTime forKey:@"PrepTime"];
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    // Used for reading an object of RNRecipe type from file, deserialization
    self = [self init];
    self.ID = [aDecoder decodeInt64ForKey:@"ID"];
    self.Title = [aDecoder decodeObjectForKey:@"Title"];
    self.Picture = [aDecoder decodeObjectForKey:@"Picture"];
    self.Ingredients = [aDecoder decodeObjectForKey:@"Ingredients"];
    self.Description = [aDecoder decodeObjectForKey:@"Description"];
    self.Text = [aDecoder decodeObjectForKey:@"Text"];
    self.PrepTime = [aDecoder decodeObjectForKey:@"PrepTime"];
    
    return self;
}

@end

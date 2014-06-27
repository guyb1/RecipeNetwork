//
//  RNAppData.h
//  Recipe Network
//
//  Created by Guy Ben Aharon on 6/21/14.
//  Copyright (c) 2014 Guyb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RNRecipe.h"

@interface RNAppData : NSObject

+ (NSMutableArray*)favData;

+(void) saveData :(NSMutableArray *) array;
+(NSMutableArray *) loadData;
+(BOOL) isFavorite :(long)recipeID;

@end

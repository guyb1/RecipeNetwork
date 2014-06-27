//
//  RNAppData.m
//  Recipe Network
//
//  Created by Guy Ben Aharon on 6/21/14.
//  Copyright (c) 2014 Guyb. All rights reserved.
//

#import "RNAppData.h"

@implementation RNAppData

// Returns the favorites array
+ (NSMutableArray*)favData
{
    static NSMutableArray* arrayData = nil;
    
    // Loads the favorites from file if its not loaded already
    if(arrayData == nil)
    {
        arrayData = [self loadData];
    }
    
    return arrayData;
}

// Returns if the recipe was added to favorites
+(BOOL) isFavorite :(long)recipeID
{
    for(RNRecipe *curr in [self favData])
    {
        if(curr.ID == recipeID)
            return YES;
    }
    
    return NO;
}

+(void) saveData :(NSMutableArray *) array
{
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    // Checks the array is not empty
    if(array != nil)
    {
        [dataDict setObject:array forKey:@"recipes"];
    }
    
    // Gets the phone paths and sets the folder & file to save at
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *directoryPath = [documentsDirectoryPath stringByAppendingPathComponent:@"AppData"];
    NSString *filePath = [directoryPath stringByAppendingPathComponent:@"data"];
    
    // Creates directory if not exists
    if(![[NSFileManager defaultManager] fileExistsAtPath:directoryPath])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    
    // Saves to file
    [NSKeyedArchiver archiveRootObject:dataDict toFile:filePath];
}

+(NSMutableArray *) loadData
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    // Gets path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *directoryPath = [documentsDirectoryPath stringByAppendingPathComponent:@"AppData"];
    NSString *filePath = [directoryPath stringByAppendingPathComponent:@"data"];
    
    // Checks if there is any data saved from previous runs
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSDictionary *savedData = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        // Checks if the data contains recipes saved
        if([savedData objectForKey:@"recipes"] != nil)
        {
            [array addObjectsFromArray:[[NSMutableArray alloc]initWithArray:[savedData objectForKey:@"recipes"]]];
            //array = [[NSMutableArray alloc]initWithArray:[savedData objectForKey:@"recipes"]];
        }
    }
    
    return array;
}

@end

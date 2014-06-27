//
//  RNWSManager.h
//  Recipe Network
//
//  Created by Guy Ben Aharon on 6/17/14.
//  Copyright (c) 2014 Guyb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RNTableViewController.h"
#import "RNRecipe.h"
#import "RNMapPin.h"
#import <MapKit/MapKit.h>
#import "SSKeychain.h"
#import "AFHTTPRequestOperationManager.h"

@interface RNWSManager : NSObject

extern NSString * const WS_ADDRESS;
+(void)getRecipes: (long)from :(NSInteger)length :(RNTableViewController *)controller append:(BOOL)append;
+(BOOL)makeLike: (RNRecipe*)recipe : (RNCustomTableCell*)cell;
+(void) getRestaurants: (double) latitude :(double) longtitude :(int) radius :(MKMapView *) mapView;

@end

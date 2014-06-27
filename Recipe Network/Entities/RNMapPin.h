//
//  RNMapPin.h
//  Recipe Network
//
//  Created by Guy Ben Aharon on 6/25/14.
//  Copyright (c) 2014 Guyb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface RNMapPin : NSObject <MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@end

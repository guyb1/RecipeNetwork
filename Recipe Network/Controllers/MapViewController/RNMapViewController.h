//
//  RNMapViewController.h
//  Recipe Network
//
//  Created by Guy Ben Aharon on 6/25/14.
//  Copyright (c) 2014 Guyb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "RNWSManager.h"

@interface RNMapViewController : UIViewController{
    
    MKMapView *mapView;
}

@property (nonatomic, strong) IBOutlet MKMapView *mapView;

-(IBAction)SetMap:(id)sender;
-(MKAnnotationView *)mapView:(MKMapView *) aMapView viewForAnnotation:(id<MKAnnotation>)annotation;

@end

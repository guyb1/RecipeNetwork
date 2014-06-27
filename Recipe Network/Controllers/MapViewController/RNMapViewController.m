//
//  RNMapViewController.m
//  Recipe Network
//
//  Created by Guy Ben Aharon on 6/25/14.
//  Copyright (c) 2014 Guyb. All rights reserved.
//

#import "RNMapViewController.h"

@interface RNMapViewController ()

@end

@implementation RNMapViewController

@synthesize mapView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Sets top title text
    [self.navigationItem setTitle:@"Restaurants on map"];
    
    // Asks for user location
    mapView.showsUserLocation = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(MKAnnotationView *)mapView:(MKMapView *) aMapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    // Checks if user location finished loading
    if([annotation isKindOfClass:MKUserLocation.class])
    {
        MKUserLocation *userLocation = (MKUserLocation *)annotation;
        
        // Get latitude and longitude from user location
        double latitude = [@(userLocation.location.coordinate.latitude) doubleValue];
        double longitude = [@(userLocation.location.coordinate.longitude) doubleValue];
        
        // Sets map focus on user location
        [self focusUserLocation:latitude :longitude];
        
        // Sets pins on map for nearby restaurants in 15000 meters radius
        [RNWSManager getRestaurants:latitude :longitude :15000 :mapView];
        
        return nil;
    }
    
    return nil;
}

-(void) focusUserLocation: (double)latitude :(double)longitude
{
    MKCoordinateRegion region = { {0.0, 0.0}, {0.0, 0.0} };
    region.center.latitude = latitude;
    region.center.longitude = longitude;
    
    // Sets the span (how close to zoom)
    region.span.longitudeDelta = 0.03f;
    region.span.latitudeDelta = 0.03f;
    
    [mapView setRegion:region animated:YES];
}

-(IBAction)SetMap:(id)sender
{
    // Delegate to SegmentedControl, change map type according
    switch (((UISegmentedControl *) sender).selectedSegmentIndex) {
        case 0:
            mapView.mapType = MKMapTypeStandard;
            break;
            
            case 1:
            mapView.mapType = MKMapTypeSatellite;
            break;
            
        case 2:
            mapView.mapType = MKMapTypeHybrid;
            break;
            
        default:
            mapView.mapType = MKMapTypeStandard;
            break;
    }
}

@end

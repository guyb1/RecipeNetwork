//
//  RNWSManager.m
//  Recipe Network
//
//  Created by Guy Ben Aharon on 6/17/14.
//  Copyright (c) 2014 Guyb. All rights reserved.
//

#import "RNWSManager.h"

@interface RNWSManager()

+(void)setRecipe: (RNRecipe*)recipe :(id)responseObject;
+(NSString*)getUID;

@end

@implementation RNWSManager
static NSString * strUUID = nil;

// Jason web services
NSString * const WS_ADDRESS = @"http://tonespot.net/RecipeNetwork/api"; // My MVC 4 (Web API) WS
NSString * const WS_GOOGLE_ADDRESS = @"https://maps.googleapis.com/maps/api/place/search/json?"; // Google API WS


+(BOOL)makeLike: (RNRecipe*)recipe
               : (RNCustomTableCell*)cell
{
    // Sets WS address for like current recipe for current device ID
    NSString *address = [NSString stringWithFormat:@"%@/%@/%@/%@", WS_ADDRESS,
                         @"Like",
                         [@(recipe.ID) stringValue],
                         [self getUID]];
    
    // Makes a call to the WS using AFNetworking library
    // The library works with a queue so multi button clicks case is handled
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:address parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // Checks if it should check it as 'like' or 'liked'
        if(recipe.DidLike)
        {
            [cell.btnLike setTitle:@"Like" forState:UIControlStateNormal];
            recipe.DidLike = NO;
            recipe.Likes = recipe.Likes - 1;
        }
        else
        {
            [cell.btnLike setTitle:@"Liked" forState:UIControlStateNormal];
            recipe.DidLike = YES;
            recipe.Likes = recipe.Likes + 1;
        }
        
        [cell.likes setText:[@(recipe.Likes) stringValue]];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // In case of failure, shows a message box with an appropriate message
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet" message:@"Cannot reach servers" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
    
    return YES;
}

// Used to get device's unique ID
+(NSString*)getUID
{
    if(strUUID == nil)
    {
        // Gets app name for SSKeychain library
        NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey];
        
        // Tries to get a unique ID for device saved in past
        // SSKeychain library could keep data for app also if the user delete and reinstall the app
        strUUID = [SSKeychain passwordForService:appName account:@"incoding"];
        
        // If unique ID is not found, create a new one and saves it
        if(strUUID == nil)
        {
            strUUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
            [SSKeychain setPassword:strUUID forService:appName account:@"incoding"];
        }
    }
    
    return strUUID;
}

+(void)getRecipes: (long)from
                 :(NSInteger)length
                 :(RNTableViewController *)controller
                 append:(BOOL)append
{
    // Shows spinner while data is loaded
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(160, 240);
    spinner.hidesWhenStopped = YES;
    [controller.view addSubview:spinner];
    [spinner startAnimating];
    
    __block NSMutableArray *array = nil;

    // Sets WS address for get recipes
    NSString *address = [NSString stringWithFormat:@"%@/%@/%@/%@/%@", WS_ADDRESS,
                                                                      @"recipes",
                                                                      [@(from) stringValue],
                                                                      [@(length) stringValue],
                                                                      [self getUID]];
    
    // Makes a call to the WS using AFNetworking library
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:address parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // In case WS call succeed
        array = [NSMutableArray arrayWithCapacity:((NSDictionary*)responseObject).count];
        
        // Run over the data and sets new recipes
        for(int i=0; i<((NSDictionary*)responseObject).count; i++)
        {
            RNRecipe *recipe = [[RNRecipe alloc] init];
            [self setRecipe:recipe :responseObject[i]];
            [array addObject:recipe];
        }
        
        // Appends the data to the previous data if needed (used for lazy loading)
        if(!append)
        {
            [controller setTableData:array];
        }
        else
        {
            [controller.tableData addObjectsFromArray:array];
            
        }

        // Reloads the table view and stops spinner
        [controller.tableView reloadData];
        [spinner stopAnimating];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // In case of failure, shows a message box with an appropriate message
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet" message:@"Cannot reach servers" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [spinner stopAnimating];
    }];
}

+(void)setRecipe: (RNRecipe*)recipe :(id)responseObject
{
    // Sets recipe from jason dictionary results
    [recipe setID:[responseObject[@"ID"] longLongValue]];
    [recipe setTitle:responseObject[@"Title"]];
    [recipe setPicture:responseObject[@"Pic"]];
    [recipe setIngredients:responseObject[@"Ingredients"]];
    [recipe setDescription:responseObject[@"Description"]];
    [recipe setText:responseObject[@"Text"]];
    [recipe setPrepTime:responseObject[@"PrepTime"]];
    [recipe setLikes:[responseObject[@"Likes"] integerValue]];
    [recipe setDidLike:[responseObject[@"DidLike"] boolValue]];
}

+(void) getRestaurants: (double) latitude :(double) longtitude :(int) radius :(MKMapView *) mapView
{
    // Add parameters to ws: user location, radius of search, types of places to search sensor
    // and app's key for Google API
    NSString *address = [NSString stringWithFormat:@"%@location=%f,%f&radius=%d&types=food&sensor=true&key=AIzaSyDEpyoN8hAWQItYYIhYRE1Pir19vy9By0Q", WS_GOOGLE_ADDRESS,
                         latitude,
                         longtitude,
                         radius];
    
    // Makes a call to the WS using AFNetworking library
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:address parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // Creates map pins for all of the results
        for(int i=0; i<((NSDictionary*)responseObject[@"results"]).count; i++)
        {
            RNMapPin *pin = [[RNMapPin alloc] init];
            [self setPin:pin :responseObject[@"results"][i]];
            [mapView addAnnotation:pin];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // In case of failure, shows a message box with an appropriate message
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet" message:@"Cannot reach servers" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];

}

+(void)setPin: (RNMapPin*)pin :(id)responseObject
{
    // Sets pin with title, address and location of the place
    [pin setTitle:responseObject[@"name"]];
    [pin setSubtitle:responseObject[@"vicinity"]];
    CLLocationCoordinate2D coordinates;
    coordinates.latitude = [responseObject[@"geometry"][@"location"][@"lat"] doubleValue];
    coordinates.longitude = [responseObject[@"geometry"][@"location"][@"lng"] doubleValue];
    pin.coordinate = coordinates;
}

@end

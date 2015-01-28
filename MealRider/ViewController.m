//
//  ViewController.m
//  MealRider
//
//  Created by Jeff Ligon on 1/9/15.
//  Copyright (c) 2015 Visceral Origami LLC. All rights reserved.
//

#import "ViewController.h"
#import "SwipeViewController.h"
#import "DataMocker.h"

@interface ViewController ()


@property(nonatomic, strong) NSDictionary *agencyDict;
@property(nonatomic, strong) NSDictionary *routeDict;
@property(nonatomic, strong) NSDictionary *stopDict;

@property(nonatomic,assign)CLLocation *userLocation;
@property(atomic, assign) BOOL dataReady;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  // Do any additional setup after loading the view, typically from a nib.
  if (!self.rc) {
    self.rc = [[RequestCreator alloc] init];
    self.rc.delegate = self;
      self.dataReady = NO;
  }

  self.mapView.delegate = self;
    self.mapView.showsUserLocation=YES;
    self.mapView.showsBuildings=YES;
    
  self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestWhenInUseAuthorization];
  self.geocoder = [[CLGeocoder alloc] init];
  self.locationManager.delegate = self;
    
  [self getCurrLocation:nil];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  NSLog(@"memory!");
  // Dispose of any resources that can be recreated.
}

#pragma mark Location Stuff

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
  NSLog(@"didFailWithError: %@", error);
  UIAlertView *errorAlert =
      [[UIAlertView alloc] initWithTitle:@"Error"
                                 message:@"Failed to Get Your Location"
                                delegate:nil
                       cancelButtonTitle:@"OK"
                       otherButtonTitles:nil];
  [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
  NSLog(@"didUpdateToLocation: %@", newLocation);
  CLLocation *currentLocation = newLocation;

  if (currentLocation != nil) {
    NSString *latLongString = [NSString
        stringWithFormat:@"%.8f, %.8f", currentLocation.coordinate.latitude,
                         currentLocation.coordinate.longitude];

    self.textView.text = latLongString;
  }
    self.userLocation = currentLocation;
    [self areWeReady];
    
  // Reverse Geocoding
  /*NSLog(@"Resolving the Address");
  [self.geocoder
      reverseGeocodeLocation:self.userLocation
           completionHandler:^(NSArray *placemarks, NSError *error) {
             NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
             if (error == nil && [placemarks count] > 0) {
               self.placemark = [placemarks lastObject];
               self.textView.text =
                   [NSString stringWithFormat:@"%@ \n%@ %@\n%@ %@\n%@\n%@",
                                              self.textView.text,
                                              self.placemark.subThoroughfare,
                                              self.placemark.thoroughfare,
                                              self.placemark.postalCode,
                                              self.placemark.locality,
                                              self.placemark.administrativeArea,
                                              self.placemark.country];
             } else {
               NSLog(@"%@", error.debugDescription);
             }
           }];*/
  [self.locationManager stopUpdatingLocation];
}

- (IBAction)getCurrLocation:(id)sender {
    NSLog(@"Getting Location!");
  self.locationManager.delegate = self;
  self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
  if ([CLLocationManager locationServicesEnabled]) {
    [self.locationManager startUpdatingLocation];
  }
}

-(BOOL)areWeReady{
    if (!self.dataReady) {
        //do we have stops?
        if ([self.stopDict[@"ids"] count] > 0) {
            //do we have user location?
            if (CLLocationCoordinate2DIsValid(self.userLocation.coordinate )) {
                //call us once
                self.dataReady = YES;
                NSLog(@"*** READY ***");
                [self findOurStop];
                return YES;
            }
        }else{
            [self.rc getAgenciesWithLocation:self.userLocation];
        }
    }
    NSLog(@"--- Not Ready ---");
    return NO;
}

-(void)findOurStop{
    //we should have our stops and our location here
    NSArray* distances = [NSArray array];
    float latitude,longitude = 0.0f;
    CLLocation* someLoc = nil;
    for (NSDictionary* locDict in self.stopDict[@"locs"]) {
        latitude = (float)[[locDict valueForKey:@"lat"] floatValue];
        longitude = (float)[[locDict valueForKey:@"lng"] floatValue];
        someLoc = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
        double distance =[self.userLocation distanceFromLocation:someLoc];
        distances = [distances arrayByAddingObject:[NSNumber numberWithDouble:distance] ];
    }
    NSArray *sortedDistances = [distances sortedArrayUsingComparator:^NSComparisonResult(id lhs, id rhs) {
        if ([lhs floatValue] > [rhs floatValue]) {
            return NSOrderedAscending;
        } else if ([lhs floatValue] < [rhs floatValue]) {
            return NSOrderedDescending;
        } else {
                return NSOrderedSame;
        }
    }];
    // index is the stop that is closest to the user
    int index = [distances indexOfObject:[sortedDistances lastObject]];
    self.textView.text = [NSString stringWithFormat:@"The closest stop to your location is %@", self.stopDict[@"names"][index]];
    [self findRestStop];
}

-(void)findRestStop{
    self.restString = [DataMocker listOfRestaurant][self.restaurant];
    NSValue* restValue = [DataMocker locOfRestaurant][self.restString];
    CLLocation* restLoc = [[CLLocation alloc] initWithLatitude:restValue.MKCoordinateValue.latitude longitude:restValue.MKCoordinateValue.longitude];
    
    NSArray* distances = [NSArray array];
    float latitude,longitude = 0.0f;
    CLLocation* someLoc = nil;
    for (NSDictionary* locDict in self.stopDict[@"locs"]) {
        latitude = (float)[[locDict valueForKey:@"lat"] floatValue];
        longitude = (float)[[locDict valueForKey:@"lng"] floatValue];
        someLoc = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
        double distance =[restLoc distanceFromLocation:someLoc];
        distances = [distances arrayByAddingObject:[NSNumber numberWithDouble:distance] ];
    }
    NSArray *sortedDistances = [distances sortedArrayUsingComparator:^NSComparisonResult(id lhs, id rhs) {
        if ([lhs floatValue] > [rhs floatValue]) {
            return NSOrderedAscending;
        } else if ([lhs floatValue] < [rhs floatValue]) {
            return NSOrderedDescending;
        } else {
            return NSOrderedSame;
        }
    }];
    int index = [distances indexOfObject:[sortedDistances lastObject]];
    self.textView.text = [self.textView.text stringByAppendingFormat:@"\nAnd the closest stop to %@ is %@", self.restString, self.stopDict[@"names"][index] ];
}

#pragma mark - RequestDelegate stuff

- (void)storeAgencies:(NSDictionary *)agencyDict {
  self.agencyDict = agencyDict;
    if (agencyDict.count > 0) {
            [self.rc getStopsForAgencies:agencyDict];
    }
}

- (void) storeRoutes:(NSDictionary *)routeDict{
    self.routeDict = routeDict;
    NSLog(@"%@",[routeDict description]);
    
}

- (void) storeStops:(NSDictionary *)stopDict{
    self.stopDict = stopDict;
    NSLog(@"%@",[stopDict description]);
    [self areWeReady];
}

#pragma mark - MapViewStuff
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    _mapView.centerCoordinate = userLocation.location.coordinate;
}

@end

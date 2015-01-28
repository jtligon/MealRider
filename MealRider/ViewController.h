//
//  ViewController.h
//  MealRider
//
//  Created by Jeff Ligon on 1/9/15.
//  Copyright (c) 2015 Visceral Origami LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "RequestCreator.h"

@interface ViewController : UIViewController<CLLocationManagerDelegate, MKMapViewDelegate, RequestDelegate>


@property(nonatomic) int restaurant;
@property(nonatomic, strong) NSString *restString;

@property (nonatomic,strong) IBOutlet RequestCreator *rc;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong,nonatomic) CLGeocoder *geocoder;
@property (strong,nonatomic) CLPlacemark *placemark;

@property (weak, nonatomic) IBOutlet UITextView *textView;

- (IBAction)getCurrLocation:(id)sender;

@end


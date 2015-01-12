//
//  ViewController.h
//  MealRider
//
//  Created by Jeff Ligon on 1/9/15.
//  Copyright (c) 2015 Visceral Origami LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "RequestCreator.h"

@interface ViewController : UIViewController<CLLocationManagerDelegate>

@property (nonatomic,strong) IBOutlet RequestCreator *rc;
@property (weak, nonatomic) IBOutlet UIButton *requestButton;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong,nonatomic) CLGeocoder *geocoder;
@property (strong,nonatomic) CLPlacemark *placemark;

//Labels
@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;



-(IBAction)sendRequest:(id)sender;

-(void)locationAquired;
- (IBAction)getCurrLocation:(id)sender;

@end


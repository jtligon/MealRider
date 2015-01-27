//
//  RequestCreator.h
//  MealRider
//
//  Created by Jeff Ligon on 1/9/15.
//  Copyright (c) 2015 Visceral Origami LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@protocol RequestDelegate <NSObject>
@required

@optional

- (void) storeAgencies: (NSDictionary*) agencyDict;
- (void) storeRoutes: (NSDictionary*) routeDict;
- (void) storeStops: (NSDictionary*) stopDict;
@end


@interface RequestCreator : NSObject

@property (nonatomic, weak) IBOutlet NSObject<RequestDelegate> *delegate;

- (IBAction)getAgenciesWithLocation:(CLLocation*)location;
-(IBAction)getArrivalEstimates;
- (IBAction)getRoutesForAgencies:(NSDictionary*)agencies;
-(IBAction)getSegments;
-(IBAction)getStops;
-(IBAction)getVehicles;

@end

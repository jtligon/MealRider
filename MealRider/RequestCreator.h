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

- (void)storeAgencies:(NSDictionary *)agencyDict;
- (void)storeStops:(NSDictionary *)stopDict;
@optional

- (void)storeRoutes:(NSDictionary *)routeDict;
@end

@interface RequestCreator : NSObject

@property(nonatomic, weak) IBOutlet NSObject<RequestDelegate> *delegate;

- (IBAction)getAgenciesWithLocation:(CLLocation *)location;
- (IBAction)getArrivalEstimates;
- (IBAction)getRoutesForAgencies:(NSDictionary *)agencies;
- (IBAction)getSegments;
- (void)getStopsForAgencies:(NSDictionary *)agencies;
- (IBAction)getVehicles;

@end

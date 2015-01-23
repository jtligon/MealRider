//
//  RequestCreator.h
//  MealRider
//
//  Created by Jeff Ligon on 1/9/15.
//  Copyright (c) 2015 Visceral Origami LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestCreator : NSObject

-(IBAction)getAgencies;
-(IBAction)getArrivalEstimates;
-(IBAction)getRoutes;
-(IBAction)getSegments;
-(IBAction)getStops;
-(IBAction)getVehicles;

@end

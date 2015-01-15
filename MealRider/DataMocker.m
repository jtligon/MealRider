//
//  DataMocker.m
//  MealRider
//
//  Created by Jeff Ligon on 1/13/15.
//  Copyright (c) 2015 Visceral Origami LLC. All rights reserved.
//

#import "DataMocker.h"
#import <MapKit/MapKit.h>

@implementation DataMocker

+(NSArray*)listOfRestaurant{
    
    return  @[@"Mitch's Tavern",
              @"Sammy's",
              @"Bida Manda",
              @"David's Dumplings",
              @"Zaxby's",
              @"East Village",
              ];
}

+(NSDictionary*)locOfRestaurant{
    
    return @{
             @"Mitch's Tavern" : [NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(35.788332, -78.667715) ],
             @"David's Dumplings":[NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(35.785972,-78.661555)]
             };
}

+(NSDictionary*)imgNameForRestaurant{
    return @{
             @"Mitch's Tavern":@"",
             @"Sammy's":@"",
             @"Bida Manda":@"",
             @"David's Dumplings":@"",
             @"Zaxby's":@"",
             @"East Village":@""
             };
}

@end

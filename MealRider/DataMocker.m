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
             @"Mitch's Tavern":[NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(35.787880, -78.667657) ],
             @"Sammy's":[NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(35.777646, -78.677269) ],
             @"Bida Manda":[NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(35.777553, -78.636817) ],
             @"David's Dumplings":[NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(35.786227, -78.661555) ],
             @"Zaxby's":[NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(35.789178, -78.675277) ],
             @"East Village":[NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(35.789908, -78.676145) ]
             };
}

+(NSDictionary*)imgNameForRestaurant{
    return @{
             @"Mitch's Tavern":@"reuben.jpg",
             @"Sammy's":@"fishChips.jpg",
             @"Bida Manda":@"bidaManda.jpg",
             @"David's Dumplings":@"dumplings.jpg",
             @"Zaxby's":@"zaxbys.jpg",
             @"East Village":@"sandwich.jpg"
             };
}

@end

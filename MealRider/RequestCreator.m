//
//  RequestCreator.m
//  MealRider
//
//  Created by Jeff Ligon on 1/9/15.
//  Copyright (c) 2015 Visceral Origami LLC. All rights reserved.
//

#import "RequestCreator.h"

#import <UNIRest.h>

@interface RequestCreator()

@property (nonatomic, strong) NSURLSession* someSession;
@property (nonatomic,strong) CLLocation* lastSeenLocation;

@end

@implementation RequestCreator

/*
 Request a list of agencies available. getAgencies
 
 For each agency of interest, cache the stops, segments and routes.
 
 Periodically request the vehicle information and/or the arrival estimates, 
 and indicate the position of the markers on the map.
 */

- (instancetype)init {
	self = [super init];
	if (self) {
        //set up the additional headers needed for the mashape api calls
        NSURLSessionConfiguration *config =[[[NSURLSession sharedSession] configuration]copy];
        NSDictionary *headers = @{ @"X-Mashape-Key": @"ysuKkNDkPnmsh6Udvv3XNdw0AzYbp1xyufdjsnRTV0yP8TgvlT" };
        
        [config setHTTPAdditionalHeaders:headers];
        self.someSession = [NSURLSession sessionWithConfiguration:config];
	}
	return self;
}

- (void)getAgenciesWithLocation:(CLLocation*)location {
    NSURL *agencyURL = nil;
    if (location) {
        NSString *myLoc =[ NSString stringWithFormat:@"https://transloc-api-1-2.p.mashape.com/agencies.json?agencies=12&callback=call&geo_area=%f,%f|2.0", location.coordinate.longitude,location.coordinate.latitude ];
        
        agencyURL = [NSURL URLWithString:[myLoc stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding ]];
    }else{
	
	agencyURL = [NSURL URLWithString:@"https://transloc-api-1-2.p.mashape.com/agencies.json?agencies=12&callback=call&geo_area=35.80176,-78.64347%7C35.78061,-78.68218"];
    }
    
	[[self.someSession dataTaskWithURL:agencyURL
	        completionHandler : ^(NSData *data,
	                              NSURLResponse *response,
	                              NSError *error) {
	    NSError *jsonError;
	    NSDictionary *json = [NSJSONSerialization
	                          JSONObjectWithData:data
	                                     options:kNilOptions
	                                       error:&jsonError];
               // NSLog(@"%@",json );
                NSArray* agencies = json[@"data"];
                NSArray* agencyNames= [NSArray array];
                                NSArray* agencyIDs= [NSArray array];
                for (NSDictionary* agency in agencies) {
                    agencyNames = [agencyNames arrayByAddingObject:agency[@"short_name"]];
                    agencyIDs = [agencyIDs arrayByAddingObject:agency[@"agency_id"]];
                }
                
                NSDictionary *agencyDict = [NSDictionary dictionaryWithObjects:agencyNames forKeys:agencyIDs];
                NSLog(@"%@", agencyDict);
                if ([self.delegate respondsToSelector:@selector(storeAgencies:)]) {
                    [self.delegate performSelectorOnMainThread:@selector(storeAgencies:) withObject:agencyDict waitUntilDone:NO];
                }
                
	        //throw up a UIAlert that tells the user that the lookup failed.

            
            }] resume];
}

- (void)getArrivalEstimates {
	// These code snippets use an open-source library. http://unirest.io/objective-c
	NSDictionary *headers = @{ @"X-Mashape-Key": @"ysuKkNDkPnmsh6Udvv3XNdw0AzYbp1xyufdjsnRTV0yP8TgvlT" };
	UNIUrlConnection *asyncConnection = [[UNIRest get: ^(UNISimpleRequest *request) {
	    [request setUrl:@"https://transloc-api-1-2.p.mashape.com/arrival-estimates.json?agencies=12%2C16&callback=call&routes=4000421%2C4000592%2C4005122&stops=4002123%2C4023414%2C4021521"];
	    [request setHeaders:headers];
	}] asJsonAsync: ^(UNIHTTPJsonResponse *response, NSError *error) {
	    NSInteger code = response.code;
	    NSDictionary *responseHeaders = response.headers;
	    UNIJsonNode *body = response.body;
	    NSData *rawBody = response.rawBody;
	    NSLog(@"%@", [response.rawBody description]);
	}];
}

- (void)getRoutesForAgencies:(NSDictionary*)agencies {
    NSURL* routeURL = nil;
    if (agencies.count > 0) {
        NSString* agencyString = [agencies.allKeys componentsJoinedByString:@","];
        NSString* urlString = [NSString stringWithFormat:@"https://transloc-api-1-2.p.mashape.com/routes.json?agencies=%@&callback=call&geo_area=35.80176,-78.64347|35.78061,-78.68218", agencyString ];
        //geo_area=%f,%f%7C2.0", location.coordinate.longitude,location.coordinate.latitude ]
        routeURL = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }else{
        routeURL = [NSURL URLWithString:@"https://transloc-api-1-2.p.mashape.com/routes.json?agencies=12%2C16&callback=call&geo_area=35.80176,-78.64347%7C35.78061,-78.68218"];
    }
        
        [[self.someSession dataTaskWithURL:routeURL
                        completionHandler : ^(NSData *data,
                                              NSURLResponse *response,
                                              NSError *error) {
                            NSError *jsonError;
                            NSDictionary *json = [NSJSONSerialization
                                                  JSONObjectWithData:data
                                                  options:kNilOptions
                                                  error:&jsonError];

                            NSDictionary* allRoutes = json[@"data"];
                            //each of the agencies is a key to its array
                            NSArray* agencies = allRoutes.allKeys;
                            
                            NSArray* routeNames= [NSArray array];
                            NSArray* routeIDs= [NSArray array];
                            
                            //for each agency, get all the routes
                            for (NSString* agency in agencies) {
                                for (NSDictionary* route in allRoutes[agency]) {
                                    
                                    routeNames = [routeNames arrayByAddingObject:route[@"long_name"]];
                                    routeIDs = [routeIDs arrayByAddingObject:route[@"route_id"]];
                                }
                            }
                            
                            //store them all in a dictionary and send it back to the delegate.
                            NSDictionary *routeDict = [NSDictionary dictionaryWithObjects:routeNames forKeys:routeIDs];
                            NSLog(@"%@", routeDict);
                            if ([self.delegate respondsToSelector:@selector(storeRoutes:)]) {
                                [self.delegate performSelectorOnMainThread:@selector(storeRoutes:) withObject:routeDict waitUntilDone:NO];
                            }
                            
                            //throw up a UIAlert that tells the user that the lookup failed.
                            
                            
                        }] resume];
}

- (void)getSegments {
	// These code snippets use an open-source library. http://unirest.io/objective-c
	NSDictionary *headers = @{ @"X-Mashape-Key": @"ysuKkNDkPnmsh6Udvv3XNdw0AzYbp1xyufdjsnRTV0yP8TgvlT" };
	UNIUrlConnection *asyncConnection = [[UNIRest get: ^(UNISimpleRequest *request) {
	    [request setUrl:@"https://transloc-api-1-2.p.mashape.com/segments.json?agencies=12%2C16&callback=call&geo_area=35.80176%2C-78.64347%7C35.78061%2C-78.68218&routes=4000204"];
	    [request setHeaders:headers];
	}] asJsonAsync: ^(UNIHTTPJsonResponse *response, NSError *error) {
	    NSInteger code = response.code;
	    NSDictionary *responseHeaders = response.headers;
	    UNIJsonNode *body = response.body;
	    NSData *rawBody = response.rawBody;
	    NSLog(@"%@", [response.rawBody description]);
	}];
}

- (void)getStops {
	// These code snippets use an open-source library. http://unirest.io/objective-c
	NSDictionary *headers = @{ @"X-Mashape-Key": @"ysuKkNDkPnmsh6Udvv3XNdw0AzYbp1xyufdjsnRTV0yP8TgvlT" };
	UNIUrlConnection *asyncConnection = [[UNIRest get: ^(UNISimpleRequest *request) {
	    [request setUrl:@"https://transloc-api-1-2.p.mashape.com/stops.json?agencies=12%2C16&callback=call&geo_area=35.80176%2C-78.64347%7C35.78061%2C-78.68218"];
	    [request setHeaders:headers];
	}] asJsonAsync: ^(UNIHTTPJsonResponse *response, NSError *error) {
	    NSInteger code = response.code;
	    NSDictionary *responseHeaders = response.headers;
	    UNIJsonNode *body = response.body;
	    NSData *rawBody = response.rawBody;
	    NSLog(@"%@", [response.rawBody description]);
	}];
}

- (void)getVehicles {
	// These code snippets use an open-source library. http://unirest.io/objective-c
	NSDictionary *headers = @{ @"X-Mashape-Key": @"ysuKkNDkPnmsh6Udvv3XNdw0AzYbp1xyufdjsnRTV0yP8TgvlT" };
	UNIUrlConnection *asyncConnection = [[UNIRest get: ^(UNISimpleRequest *request) {
	    [request setUrl:@"https://transloc-api-1-2.p.mashape.com/vehicles.json?agencies=12%2C16&callback=call&geo_area=35.80176%2C-78.64347%7C35.78061%2C-78.68218&routes=4000421%2C4000592%2C4005122"];
	    [request setHeaders:headers];
	}] asJsonAsync: ^(UNIHTTPJsonResponse *response, NSError *error) {
	    NSInteger code = response.code;
	    NSDictionary *responseHeaders = response.headers;
	    UNIJsonNode *body = response.body;
	    NSData *rawBody = response.rawBody;
	    NSLog(@"%@", [response.rawBody description]);
	}];
}

@end

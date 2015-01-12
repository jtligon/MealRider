//
//  RequestCreator.m
//  MealRider
//
//  Created by Jeff Ligon on 1/9/15.
//  Copyright (c) 2015 Visceral Origami LLC. All rights reserved.
//

#import "RequestCreator.h"
#import <UNIRest.h>

@implementation RequestCreator

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)sendRequestToTransloc{
    NSLog(@"Request Created!");
    // These code snippets use an open-source library. http://unirest.io/objective-c
    NSDictionary *headers = @{@"X-Mashape-Key": @"ysuKkNDkPnmsh6Udvv3XNdw0AzYbp1xyufdjsnRTV0yP8TgvlT"};
    
    UNIUrlConnection *asyncConnection = [[UNIRest get:^(UNISimpleRequest *request) {
        [request setUrl:@"https://transloc-api-1-2.p.mashape.com/segments.json?agencies=12%2C16&callback=call&geo_area=35.80176%2C-78.64347%7C35.78061%2C-78.68218&routes=4000204"];
        
        [request setHeaders:headers];
        
    }] asJsonAsync:^(UNIHTTPJsonResponse *response, NSError *error) {
        
        NSInteger code = response.code;
        NSDictionary *responseHeaders = response.headers;
        UNIJsonNode *body = response.body;
        NSData *rawBody = response.rawBody;
        
        NSLog(@"%@", [body description]);
    }];
}

-(void)getAgencies{
    // These code snippets use an open-source library. http://unirest.io/objective-c
    NSDictionary *headers = @{@"X-Mashape-Key": @"ysuKkNDkPnmsh6Udvv3XNdw0AzYbp1xyufdjsnRTV0yP8TgvlT"};
    UNIUrlConnection *asyncConnection = [[UNIRest get:^(UNISimpleRequest *request) {
        [request setUrl:@"https://transloc-api-1-2.p.mashape.com/agencies.json?agencies=12&callback=call&geo_area=35.80176%2C-78.64347%7C35.78061%2C-78.68218"];
        [request setHeaders:headers];
    }] asJsonAsync:^(UNIHTTPJsonResponse *response, NSError *error) {
        NSInteger code = response.code;
        NSDictionary *responseHeaders = response.headers;
        UNIJsonNode *body = response.body;
        NSData *rawBody = response.rawBody;
                NSLog(@"%@", [response.rawBody description]);
    }];
}

-(void)getArrivalEstimates{
    // These code snippets use an open-source library. http://unirest.io/objective-c
    NSDictionary *headers = @{@"X-Mashape-Key": @"ysuKkNDkPnmsh6Udvv3XNdw0AzYbp1xyufdjsnRTV0yP8TgvlT"};
    UNIUrlConnection *asyncConnection = [[UNIRest get:^(UNISimpleRequest *request) {
        [request setUrl:@"https://transloc-api-1-2.p.mashape.com/arrival-estimates.json?agencies=12%2C16&callback=call&routes=4000421%2C4000592%2C4005122&stops=4002123%2C4023414%2C4021521"];
        [request setHeaders:headers];
    }] asJsonAsync:^(UNIHTTPJsonResponse *response, NSError *error) {
        NSInteger code = response.code;
        NSDictionary *responseHeaders = response.headers;
        UNIJsonNode *body = response.body;
        NSData *rawBody = response.rawBody;
                NSLog(@"%@", [response.rawBody description]);
    }];
}

-(void)getRoutes{
    // These code snippets use an open-source library. http://unirest.io/objective-c
    NSDictionary *headers = @{@"X-Mashape-Key": @"ysuKkNDkPnmsh6Udvv3XNdw0AzYbp1xyufdjsnRTV0yP8TgvlT"};
    UNIUrlConnection *asyncConnection = [[UNIRest get:^(UNISimpleRequest *request) {
        [request setUrl:@"https://transloc-api-1-2.p.mashape.com/routes.json?agencies=12%2C16&callback=call&geo_area=35.80176%2C-78.64347%7C35.78061%2C-78.68218"];
        [request setHeaders:headers];
    }] asJsonAsync:^(UNIHTTPJsonResponse *response, NSError *error) {
        NSInteger code = response.code;
        NSDictionary *responseHeaders = response.headers;
        UNIJsonNode *body = response.body;
        NSData *rawBody = response.rawBody;
                NSLog(@"%@", [response.rawBody description]);
    }];
}

-(void)getSegments{
    // These code snippets use an open-source library. http://unirest.io/objective-c
    NSDictionary *headers = @{@"X-Mashape-Key": @"ysuKkNDkPnmsh6Udvv3XNdw0AzYbp1xyufdjsnRTV0yP8TgvlT"};
    UNIUrlConnection *asyncConnection = [[UNIRest get:^(UNISimpleRequest *request) {
        [request setUrl:@"https://transloc-api-1-2.p.mashape.com/segments.json?agencies=12%2C16&callback=call&geo_area=35.80176%2C-78.64347%7C35.78061%2C-78.68218&routes=4000204"];
        [request setHeaders:headers];
    }] asJsonAsync:^(UNIHTTPJsonResponse *response, NSError *error) {
        NSInteger code = response.code;
        NSDictionary *responseHeaders = response.headers;
        UNIJsonNode *body = response.body;
        NSData *rawBody = response.rawBody;
                NSLog(@"%@", [response.rawBody description]);
    }];
}

-(void)getStops{
    // These code snippets use an open-source library. http://unirest.io/objective-c
    NSDictionary *headers = @{@"X-Mashape-Key": @"ysuKkNDkPnmsh6Udvv3XNdw0AzYbp1xyufdjsnRTV0yP8TgvlT"};
    UNIUrlConnection *asyncConnection = [[UNIRest get:^(UNISimpleRequest *request) {
        [request setUrl:@"https://transloc-api-1-2.p.mashape.com/stops.json?agencies=12%2C16&callback=call&geo_area=35.80176%2C-78.64347%7C35.78061%2C-78.68218"];
        [request setHeaders:headers];
    }] asJsonAsync:^(UNIHTTPJsonResponse *response, NSError *error) {
        NSInteger code = response.code;
        NSDictionary *responseHeaders = response.headers;
        UNIJsonNode *body = response.body;
        NSData *rawBody = response.rawBody;
                NSLog(@"%@", [response.rawBody description]);
    }];
}

-(void)getVehicles{
    // These code snippets use an open-source library. http://unirest.io/objective-c
    NSDictionary *headers = @{@"X-Mashape-Key": @"ysuKkNDkPnmsh6Udvv3XNdw0AzYbp1xyufdjsnRTV0yP8TgvlT"};
    UNIUrlConnection *asyncConnection = [[UNIRest get:^(UNISimpleRequest *request) {
        [request setUrl:@"https://transloc-api-1-2.p.mashape.com/vehicles.json?agencies=12%2C16&callback=call&geo_area=35.80176%2C-78.64347%7C35.78061%2C-78.68218&routes=4000421%2C4000592%2C4005122"];
        [request setHeaders:headers];
    }] asJsonAsync:^(UNIHTTPJsonResponse *response, NSError *error) {
        NSInteger code = response.code;
        NSDictionary *responseHeaders = response.headers;
        UNIJsonNode *body = response.body;
        NSData *rawBody = response.rawBody;
                NSLog(@"%@", [response.rawBody description]);
    }];
}


@end

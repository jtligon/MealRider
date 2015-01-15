//
//  SwipeViewController.m
//  MealRider
//
//  Created by Jeff Ligon on 1/14/15.
//  Copyright (c) 2015 Visceral Origami LLC. All rights reserved.
//

#import "SwipeViewController.h"
#import "DataMocker.h"
#import <MapKit/MapKit.h>


@interface SwipeViewController ()

@property (nonatomic) int restaurant;
@property (nonatomic,strong) NSString* restString;


@end

@implementation SwipeViewController

-(IBAction)goToMapViewWithMKLocation:(MKMapPoint)mapPoint sender:(id)sender{
    [self performSegueWithIdentifier:@"MapKitEntry" sender:sender];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.restaurant = 0;
    self.restString = [DataMocker listOfRestaurant][self.restaurant];
    
    MDCSwipeToChooseViewOptions* options = [[MDCSwipeToChooseViewOptions alloc]init];
    options.delegate = self;
    
    options.likedText = @"Eat";
    options.likedColor = [UIColor redColor];
    options.nopeText = @"Nope";
    options.onPan = ^(MDCPanState *state){
        if (state.thresholdRatio == 1.f && state.direction == MDCSwipeDirectionLeft) {
        }
    };
    
    self.swipeView = [[MDCSwipeToChooseView alloc]initWithFrame:self.view.bounds options:options];
    self.swipeView.backgroundColor = [UIColor yellowColor];
    UIImage* anImage =[UIImage imageNamed:[[DataMocker imgNameForRestaurant]objectForKey:self.restString]];
    self.swipeView.imageView.image = anImage;
    
    [self.view addSubview:self.swipeView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)nextRestaurant{
    //get the next index
    self.restaurant +=1;
    //wrap it around if it goes too far
    if (self.restaurant > [[DataMocker listOfRestaurant]count]) {
        self.restaurant = 0;
    }
    //get the associated string for use in the keys;
    self.restString = [DataMocker listOfRestaurant][self.restaurant];
}

#pragma mark - MDCSwipeToChooseDelegate Callbacks

// This is called when a user didn't fully swipe left or right.
- (void)viewDidCancelSwipe:(UIView *)view {
    NSLog(@"Couldn't decide, huh?");
}

// Sent before a choice is made. Cancel the choice by returning `NO`. Otherwise return `YES`.
- (BOOL)view:(UIView *)view shouldBeChosenWithDirection:(MDCSwipeDirection)direction {
    if (direction == MDCSwipeDirectionLeft) {
        return YES;
    } else {
        // Snap the view back and cancel the choice.
        [UIView animateWithDuration:0.16 animations:^{
            view.transform = CGAffineTransformIdentity;
            view.center = self.view.center;
        }];
        return NO;
    }
}

// This is called then a user swipes the view fully left or right.
- (void)view:(UIView *)view wasChosenWithDirection:(MDCSwipeDirection)direction {
    
    if (direction == MDCSwipeDirectionLeft) {
        NSLog(@"Next please!");
        [self nextRestaurant];
        self.swipeView.imageView.image = [UIImage imageNamed:[[DataMocker imgNameForRestaurant]objectForKey:self.restString]];
    } else {
        NSLog(@"Photo saved!");
    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

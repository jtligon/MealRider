//
//  SwipeViewController.m
//  MealRider
//
//  Created by Jeff Ligon on 1/14/15.
//  Copyright (c) 2015 Visceral Origami LLC. All rights reserved.
//

#import "SwipeViewController.h"
#import "DataMocker.h"
#import "RequestCreator.h"
#import <MapKit/MapKit.h>
#import <CoreGraphics/CoreGraphics.h>

@interface SwipeViewController ()


@end

@implementation SwipeViewController

- (IBAction)goToMapViewWithMKLocation:(MKMapPoint)mapPoint sender:(id)sender {
  [self performSegueWithIdentifier:@"MapKitEntry" sender:sender];
}

- (void)nextRestaurant {
  // get the next index
  self.restaurant += 1;
  // wrap it around if it goes too far
  if (self.restaurant >= [[DataMocker listOfRestaurant] count]) {
    self.restaurant = 0;
  }
  // get the associated string for use in the keys;
  self.restString = [DataMocker listOfRestaurant][self.restaurant];
  [self loadUpNextImageForChoice];
}

- (void)loadUpNextImageForChoice {
  MDCSwipeToChooseViewOptions *options =
      [[MDCSwipeToChooseViewOptions alloc] init];
  options.delegate = self;

  options.likedText = @"Eat";
  options.likedColor = [UIColor redColor];
  options.nopeText = @"Nope";
  options.onPan = ^(MDCPanState *state) {
    if (state.thresholdRatio == 1.f &&
        state.direction == MDCSwipeDirectionLeft) {
    }
  };

  self.swipeView = [[MDCSwipeToChooseView alloc] initWithFrame:self.view.bounds
                                                       options:options];
  self.swipeView.backgroundColor = [UIColor clearColor];

  // use the cached image so we can roll back around
  UIImage *anImage = [UIImage imageNamed:[[DataMocker imgNameForRestaurant]
                                             objectForKey:self.restString]];
  anImage = [anImage resizableImageWithCapInsets:UIEdgeInsetsZero
                                    resizingMode:UIImageResizingModeStretch];
  self.swipeView.imageView.contentMode = UIViewContentModeScaleAspectFit;
  self.swipeView.imageView.image = anImage;

  // add the Label
  CGRect labelRect =
      CGRectMake(20, self.view.center.y - 30, self.view.bounds.size.width, 60);
  self.nameLable = [[UILabel alloc] initWithFrame:labelRect];
  self.nameLable.textAlignment = NSTextAlignmentNatural;

  self.nameLable.text = self.restString;
  UIFont *labelFont = [UIFont fontWithName:@"GillSans-Bold" size:24.0];
  self.nameLable.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:.8];
  self.nameLable.font = labelFont;
  [self.nameLable sizeToFit];

  //    didn't like how the shadow turned out

  //    CALayer *maskLayer = [CALayer layer];
  //    maskLayer.frame = self.swipeView.imageView.bounds;
  //    maskLayer.shadowRadius = 20;
  //    maskLayer.shadowPath =
  //    CGPathCreateWithRoundedRect(CGRectInset(self.swipeView.imageView.bounds,
  //    5, 5), 10, 10, nil);
  //    maskLayer.shadowOpacity = 1;
  //    maskLayer.shadowOffset = CGSizeZero;
  //    maskLayer.shadowColor = [UIColor whiteColor].CGColor;
  //
  //    self.swipeView.imageView.layer.mask = maskLayer;

  [self.view addSubview:self.swipeView];
  [self.swipeView addSubview:self.nameLable];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.restaurant = 0;
  self.restString = [DataMocker listOfRestaurant][self.restaurant];
  [self loadUpNextImageForChoice];

  // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - MDCSwipeToChooseDelegate Callbacks

// This is called when a user didn't fully swipe left or right.
- (void)viewDidCancelSwipe:(UIView *)view {
  NSLog(@"Couldn't decide, huh?");
}

// Sent before a choice is made. Cancel the choice by returning `NO`. Otherwise
// return `YES`.
- (BOOL)view:(UIView *)view
    shouldBeChosenWithDirection:(MDCSwipeDirection)direction {
  if (direction == MDCSwipeDirectionLeft) {
    return YES;
  }else if (direction == MDCSwipeDirectionRight){
      return YES;
  
  } else {
    // Snap the view back and cancel the choice.
    [UIView animateWithDuration:0.16
                     animations:^{
                       view.transform = CGAffineTransformIdentity;
                       view.center = self.view.center;
                     }];
    return NO;
  }
}

// This is called then a user swipes the view fully left or right.
- (void)view:(UIView *)view
    wasChosenWithDirection:(MDCSwipeDirection)direction {

  if (direction == MDCSwipeDirectionLeft) {
    NSLog(@"Next please!");
    [self nextRestaurant];
  } else if (direction == MDCSwipeDirectionRight){
      //send the location to the MapViewController!
      [self performSegueWithIdentifier:@"MapKitEntry" sender:self];
      
  }
}

/*
 #pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little
 preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

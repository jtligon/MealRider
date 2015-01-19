//
//  SwipeViewController.h
//  MealRider
//
//  Created by Jeff Ligon on 1/14/15.
//  Copyright (c) 2015 Visceral Origami LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MDCSwipeToChoose/MDCSwipeToChoose.h>

@interface SwipeViewController : UIViewController<MDCSwipeToChooseDelegate>

@property (nonatomic,strong) MDCSwipeToChooseView* swipeView;
@property (nonatomic,strong) UILabel* nameLable;


@end

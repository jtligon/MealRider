//
//  ViewController.h
//  MealRider
//
//  Created by Jeff Ligon on 1/9/15.
//  Copyright (c) 2015 Visceral Origami LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestCreator.h"

@interface ViewController : UIViewController

@property (nonatomic,strong) IBOutlet RequestCreator *rc;

@property (weak, nonatomic) IBOutlet UIButton *requestButton;

-(IBAction)sendRequest:(id)sender;

@end


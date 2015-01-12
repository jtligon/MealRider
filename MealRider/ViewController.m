//
//  ViewController.m
//  MealRider
//
//  Created by Jeff Ligon on 1/9/15.
//  Copyright (c) 2015 Visceral Origami LLC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.rc) {
        self.rc = [[RequestCreator alloc]init];
    }
    // Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)sendRequest:(id)sender{
    NSLog(@"Button Pressed - VC");
    
    [self.rc sendRequestToTransloc];
}

-(void)viewDidDisappear:(BOOL)animated{
    if (self.rc){
        self.rc = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"memory!");
    // Dispose of any resources that can be recreated.
}

@end

//
//  ViewController.m
//  IWontToHelp
//
//  Created by Mac on 12/17/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import "ViewController.h"
#import "SWRevealViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _barButton.target = self.revealViewController;
    _barButton.action = @selector(revealToggle:);
       
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

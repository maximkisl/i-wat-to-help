//
//  StartViewController.m
//  IWontToHelp
//
//  Created by Mac on 12/18/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import "StartViewController.h"

@implementation StartViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *backgroundImage = [UIImage imageNamed:@"background.png"];
    UIColor *backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    self.view.backgroundColor = backgroundColor;
    
}

@end


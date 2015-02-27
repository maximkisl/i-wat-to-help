//
//  PAWCategory.m
//  IWontToHelp
//
//  Created by Mac on 2/21/15.
//  Copyright (c) 2015 Parse Inc. All rights reserved.
//

#import "PAWCategory.h"
#import "PAWConstants.h"
@interface PAWCategory ()

@end

@implementation PAWCategory

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)category1:(id)sender {
	category = @"category1";
	[[NSNotificationCenter defaultCenter] postNotificationName:HMCategoryDidChangeNotification object:nil];

}

- (IBAction)category2:(id)sender {
	category = @"category2";
	[[NSNotificationCenter defaultCenter] postNotificationName:HMCategoryDidChangeNotification object:nil];


}

- (IBAction)category3:(id)sender {
	category = @"category3";
	[[NSNotificationCenter defaultCenter] postNotificationName:HMCategoryDidChangeNotification object:nil];


}
@end

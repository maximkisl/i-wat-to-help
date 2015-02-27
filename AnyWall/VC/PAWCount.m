//
//  PAWCount.m
//  IWontToHelp
//
//  Created by Mac on 2/21/15.
//  Copyright (c) 2015 Parse Inc. All rights reserved.
//

#import "PAWCount.h"
#import "PAWConstants.h"
@interface PAWCount ()

@end

@implementation PAWCount

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (IBAction)fiveCout:(id)sender {
	countRank = @"5";
	[[NSNotificationCenter defaultCenter] postNotificationName:HMCountRankDidChangeNotification object:nil];

}

- (IBAction)tenCount:(id)sender {
	countRank = @"10";
	[[NSNotificationCenter defaultCenter] postNotificationName:HMCountRankDidChangeNotification object:nil];

}

- (IBAction)twentyCount:(id)sender {
	countRank = @"20";
	[[NSNotificationCenter defaultCenter] postNotificationName:HMCountRankDidChangeNotification object:nil];

}
@end

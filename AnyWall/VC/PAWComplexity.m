//
//  PAWComplexity.m
//  IWontToHelp
//
//  Created by Mac on 2/21/15.
//  Copyright (c) 2015 Parse Inc. All rights reserved.
//

#import "PAWComplexity.h"
#import "PAWConstants.h"
@interface PAWComplexity ()

@end

@implementation PAWComplexity

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (IBAction)complexity1:(id)sender {
	complexity = @"Легкая";
	[[NSNotificationCenter defaultCenter] postNotificationName:HMComplexityDidChangeNotification object:nil];

}

- (IBAction)complexity2:(id)sender {
	complexity = @"Средняя";
	[[NSNotificationCenter defaultCenter] postNotificationName:HMComplexityDidChangeNotification object:nil];


}

- (IBAction)complexity3:(id)sender {
	complexity = @"Высокая";
	[[NSNotificationCenter defaultCenter] postNotificationName:HMComplexityDidChangeNotification object:nil];


}
@end

//
//  main.m
//  Anywall
//
//  Copyright (c) 2014 Parse Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PAWAppDelegate.h"

int main(int argc, char *argv[])
{
	[[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObject:@"ru_RU"] forKey:@"AppleLanguages"];


	
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([PAWAppDelegate class]));
    }
}

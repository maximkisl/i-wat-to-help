//
//  IWTHProfile.h
//  IWontToHelp
//
//  Created by Mac on 1/23/15.
//  Copyright (c) 2015 Parse Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWTHProfile : NSObject

@property (nonatomic, weak) UIImage* avatar;

@property (nonatomic, weak) NSString* username;
@property (nonatomic, weak) NSString* firstname;
@property (nonatomic, weak) NSString* lastName;
@property (nonatomic, weak) NSString* phone;
@property (nonatomic, weak) NSString* email;
@property (nonatomic, weak) NSString* country;
@property (nonatomic, weak) NSString* city;
@property (nonatomic, weak) NSString* carma;
@property (nonatomic, weak) NSString* rank;


@end

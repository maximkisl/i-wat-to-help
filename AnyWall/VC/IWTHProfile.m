//
//  IWTHProfile.m
//  IWontToHelp
//
//  Created by Mac on 1/23/15.
//  Copyright (c) 2015 Parse Inc. All rights reserved.
//

#import "IWTHProfile.h"
#import "PAWConstants.h"

@implementation IWTHProfile

- (id)init
{
	
	return self;
}
-(void) setUsername:(NSString *)username{
	_username = username;
	[[NSNotificationCenter defaultCenter] postNotificationName:HMUserNameDidChangeNotification object:nil];
	
}
-(void) setFirstname:(NSString *)firstname{
	_firstname = firstname;
	[[NSNotificationCenter defaultCenter] postNotificationName:HMFirstNameDidChangeNotification object:nil];

}
-(void) setLastName:(NSString *)lastName{
	_lastName = lastName;
	[[NSNotificationCenter defaultCenter] postNotificationName:HMLastNameDidChangeNotification object:nil];

}
-(void) setPhone:(NSString *)phone{
	_phone = phone;
	[[NSNotificationCenter defaultCenter] postNotificationName:HMPhoneDidChangeNotification object:nil];

}
-(void) setRank:(NSString *)rank{
	_rank = rank;
	[[NSNotificationCenter defaultCenter] postNotificationName:HMRankDidChangeNotification object:nil];

}
-(void) setEmail:(NSString *)email{
	_email = email;
	[[NSNotificationCenter defaultCenter] postNotificationName:HMEmailDidChangeNotification object:nil];

}
-(void) setCountry:(NSString *)country{
	_country = country;
	[[NSNotificationCenter defaultCenter] postNotificationName:HMCountryDidChangeNotification object:nil];

}
-(void) setCity:(NSString *)city{
	_city = city;
	[[NSNotificationCenter defaultCenter] postNotificationName:HMCityDidChangeNotification object:nil];

}

-(void) setCarma:(NSString *)carma{
	_carma = carma;
	[[NSNotificationCenter defaultCenter] postNotificationName:HMCarmaDidChangeNotification object:nil];

}

-(void) setAvatar:(UIImage *)avatar{
//		avatar = [[UIImage alloc] init];
	if (avatar == nil) {
		_avatar = [UIImage imageNamed:@"testImage"];
	}
	_avatar = avatar;
	[[NSNotificationCenter defaultCenter] postNotificationName:HMAvatarImageDidChangeNotification object:nil];
}


@end


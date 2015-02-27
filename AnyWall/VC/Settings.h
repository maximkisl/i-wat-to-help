//
//  Settings.h
//  IWontToHelp
//
//  Created by Mac on 1/30/15.
//  Copyright (c) 2015 Parse Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Settings : UIViewController<CLLocationManagerDelegate>{

	CLLocationManager *locationManager;
	CLLocation *currentLocation;
}
- (IBAction)distantion200:(id)sender;
- (IBAction)maxdistantion10:(id)sender;

@end

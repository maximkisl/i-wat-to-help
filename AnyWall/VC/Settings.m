#import "PAWConstants.h"

#import "Settings.h"

@implementation Settings
- (IBAction)logoutButton:(id)sender {
	[[NSNotificationCenter defaultCenter] postNotificationName:kHMLogOut object:nil];

}
//- (void)viewDidLoad
//{
//	[super viewDidLoad];
//	[self CurrentLocationIdentifier]; // call this method
//}
//
//-(void)CurrentLocationIdentifier
//{
//	//---- For getting current gps location
//	locationManager = [CLLocationManager new];
//	locationManager.delegate = self;
//	locationManager.distanceFilter = kCLDistanceFilterNone;
//	locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//	locationManager.
//	[locationManager startUpdatingLocation];
//	//------
//}
//- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
//{
//	currentLocation = [locations objectAtIndex:0];
//	[locationManager stopUpdatingLocation];
//	CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
//	[geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
//	 {
//		 if (!(error))
//		 {
//			 CLPlacemark *placemark = [placemarks objectAtIndex:0];
//			 NSLog(@"\nCurrent Location Detected\n");
//			 NSLog(@"placemark %@",placemark);
//			 NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
//			 NSString *Address = [[NSString alloc]initWithString:locatedAt];
//			 NSString *Area = [[NSString alloc]initWithString:placemark.locality];
//			 NSString *Country = [[NSString alloc]initWithString:placemark.country];
//			 NSString *CountryArea = [NSString stringWithFormat:@"%@, %@", Area,Country];
//			 NSLog(@"%@",CountryArea);
//		 }
//		 else
//		 {
//			 NSLog(@"Geocode failed with error %@", error);
//			 NSLog(@"\nCurrent Location Not Detected\n");
//			 //return;
////			 CountryArea = NULL;
//		 }
//		 /*---- For more results
//		  placemark.region);
//		  placemark.country);
//		  placemark.locality);
//		  placemark.name);
//		  placemark.ocean);
//		  placemark.postalCode);
//		  placemark.subLocality);
//		  placemark.location);
//		  ------*/
//	 }];
//}
- (IBAction)distantion200:(id)sender {
//	PAWDefaultFilterDistance = 200.0;
	
}

- (IBAction)maxdistantion10:(id)sender {
//	PAWWallPostMaximumSearchDistance = 10.0;
}
@end

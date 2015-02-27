//
//  IWTHNewPostViewController.m
//  IWontToHelp
//
//  Created by Mac on 2/21/15.
//  Copyright (c) 2015 Parse Inc. All rights reserved.
//

#import "IWTHNewPostViewController.h"
#import "PAWConstants.h"
#import "PAWCategory.h"
#import "PAWday.h"
#import "PAWComplexity.h"
#import "PAWCategory.h"
#import "PAWCount.h"
@interface IWTHNewPostViewController ()

@end

@implementation IWTHNewPostViewController
CLLocation *locationController;
NSString* resultFinal;
NSString* resultFinalForTable;


- (void)viewDidLoad {
    [super viewDidLoad];
	[self.scrolView setScrollEnabled:YES];
	[self.scrolView setContentSize:CGSizeMake(320,1100)];
	
	
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rankCountNotification:) name:HMCountRankDidChangeNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(categoryNotification:) name:HMCategoryDidChangeNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(complexityNotification:) name:HMComplexityDidChangeNotification object:nil];

	
	
	
	self.datePicker.minimumDate = [NSDate date];
	
	
	
	[[[CLGeocoder alloc]init] reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
		CLPlacemark *placemark = placemarks[0];
		//		NSArray *lines = placemark.addressDictionary[ @"FormattedAddressLines"];
		//		NSString *addressString = [lines componentsJoinedByString:@","];
		
		NSString * countryTextBox =[placemark.addressDictionary valueForKey:@"Country"];
		NSString *citiTextBox =[placemark.addressDictionary valueForKey:@"City"];
		NSString *streetTextBox =[placemark.addressDictionary valueForKey:@"Street"];
		//		self.zipCodLbl.text =[placemark.addressDictionary valueForKey:@"ZIP"];
		
		NSString * str = @", ";
		NSString *strn = @"\n";
		
		NSString* resultCo = [countryTextBox stringByAppendingString: str];
		NSString* resultCi = [citiTextBox stringByAppendingString: str];
//		NSString* resultSt = [streetTextBox stringByAppendingString: str];
		
		NSString* resultContriCiti = [resultCo stringByAppendingString: resultCi];
		NSString* perenos = [resultContriCiti stringByAppendingString: strn];

		//location in string for parse table
		resultFinalForTable =[resultContriCiti stringByAppendingString: streetTextBox];
		
		resultFinal = [perenos stringByAppendingString: streetTextBox];
		if(resultFinal){
		self.locationLabel.text = resultFinal;
		}
	}];
}
- (IBAction)helpButton:(id)sender {
	
	
	PFUser *user = [PFUser currentUser];
	

	PFObject *postObject = [PFObject objectWithClassName:PAWParsePostsClassName];
	postObject[PAWParsePostTextKey] = self.infoTextFiled.text;
	postObject[PAWParsePostUserKey] = user;

	NSString * moreInfoTextFiledText = self.moreInfoTextFiled.text;
	NSString *secondString = @"";
	BOOL check = [secondString isEqualToString:moreInfoTextFiledText];
	
	if(check == NO){
	postObject[@"moreinfo"] = self.moreInfoTextFiled.text;
	}
	
	postObject[@"time"] = self.datePicker.date;
	
	if(self.switchLocation.on){
		CLLocationCoordinate2D currentCoordinate = currentLocation.coordinate;
		PFGeoPoint *currentPoint = [PFGeoPoint geoPointWithLatitude:currentCoordinate.latitude
														  longitude:currentCoordinate.longitude];
		postObject[PAWParsePostLocationKey] = currentPoint;
		postObject[@"locationstring"] = resultFinalForTable;


	}
	postObject[@"countRank"] = countRank;
	postObject[@"complexity"] = complexity;
	
	PFFile *smallavatar =	[user objectForKeyedSubscript:@"smallavatar"];
	postObject[@"smalluseravatar"] = smallavatar;

	NSData *imageData = UIImagePNGRepresentation(image);
	postObject[@"image"] = [PFFile fileWithData:imageData];
	
	PFACL *readOnlyACL = [PFACL ACL];
	[readOnlyACL setPublicReadAccess:YES];
	[readOnlyACL setPublicWriteAccess:NO];
	postObject.ACL = readOnlyACL;
	
	[postObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
		if (error) {
			NSLog(@"Couldn't save!");
			NSLog(@"%@", error);
			UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[error userInfo][@"error"]
																message:nil
															   delegate:self
													  cancelButtonTitle:nil
													  otherButtonTitles:@"Ok", nil];
			[alertView show];
			return;
		}
		if (succeeded) {
			NSLog(@"Successfully saved!");
			NSLog(@"%@", postObject);
			dispatch_async(dispatch_get_main_queue(), ^{
				[[NSNotificationCenter defaultCenter] postNotificationName:PAWPostCreatedNotification object:nil];
			});
		} else {
			NSLog(@"Failed to save.");
		}
	}];
	

}
-(void)complexityNotification:(NSNotification*) notification{
	self.complexity.titleLabel.text = complexity;
}
-(void)categoryNotification:(NSNotification*) notification{
	self.category.titleLabel.text = category;
}
-(void)rankCountNotification:(NSNotification*) notification{
	self.countRank.titleLabel.text = countRank;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)category:(id)sender {
	PAWCategory *post = [[PAWCategory alloc] initWithNibName:@"PAWCategory" bundle:nil];
	[self.navigationController pushViewController:post animated:YES];
}
- (IBAction)complexity:(id)sender {
	PAWComplexity *post = [[PAWComplexity alloc] initWithNibName:@"PAWComplexity" bundle:nil];
	[self.navigationController pushViewController:post animated:YES];
}

- (IBAction)count:(id)sender {
	PAWCount *post = [[PAWCount alloc] initWithNibName:@"PAWCount" bundle:nil];
	[self.navigationController pushViewController:post animated:YES];

}

- (IBAction)pickerPhoto:(id)sender {
	picker2 = [[UIImagePickerController alloc] init];
	picker2.delegate = self;
	[picker2 setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
	[self presentModalViewController:picker2 animated:YES];
}



-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
	image = [info objectForKey:UIImagePickerControllerOriginalImage];
	[self dismissModalViewControllerAnimated:YES];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
	[self dismissModalViewControllerAnimated:YES];
	
}
@end

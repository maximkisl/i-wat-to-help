#import "PAWWallPostCreateViewController.h"

#import <Parse/Parse.h>
#import "PAWPost.h"
#import "PAWConstants.h"
#import "PAWConfigManager.h"
#import "IWTHPost.h"
#import "PAWWallPostCreateViewController.h"
#import "PAWWallViewController.h"
@interface IWTHPost()

@end

@implementation IWTHPost

CLLocation * currentLocation;
CLLocationManager * locationManager;

CLLocation *locationController;
NSString* resultFinal;


-(void)viewDidLoad {
	[super viewDidLoad];
	
	
	
	[self.ScrollView setScrollEnabled:YES];
	[self.ScrollView setContentSize:CGSizeMake(320,860)];
	
	[self createUI];
	

//	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationNotification:) name:HMSerLocationDidChangeNotification object:nil];

	[[[CLGeocoder alloc]init] reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
		CLPlacemark *placemark = placemarks[0];
//		NSArray *lines = placemark.addressDictionary[ @"FormattedAddressLines"];
//		NSString *addressString = [lines componentsJoinedByString:@","];
		
		NSString * countryTextBox =[placemark.addressDictionary valueForKey:@"Country"];
		NSString *citiTextBox =[placemark.addressDictionary valueForKey:@"City"];
		NSString *streetTextBox =[placemark.addressDictionary valueForKey:@"Street"];		
//		self.zipCodLbl.text =[placemark.addressDictionary valueForKey:@"ZIP"];
		
		NSString * str = @",";
		
		
		NSString* resultCo = [countryTextBox stringByAppendingString: str];
		NSString* resultCi = [citiTextBox stringByAppendingString: str];
		NSString* resultSt = [streetTextBox stringByAppendingString: str];

		NSString* resultContriCiti = [resultSt stringByAppendingString: resultCi];
		resultFinal = [resultContriCiti stringByAppendingString: resultCo];

//		[[NSNotificationCenter defaultCenter] postNotificationName:HMSerLocationDidChangeNotification object:nil];
	}];

	
}


-(void)createUI{
	UILabel  * infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(27, 37, 238, 21)];
	infoLabel.text = @"Opisanie prosbi";
	[self.view addSubview:infoLabel];



}


-(void)locationNotification:(NSNotification*) notification{
//	self.moreInfo  [[UITextField alloc]init];
//	self.moreInfo.text = resultFinal;
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}
//- (NSString *)countryNameByCode:(NSString*)countryCode {
//	return [[NSLocale systemLocale] displayNameForKey:NSLocaleCountryCode value:countryCode];
//}
- (IBAction)helpButton:(id)sender {
	self.info.text  = @"asdad";
}


//- (IBAction)delete:(id)sender {
//	
//	PFQuery *query = [PFQuery queryWithClassName:@"Comment"];
//	[query whereKey:@"author" equalTo:[PFUser currentUser]];
//	
//	PFQuery *query2 = [PFQuery queryWithClassName:@"Comment"];
//	[query2 whereKey:@"frends" equalTo:[PFUser currentUser]];
//	
//	PFQuery *mainQuery = [PFQuery orQueryWithSubqueries:@[query,query2]];
//	[mainQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
//				NSLog(@"findObjectsInBackgroundWithBlock %@", objects);
//		if(objects.count > 0){
//				for (PFObject *object in objects) {
//					NSLog(@"PFUser %@", object);
//				}
//		}else
//				{
//	
//	
//			PFObject *blogpost = [PFObject objectWithClassName:@"BlogPost"];
//	
//			[blogpost setObject:@"message text for user" forKey:@"message"];
//			
//			[blogpost setObject:[PFUser currentUser] forKey:@"user"];
//
//	
//			PFObject *comment = [PFObject objectWithClassName:@"Comment"];
//	
//			[comment addUniqueObjectsFromArray:@[blogpost]forKey:@"messages"];
//
//			[comment setObject:[PFUser currentUser] forKey:@"author"];
//			
//			[comment setObject:[PFUser currentUser] forKey:@"frends"];
//			
//			[comment setObject:blogpost forKey:@"post"];
//			
//			[comment saveEventually];
//			
//		}
//	}];
//	
//
//	
//	
//	
//	
//	
//	
//	
////	PFQuery *query = [PFQuery queryWithClassName:@"user"];
////	
////	//[query includeKey:@"firstname"];
////
////	
////	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
////		NSLog(@"findObjectsInBackgroundWithBlock %@", objects);
////
////		for (PFObject *object in objects) {
////			NSLog(@"PFUser %@", object);
////		}
////	}];
//	
//	}
//- (IBAction)post:(id)sender {
//	
//	// Resign first responder to dismiss the keyboard and capture in-flight autocorrect suggestions
//	// Отставку первый ответчик уволить клавиатуры и захват в полете автозамены предложения |
////	[self.textView resignFirstResponder];
//	
//	// Capture current text field contents:
//	// Захват текущего содержимого текстового поля :
////	[self updateCharacterCountLabel];
////	BOOL isAcceptableAfterAutocorrect = [self checkCharacterCount];
//	
////	if (!isAcceptableAfterAutocorrect) {
////		[self.textView becomeFirstResponder];
////		return;
////	}
//	
//	
//	
//	
//	// Data prep:
//	// Подготовительные данных:
//	CLLocation *currentLocation = [self.dataSource currentLocationForWallPostCrateViewController:self];
//	CLLocationCoordinate2D currentCoordinate = currentLocation.coordinate;
//	PFGeoPoint *currentPoint = [PFGeoPoint geoPointWithLatitude:currentCoordinate.latitude
//													  longitude:currentCoordinate.longitude];
//	PFUser *user = [PFUser currentUser];
////	PFRelation *relation = [ relationForKey:@"myposts"];
//
//	// Stitch together a postObject and send this async to Parse
//	// Стежка вместе postObject и отправьте асинхронный для разбора
//	PFObject *postObject = [PFObject objectWithClassName:PAWParsePostsClassName];
//	
//	PFRelation *relation = [user relationForKey:@"followers"];
//
//	postObject[PAWParsePostTextKey] = @"Hello world!";
//	postObject[PAWParsePostUserKey] = user;
//	postObject[PAWParsePostLocationKey] = currentPoint;
//	
//	NSArray *array =[[NSArray alloc] initWithObjects:user.objectId, nil];
//	NSData *data = [NSKeyedArchiver archivedDataWithRootObject:array];
//	postObject[@"followers"] = array;
//	
//	// Use PFACL to restrict future modifications to this object.
//	// Использование PFACL ограничить будущие изменения в данного объекта.
//	PFACL *readOnlyACL = [PFACL ACL];
//	[readOnlyACL setPublicReadAccess:YES];
//	[readOnlyACL setPublicWriteAccess:YES];
//	postObject.ACL = readOnlyACL;
//	
//	
//	[postObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//		if (error) {
//			NSLog(@"Couldn't save!");
//			NSLog(@"%@", error);
//			UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[error userInfo][@"error"]
//																message:nil
//															   delegate:self
//													  cancelButtonTitle:nil
//													  otherButtonTitles:@"Ok", nil];
//			[alertView show];
//			return;
//		}
//		if (succeeded) {
//			[relation addObject:postObject];
//			[user saveInBackground];
//
//
//			NSLog(@"Successfully saved!");
//			NSLog(@"OBjeCTID !!! :%@", postObject[@"text"]);
//			
//			dispatch_async(dispatch_get_main_queue(), ^{
//				[[NSNotificationCenter defaultCenter] postNotificationName:PAWPostCreatedNotification object:nil];
//			});
//		} else {
//			NSLog(@"Failed to save.");
//		}
//	}];
//	
//	[self dismissViewControllerAnimated:YES completion:nil];
//
//}

@end

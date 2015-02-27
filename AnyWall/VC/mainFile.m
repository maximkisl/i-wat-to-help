#import "mainFile.h"
#include <QuartzCore/QuartzCore.h>
#import "PAWSettingsViewController.h"
#import "PAWConstants.h"
#import "PAWWallViewController.h"
#include <QuartzCore/QuartzCore.h>
#import "PAWWallPostCreateViewController.h"
#import "PAWWallPostsTableViewController.h"
#import "mainF.h"
#import "SecondVC.h"
#import "IWTHProfile.h"
#import "PAWPost.h"
#import "PAWLoginViewController.h"



@interface mainFile ()
<PAWLoginViewControllerDelegate>
@end

@implementation mainFile
IWTHProfile *profile;
NSString * name;

- (id)init
{
    self = [super init];
    if (self) {
	//	AVATAR = [UIImage imageNamed:@"testImage"];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(usernameNotification:) name:HMUserNameDidChangeNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(avatarNotification:) name:HMAvatarImageDidChangeNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(firstnameNotification:) name:HMFirstNameDidChangeNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lastnameNotification:) name:HMLastNameDidChangeNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(phoneNotification:) name:HMPhoneDidChangeNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emailNotification:) name:HMEmailDidChangeNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countryNotification:) name:HMCountryDidChangeNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityNotification:) name:HMCityDidChangeNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(carmaNotification:) name:HMCarmaDidChangeNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rankNotification:) name:HMRankDidChangeNotification object:nil];

		profile = [[IWTHProfile alloc] init];
			self.title = @"Профиль";
//		self.mf = [[mainF alloc] init];

			}
	
    return self;
}
-(void)usernameNotification:(NSNotification*) notification{
	
	[self.login setText:profile.username];
	self.login.font = [UIFont fontWithName:HMDamascusLight size:17];

}
-(void)firstnameNotification:(NSNotification*) notification{

	[self.username setText:profile.firstname];

	self.username.font = [UIFont fontWithName:HMDamascusLight size:17];

}
-(void)lastnameNotification:(NSNotification*) notification{
	[self.lastname setText:profile.lastName];
	self.lastname.font = [UIFont fontWithName:HMDamascusLight size:17];

}
-(void)phoneNotification:(NSNotification*) notification{
	[self.phone setText:profile.phone];
	self.phone.font = [UIFont fontWithName:HMDamascusLight size:17];

}
-(void)emailNotification:(NSNotification*) notification{
	[self.email setText:profile.email];
	self.email.font = [UIFont fontWithName:HMDamascusLight size:17];

}
-(void)countryNotification:(NSNotification*) notification{
	[self.country setText:profile.country];
	self.country.font = [UIFont fontWithName:HMDamascusLight size:17];

}
-(void)cityNotification:(NSNotification*) notification{
	[self.city setText:profile.city];
	self.city.font = [UIFont fontWithName:HMDamascusLight size:17];

}
-(void)carmaNotification:(NSNotification*) notification{
	[self.carma setText:profile.carma];
	self.carma.font = [UIFont fontWithName:HMDamascusLight size:17];

}
-(void)rankNotification:(NSNotification*) notification{
	[self.rank setText:profile.rank];
	self.rank.font = [UIFont fontWithName:HMDamascusLight size:17];

}

-(void)avatarNotification:(NSNotification*) notification{
//	imageTestProfil2.backgroundColor = [UIColor redColor];
	[self.imageTestProfil2 setImage:profile.avatar];

//	rank.text =  @"!!!!!!!!!!:";
	//UIImageView* imageTestProfil5 =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 500, 500)];
	
	//[imageTestProfil2 setImage: f.avatar];
	NSLog(@"avatarNotification");
}

//-(void)stringByAppendingString:(NSString*)first and:(NSString*)last{
//
//	NSString *fm = first;
//	NSString *p = @" ";
//	NSString* firstn = [fm stringByAppendingString: p];
//	
//	NSString *lastn =last;
//	NSString* resultS = [firstn stringByAppendingString: lastn];
//	
////	return resultS;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
	

//	PFUser *user = [PFUser currentUser];
//	[profile setUsername:[user objectForKey:PAWParsePostUsernameKey]];
//	[profile setFirstname:[user objectForKey:PAWParsePostFirstNameKey]];
//	[profile setLastName:[user objectForKey:PAWParsePostLastNameKey]];
//	[profile setPhone:[user objectForKey:PAWParsePostPhoneKey]];
//	[profile setEmail:[user objectForKey:PAWParsePostEmailKey]];
//	[profile setCountry:[user objectForKey:PAWParsePostCountryKey]];
//	[profile setCity:[user objectForKey:PAWParsePostCityKey]];
//	[profile setCarma:[user objectForKey:PAWParsePostCarmaKey]];
//	[profile setRank:[user objectForKey:PAWParsePostRankKey]];
//	
////	NSData *data = [[NSData alloc] initWithData:[user objectForKey:@"smallavatar"]];
//	PFFile *fileImage =[user objectForKey:@"avatar"];
//	NSData *data = [fileImage getData];
//	[profile setAvatar:[UIImage imageWithData:data]];

	
	
	PFQuery *query= [PFUser query];
	
	[query whereKey:@"username" equalTo:[[PFUser currentUser]username]];
	
	[query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error){
//		[profile setUsername:[object objectForKey:PAWParsePostUsernameKey]];
//		NSString *fm =[object objectForKey:PAWParsePostFirstNameKey];
//		NSString *p = @" ";
//		NSString* firstn = [fm stringByAppendingString: p];
//
//		NSString *lastn =[object objectForKey:PAWParsePostLastNameKey];
//		NSString* resultS = [firstn stringByAppendingString: lastn];
		
		[profile setFirstname:[object objectForKey:PAWParsePostFirstNameKey]];
		[profile setLastName:[object objectForKey:PAWParsePostLastNameKey]];

		
		
		[profile setEmail:[object objectForKey:PAWParsePostUsernameKey]];

		
		
		
		[profile setPhone:[object objectForKey:PAWParsePostPhoneKey]];
		[profile setCountry:[object objectForKey:PAWParsePostCountryKey]];
		[profile setCity:[object objectForKey:PAWParsePostCityKey]];
		[profile setCarma:[object objectForKey:PAWParsePostCarmaKey]];
		[profile setRank:[object objectForKey:PAWParsePostRankKey]];
		
		PFFile *userImageFile = object[PAWParsePostAvatarKey];
		[userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
			if (!error) {
				[profile setAvatar: [UIImage imageWithData:imageData]];
			}if (error)
			{
				NSLog(@"Failed to save Parse assignment with error:<mainFile> %@", error.localizedDescription);
			}
		}];
	
	
	}];
	
	
	
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Изменить"
																			  style:UIBarButtonItemStylePlain
																			 target:self
																			 action:@selector(postButtonSelecte:)];
	
//	self.imageTestProfil2.backgroundColor = [UIColor darkGrayColor];
	
	CALayer * ourLayer = [self.imageTestProfil2 layer]; // Будем округлять UIImageView
	ourLayer.cornerRadius = 50.0f;           // Polovina korotkoi storoni, Задаем радиус для округления.
	ourLayer.masksToBounds = YES;           // Чтобы за овальной границей в углах ничего не рисовалось
	ourLayer.borderWidth = 0.0f;            // Границу рисовать не будем. Если нужна - указываем толщину
	
//	CGRect buttonFrame = CGRectMake( 100, 110, 250, 50 );
//	UIButton *photoButton = [[UIButton alloc] initWithFrame: buttonFrame];
//	[photoButton setTitle: @"Изменить аватар" forState: UIControlStateNormal];
//	[photoButton addTarget:self action:@selector(btnSelected:) forControlEvents:UIControlEventTouchUpInside];
//	[photoButton setTitleColor: [UIColor redColor] forState: UIControlStateNormal];
	

	
//	UILabel *carmaCounter = [[UILabel alloc]initWithFrame:CGRectMake(220, 90, 100, 20)];
//	self.carma.text =  @"128";
////	UILabel *rankCounter = [[UILabel alloc]initWithFrame:CGRectMake(150, 150, 150, 20)];
//	self.rank.text =  @"Добродетель";
//	
////	UILabel *firstName = [[UILabel alloc]initWithFrame:CGRectMake(30, 190, 100, 20)];
//	//firstName.text =  @"Игорь";
//	self.username.text = name;
//
////	UILabel *lastName = [[UILabel alloc]initWithFrame:CGRectMake(90, 190, 100, 20)];
//	self.lastname.text =@"Гастов";
//
////	UILabel *country = [[UILabel alloc]initWithFrame:CGRectMake(30, 260, 100, 20)];
//	self.country.text =  @"Украина";
////	UILabel *city = [[UILabel alloc]initWithFrame:CGRectMake(30, 290, 100, 20)];
//	self.city.text = profile.city ;
	
//	CGRect citiButtonFrame = CGRectMake( 0, 330, 200, 50 );
//	UIButton *citiButton = [[UIButton alloc] initWithFrame: citiButtonFrame];
//	[citiButton setTitle: @"city/country" forState: UIControlStateNormal];
//	[citiButton addTarget:self action:@selector(aMethod:) forControlEvents:UIControlEventTouchUpInside];
//	[citiButton setTitleColor: [UIColor redColor] forState: UIControlStateNormal];
	
//	UILabel *email = [[UILabel alloc]initWithFrame:CGRectMake(30, 370, 200, 20)];
//	[self.email setText:@"Gastovigor@gmail.com"];
	
//	UILabel *phone = [[UILabel alloc]initWithFrame:CGRectMake(30, 400, 200, 20)];
//	[self.phone setText:@"80-63-411-81-60"];
	
	[self.view addSubview:rank];
	[self.view addSubview:self.imageTestProfil2];
}
-(IBAction)postButtonSelecte:(id)sender{
	mainF *viewController = [[mainF alloc] initWithNibName:nil bundle:nil];
	//viewController.delegate = self;
	[self.navigationController pushViewController:viewController animated:YES];
	//[self presentedViewController:f];
}




-(IBAction)aMethod:(id)sender{

	
	//	CLLocation *currentLocation = [self.delegate currentLocationFormainFileViewController:self];
//
//	CLGeocoder* geoCoder = [[CLGeocoder alloc] init];
//	
//	[geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error){
//	
//		NSString* message = nil;
//		
//		if(error){
//			message = [error localizedDescription];
//		}else {
//			if ([placemarks count] > 0) {
//    MKPlacemark* placeMark = [placemarks firstObject];
//				
//				message = [placeMark.addressDictionary description];
//			}else{
//			message = @"NO PLECemark found";
//			}
//		
//		}
//		[[[UIAlertView alloc]
//		  initWithTitle:@"Location" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]show];
//	}];
	
//	UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Select Sharing option:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
//							@"Share on Facebook",
//							@"Share on Twitter",
//							@"Share via E-mail",
//							@"Save to Camera Roll",
//							@"Rate this App",
//							nil];
//	popup.tag = 1;
//	[popup showInView:[UIApplication sharedApplication].keyWindow];
}

//- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
//
//	switch (popup.tag) {
//		case 1: {
//			switch (buttonIndex) {
//				case 0:
//					NSLog(@"case0");
//					break;
//				case 1:
//					NSLog(@"case2");
//					break;
//				case 2:
//					NSLog(@"case3");
//					break;
//				case 3:
//					NSLog(@"case4");
//					break;
//				case 4:
//					NSLog(@"case5");
//					break;
//				default:
//					break;
//			}
//			break;
//		}
//		default:
//			break;
// }
//}
-(IBAction)btnSelected:(id)sender{
	
//	picker2 = [[UIImagePickerController alloc] init];
//	picker2.delegate = self;
//	[picker2 setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
//	
//	[self presentModalViewController:picker2 animated:YES];
	//[picker2 release];
	
}

//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
//	UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//	
//	//[imageTestProfil setImage:image];
//
//	[self dismissModalViewControllerAnimated:YES];
//}
//
//-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
//	[self dismissModalViewControllerAnimated:YES];
//
//}
- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (IBAction)save:(id)sender {

}


@end

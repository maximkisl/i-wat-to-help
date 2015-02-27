#import "PAWWallViewController.h"
#import "SecondVC.h"
#import "PAWConstants.h"
#import "PAWConstants.h"
#import "PAWPost.h"
#import "PAWWallPostCreateViewController.h"
#import "PAWWallPostsTableViewController.h"
#import "IWTHProfile.h"
#import "PAWAppDelegate.h"
#import "LeftMenuTVC.h"
#import "mainF.h"
#import "PAWLoginViewController.h"


@implementation mainF
IWTHProfile* profile;

#pragma mark -
#pragma mark Init
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(avatarNotification:) name:HMAvatarImageDidChangeNotification object:nil];
//		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(usernameNotification:) name:HMUserNameDidChangeNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(firstnameNotification:) name:HMFirstNameDidChangeNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lastnameNotification:) name:HMLastNameDidChangeNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(phoneNotification:) name:HMPhoneDidChangeNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emailNotification:) name:HMEmailDidChangeNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countryNotification:) name:HMCountryDidChangeNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityNotification:) name:HMCityDidChangeNotification object:nil];
		
		profile = [[IWTHProfile alloc]init];
	}
	
	return self;
}

//-(void)usernameNotification:(NSNotification*) notification{
//	[self.firstName setText:profile.firstname];
//}
-(void)firstnameNotification:(NSNotification*) notification{
	[self.firstName setText:profile.firstname];
	self.firstName.font = [UIFont fontWithName:HMDamascusLight size:17];

}
-(void)lastnameNotification:(NSNotification*) notification{
	[self.lastName setText:profile.lastName];
	self.lastName.font = [UIFont fontWithName:HMDamascusLight size:17];

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
-(void)avatarNotification:(NSNotification*) notification{
	[self.imageTestProfil setImage:profile.avatar];

}

- (void)viewDidLoad
{
	[super viewDidLoad];
	PFQuery *query= [PFUser query];

	[query whereKey:@"username" equalTo:[[PFUser currentUser]username]];
	
	[query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error){
		[profile setFirstname:[object objectForKey:PAWParsePostFirstNameKey]];
		[profile setLastName:[object objectForKey:PAWParsePostLastNameKey]];
		[profile setPhone:[object objectForKey:PAWParsePostPhoneKey]];
		
		
		[profile setCountry:[object objectForKey:PAWParsePostCountryKey]];
		[profile setCity:[object objectForKey:PAWParsePostCityKey]];
		[profile setCarma:[object objectForKey:PAWParsePostCarmaKey]];
		[profile setRank:[object objectForKey:PAWParsePostRankKey]];
	
		NSDate* date  ;
		date = object.createdAt;
		NSLog(@"%@", date);

		PFFile *userImageFile = object[PAWParsePostAvatarKey];
		[userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
			if (!error) {
				[profile setAvatar: [UIImage imageWithData:imageData]];
			}if (error)
			{
				NSLog(@"Failed to save Parse assignment with error<mainF>: %@", error.localizedDescription);
			}
		}];
		
		
	}];
	
	_scrolView.scrollEnabled = YES;
	_scrolView.contentSize = CGSizeMake(320, 800);
	[_imageTestProfil setImage:profile.avatar];
//	_imageTestProfil.backgroundColor = [UIColor darkGrayColor];
	
	CALayer * ourLayer = [_imageTestProfil layer]; // Будем округлять UIImageView
	ourLayer.cornerRadius = 50.0f;           // Polovina korotkoi storoni, Задаем радиус для округления.
	ourLayer.masksToBounds = YES;           // Чтобы за овальной границей в углах ничего не рисовалось
	ourLayer.borderWidth = 0.0f;            // Границу рисовать не будем. Если нужна - указываем толщину
	
	CGRect buttonFrame = CGRectMake( 100, 110, 250, 20 );

	[_photoButton setTitle: @"Изменить аватар" forState: UIControlStateNormal];
	[_photoButton addTarget:self action:@selector(btnSelected:) forControlEvents:UIControlEventTouchUpInside];
	[_photoButton setTitleColor: [UIColor redColor] forState: UIControlStateNormal];
	
//	_firstName.text =  @"Игорь";
//	
//	_lastName.text= @"Гастов";
//	
//	_country.text =  @"Страна";
	
	
	[_countryButton setTitle: @"Изменить страну" forState: UIControlStateNormal];
	[_countryButton addTarget:self action:@selector(aMethod2:) forControlEvents:UIControlEventTouchUpInside];
	[_countryButton setTitleColor: [UIColor redColor] forState: UIControlStateNormal];
	
//	_city.text =  @"Город";
	
	[_citiButton setTitle: @"Изменить город" forState: UIControlStateNormal];
	[_citiButton addTarget:self action:@selector(aMethod:) forControlEvents:UIControlEventTouchUpInside];
	[_citiButton setTitleColor: [UIColor redColor] forState: UIControlStateNormal];
	
//	[_email setText:@"Gastovigor@gmail.com"];
//	
//	[_phone setText:@"80-63-411-81-60"];
	
	[_saveButton setTitle: @"Сохранить" forState: UIControlStateNormal];
	[_saveButton addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
	[_saveButton setTitleColor: [UIColor blueColor] forState: UIControlStateNormal];
}

-(IBAction)save:(id)sender{
	[profile setFirstname:self.firstName.text];
	[profile setLastName:self.lastName.text];
	[profile setCity:self.city.text];
	[profile setCountry:self.country.text];
//	[profile setEmail:self.email.text];
	[profile setPhone:self.phone.text];
	[profile setAvatar:profile.avatar];
	
	PFQuery *query= [PFUser query];
	[query whereKey:@"username" equalTo:[[PFUser currentUser]username]];
	[query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error){
		object[PAWParsePostFirstNameKey] = self.firstName.text;
		object[PAWParsePostLastNameKey] = self.lastName.text;
		object[PAWParsePostCityKey] = self.city.text;
		object[PAWParsePostCountryKey] = self.country.text;
//		object[PAWParsePostEmailKey] = self.email.text;
		object[PAWParsePostPhoneKey] = self.phone.text;
//		object[PAWParsePostUserKey] = self.firstName.text;

		NSData *imageData = UIImagePNGRepresentation(profile.avatar);
		object[PAWParsePostAvatarKey] = [PFFile fileWithData:imageData];
		
		[object saveInBackground];
	}];
	UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:@"Сохранение"
													   message:@"Ваши данные сохранены."
													  delegate:self
											 cancelButtonTitle:@"OK"
											 otherButtonTitles:nil];
	[theAlert show];
	

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 0)
	{
		[self.navigationController popViewControllerAnimated:YES];
	}
}

-(IBAction)postButtonSelecte:(id)sender{
//	mainF *viewController = [[mainF alloc] initWithNibName:nil bundle:nil];
//	viewController.delegate = self;
//	[self.navigationController setViewControllers:@[ viewController ] animated:NO];
	
}
-(IBAction)aMethod2:(id)sender{
	UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Выберите страну из списка" delegate:self cancelButtonTitle:@"Отмена" destructiveButtonTitle:nil otherButtonTitles:
							@"Украина",
							@"Россия",
							@"Белоруссия",
							nil];
	popup.tag = 2;
	[popup showInView:[UIApplication sharedApplication].keyWindow];
}

-(IBAction)aMethod:(id)sender{
		UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Выберите город из списка:" delegate:self cancelButtonTitle:@"Отмена" destructiveButtonTitle:nil otherButtonTitles:
								@"Киев",
								@"Москва",
								@"Минск",
								nil];
		popup.tag = 1;
		[popup showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {

	switch (popup.tag) {
		case 1: {
			switch (buttonIndex) {
				case 0:
					_city.text =  @"Киев";
					NSLog(@"case0");
					break;
				case 1:
					_city.text =  @"Москва";
					NSLog(@"case2");
					break;
				case 2:
					_city.text = @"Минск";
					NSLog(@"case3");
					break;
				case 3:
					NSLog(@"case4");
					break;
				case 4:
					NSLog(@"case5");
					break;
				default:
					break;
			}
			break;
		}
		default:
			break;
 }
	switch (popup.tag) {
		case 2: {
			switch (buttonIndex) {
				case 0:
					_country.text = @"Украина";
					NSLog(@"case0");
					break;
				case 1:
					_country.text = @"Россия";
					NSLog(@"case2");
					break;
				case 2:
					_country.text = @"Белоруссия";
					NSLog(@"case3");
					break;
				case 3:
					NSLog(@"case4");
					break;
				case 4:
					NSLog(@"case5");
					break;
				default:
					break;
			}
			break;
		}
		default:
			break;
 }

	
	
}
-(IBAction)btnSelected:(id)sender{
	
	picker2 = [[UIImagePickerController alloc] init];
	picker2.delegate = self;
	[picker2 setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
	
	[self presentModalViewController:picker2 animated:YES];
	//[picker2 release];
	
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
	UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
	[profile setAvatar:image];
	[_imageTestProfil setImage:profile.avatar];

	[self dismissModalViewControllerAnimated:YES];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
	[self dismissModalViewControllerAnimated:YES];
	
}
- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

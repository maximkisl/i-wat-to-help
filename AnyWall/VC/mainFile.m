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

@interface mainFile ()
<PAWWallViewControllerDelegate,
PAWSettingsViewControllerDelegate, mainFileDelegate, mainFDelegate>

@end
@implementation mainFile


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

			self.title = @"Профиль";
			imageTestProfil = [[UIImageView alloc] initWithFrame:CGRectMake(30, 80, 100, 100)];
		    }
	
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Изменить"
																			  style:UIBarButtonItemStylePlain
																			 target:self
																			 action:@selector(postButtonSelecte:)];
	
	[imageTestProfil setImage:[UIImage imageNamed:@"testImage"]];
	imageTestProfil.backgroundColor = [UIColor darkGrayColor];
	
	CALayer * ourLayer = [imageTestProfil layer]; // Будем округлять UIImageView
	ourLayer.cornerRadius = 50.0f;           // Polovina korotkoi storoni, Задаем радиус для округления.
	ourLayer.masksToBounds = YES;           // Чтобы за овальной границей в углах ничего не рисовалось
	ourLayer.borderWidth = 0.0f;            // Границу рисовать не будем. Если нужна - указываем толщину
	
//	CGRect buttonFrame = CGRectMake( 100, 110, 250, 50 );
//	UIButton *photoButton = [[UIButton alloc] initWithFrame: buttonFrame];
//	[photoButton setTitle: @"Изменить аватар" forState: UIControlStateNormal];
//	[photoButton addTarget:self action:@selector(btnSelected:) forControlEvents:UIControlEventTouchUpInside];
//	[photoButton setTitleColor: [UIColor redColor] forState: UIControlStateNormal];
	
	UILabel *carma = [[UILabel alloc]initWithFrame:CGRectMake(150, 90, 100, 20)];
	carma.text =  @"Карма:";
	UILabel *rank = [[UILabel alloc]initWithFrame:CGRectMake(150, 120, 100, 20)];
	rank.text =  @"Звание:";
	
	UILabel *carmaCounter = [[UILabel alloc]initWithFrame:CGRectMake(220, 90, 100, 20)];
	carmaCounter.text =  @"128";
	UILabel *rankCounter = [[UILabel alloc]initWithFrame:CGRectMake(150, 150, 150, 20)];
	rankCounter.text =  @"Добродетель";
	
	UILabel *firstName = [[UILabel alloc]initWithFrame:CGRectMake(30, 190, 100, 20)];
	firstName.text =  @"Игорь";
	UILabel *lastName = [[UILabel alloc]initWithFrame:CGRectMake(90, 190, 100, 20)];
	[lastName setText:@"Гастов"];

	UILabel *country = [[UILabel alloc]initWithFrame:CGRectMake(30, 260, 100, 20)];
	country.text =  @"Украина";
	UILabel *city = [[UILabel alloc]initWithFrame:CGRectMake(30, 290, 100, 20)];
	city.text =  @"Киев";
	
//	CGRect citiButtonFrame = CGRectMake( 0, 330, 200, 50 );
//	UIButton *citiButton = [[UIButton alloc] initWithFrame: citiButtonFrame];
//	[citiButton setTitle: @"city/country" forState: UIControlStateNormal];
//	[citiButton addTarget:self action:@selector(aMethod:) forControlEvents:UIControlEventTouchUpInside];
//	[citiButton setTitleColor: [UIColor redColor] forState: UIControlStateNormal];
	
	UILabel *email = [[UILabel alloc]initWithFrame:CGRectMake(30, 370, 200, 20)];
	[email setText:@"Gastovigor@gmail.com"];
	
	UILabel *phone = [[UILabel alloc]initWithFrame:CGRectMake(30, 400, 200, 20)];
	[phone setText:@"80-63-411-81-60"];
	
	[self.view addSubview:rank];
	[self.view addSubview:carma];
	
	[self.view addSubview:rankCounter];
	[self.view addSubview:carmaCounter];
	
	[self.view addSubview:firstName];
	[self.view addSubview:lastName];
	
	[self.view addSubview:country];
	[self.view addSubview:city];
//	[self.view addSubview:citiButton];

	[self.view addSubview:email];
	[self.view addSubview:phone];

	[self.view addSubview:imageTestProfil];
//	[self.view addSubview:photoButton];

}
-(IBAction)postButtonSelecte:(id)sender{
	mainF *viewController = [[mainF alloc] initWithNibName:nil bundle:nil];
	viewController.delegate = self;
	[self.navigationController pushViewController:viewController animated:YES];

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
	
	picker2 = [[UIImagePickerController alloc] init];
	picker2.delegate = self;
	[picker2 setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
	
	[self presentModalViewController:picker2 animated:YES];
	//[picker2 release];
	
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
	UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
	
	[imageTestProfil setImage:image];

	[self dismissModalViewControllerAnimated:YES];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
	[self dismissModalViewControllerAnimated:YES];

}
- (void)dealloc {
	
}
@end

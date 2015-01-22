#import "PAWWallViewController.h"
#import "SecondVC.h"

#import "PAWConstants.h"
#import "PAWPost.h"
#import "PAWWallPostCreateViewController.h"
#import "PAWWallPostsTableViewController.h"

#import "LeftMenuTVC.h"
#import "mainF.h"



@implementation mainF

#pragma mark -
#pragma mark Init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		
		//self.title = @"Профиль";
		imageTestProfil = [[UIImageView alloc] initWithFrame:CGRectMake(30, 80, 100, 100)];
	}
	
	return self;
}
UILabel *city;
UILabel *country;
- (void)viewDidLoad
{
	[super viewDidLoad];
	[imageTestProfil setImage:[UIImage imageNamed:@"testImage"]];
	imageTestProfil.backgroundColor = [UIColor darkGrayColor];
	
	CALayer * ourLayer = [imageTestProfil layer]; // Будем округлять UIImageView
	ourLayer.cornerRadius = 50.0f;           // Polovina korotkoi storoni, Задаем радиус для округления.
	ourLayer.masksToBounds = YES;           // Чтобы за овальной границей в углах ничего не рисовалось
	ourLayer.borderWidth = 0.0f;            // Границу рисовать не будем. Если нужна - указываем толщину
	
	CGRect buttonFrame = CGRectMake( 100, 110, 250, 20 );
	UIButton *photoButton = [[UIButton alloc] initWithFrame: buttonFrame];
	[photoButton setTitle: @"Изменить аватар" forState: UIControlStateNormal];
	[photoButton addTarget:self action:@selector(btnSelected:) forControlEvents:UIControlEventTouchUpInside];
	[photoButton setTitleColor: [UIColor redColor] forState: UIControlStateNormal];
	
	UITextField *firstName = [[UITextField alloc]initWithFrame:CGRectMake(30, 190, 200, 20)];
	firstName.text =  @"Игорь";
	UITextField *lastName = [[UITextField alloc]initWithFrame:CGRectMake(30, 220, 200, 20)];
	[lastName setText:@"Гастов"];
	
	country = [[UILabel alloc]initWithFrame:CGRectMake(30, 260, 200, 20)];
	country.text =  @"Страна";
	
	
	UIButton *countryButton = [[UIButton alloc] initWithFrame: CGRectMake( 0, 300, 200, 20 )];
	[countryButton setTitle: @"Изменить страну" forState: UIControlStateNormal];
	[countryButton addTarget:self action:@selector(aMethod2:) forControlEvents:UIControlEventTouchUpInside];
	[countryButton setTitleColor: [UIColor redColor] forState: UIControlStateNormal];
	
	city = [[UILabel alloc]initWithFrame:CGRectMake(30, 330, 200, 20)];
	city.text =  @"Город";
	
	UIButton *citiButton = [[UIButton alloc] initWithFrame: CGRectMake( 0, 360, 200, 20 )];
	[citiButton setTitle: @"Изменить город" forState: UIControlStateNormal];
	[citiButton addTarget:self action:@selector(aMethod:) forControlEvents:UIControlEventTouchUpInside];
	[citiButton setTitleColor: [UIColor redColor] forState: UIControlStateNormal];
	
	UITextField *email = [[UITextField alloc]initWithFrame:CGRectMake(30, 420, 200, 20)];
	[email setText:@"Gastovigor@gmail.com"];
	
	UITextField *phone = [[UITextField alloc]initWithFrame:CGRectMake(30, 450, 200, 20)];
	[phone setText:@"80-63-411-81-60"];
	
	UIButton *saveButton = [[UIButton alloc] initWithFrame: CGRectMake(150, 500, 200, 20 )];
	[saveButton setTitle: @"Сохранить" forState: UIControlStateNormal];
	[saveButton addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
	[saveButton setTitleColor: [UIColor blueColor] forState: UIControlStateNormal];

	
	[self.view addSubview:firstName];
	[self.view addSubview:lastName];
	
	[self.view addSubview:country];
	[self.view addSubview:countryButton];
	[self.view addSubview:city];
	[self.view addSubview:citiButton];
	
	[self.view addSubview:email];
	[self.view addSubview:phone];
	
	[self.view addSubview:imageTestProfil];
	[self.view addSubview:photoButton];
	
	[self.view addSubview:saveButton];
}

-(IBAction)save:(id)sender{

}
-(IBAction)postButtonSelecte:(id)sender{
	mainF *viewController = [[mainF alloc] initWithNibName:nil bundle:nil];
	viewController.delegate = self;
	[self.navigationController setViewControllers:@[ viewController ] animated:NO];
	
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
					city.text =  @"Киев";
					NSLog(@"case0");
					break;
				case 1:
					city.text =  @"Москва";
					NSLog(@"case2");
					break;
				case 2:
					city.text = @"Минск";
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
					country.text = @"Украина";
					NSLog(@"case0");
					break;
				case 1:
					country.text = @"Россия";
					NSLog(@"case2");
					break;
				case 2:
					country.text = @"Белоруссия";
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
	
	[imageTestProfil setImage:image];
	
	[self dismissModalViewControllerAnimated:YES];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
	[self dismissModalViewControllerAnimated:YES];
	
}
- (void)dealloc {
	
}
@end

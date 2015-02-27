#import "MainVC.h"
#import "LeftMenuTVC.h"
#import "PAWConstants.h"
#import "PAWLoginViewController.h"
#import "PAWAppDelegate.h"
@interface MainVC ()

@end

@implementation MainVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logOut:) name:kHMLogOut object:nil];
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)logOut:(NSNotification*) notification{
	NSLog(@"LogOut!!!!");
	[PFUser logOut];
	
	//[self dismissViewControllerAnimated:YES completion:nil];
	[self.delegate settingsViewControllerDidLogout:self];
	
	//	[self dismissViewControllerAnimated:YES completion:nil];
//	[self.delegate MainVCViewControllerDidSignup:self];
	
	
	//[self.navigationController popToRootViewControllerAnimated:YES];
//		PAWLoginViewController *viewController = [[PAWLoginViewController alloc] initWithNibName:nil bundle:nil];
//		viewController.delegate = self;
//		[self.navigationController setViewControllers:@[ viewController ] animated:NO];
}
- (void)viewDidLoad
{

   /*******************************
    *     Initializing menus
    *******************************/
    self.leftMenu = [[LeftMenuTVC alloc] initWithNibName:@"LeftMenuTVC" bundle:nil];
//	self.navigationController.navigationBar.alpha = 0.5;
//	self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];

   /*******************************
    *     End Initializing menus
    *******************************/
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

#pragma mark - Overriding methods
- (void)configureLeftMenuButton:(UIButton *)button
{
    CGRect frame = button.frame;
    frame.origin = (CGPoint){0,0};
    frame.size = (CGSize){40,40};
    button.frame = frame;
    
    [button setImage:[UIImage imageNamed:@"menuButton"] forState:UIControlStateNormal];
}

//- (void)configureRightMenuButton:(UIButton *)button
//{
//    CGRect frame = button.frame;
//    frame.origin = (CGPoint){0,0};
//    frame.size = (CGSize){40,40};
//    button.frame = frame;
//    
//   // [button setImage:[UIImage imageNamed:@"icon-menu.png"] forState:UIControlStateNormal];
//}

//- (BOOL)deepnessForLeftMenu
//{
//    return YES;
//}
//
//- (CGFloat)maxDarknessWhileRightMenu
//{
//    return 0.5f;
//}
-(void)dealloc{

	[[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

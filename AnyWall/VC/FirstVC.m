
#import "PAWSettingsViewController.h"
#import "FirstVC.h"
#import "PAWConstants.h"
#import "PAWWallViewController.h"

#import "PAWWallPostCreateViewController.h"
#import "PAWWallPostsTableViewController.h"

@interface FirstVC ()<PAWWallPostsTableViewControllerDataSource,
PAWWallPostCreateViewControllerDataSource>

@property (nonatomic, strong) CLLocation *currentLocation;

@end


@implementation FirstVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

			self.title = @"Anywall";
			
//			_annotations = [[NSMutableArray alloc] initWithCapacity:10];
//			_allPosts = [[NSMutableArray alloc] initWithCapacity:10];
		
			[[NSNotificationCenter defaultCenter] addObserver:self
													 selector:@selector(distanceFilterDidChange:)
														 name:PAWFilterDistanceDidChangeNotification
													   object:nil];
			[[NSNotificationCenter defaultCenter] addObserver:self
													 selector:@selector(postWasCreated:)
														 name:PAWPostCreatedNotification
													   object:nil];
		
		
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings"
//																			 style:UIBarButtonItemStylePlain
//																			target:self
//																			action:@selector(settingsButtonSelected:)];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)settingsButtonSelected:(id)sender {
	[self firstVCWantsToPresentSettings:self];
}

- (void)firstVCWantsToPresentSettings:(UIViewController *)controller {
	[self presentSettingsViewController];
}

- (void)presentSettingsViewController {
	PAWSettingsViewController *settingsViewController = [[PAWSettingsViewController alloc] initWithNibName:nil bundle:nil];
	settingsViewController.delegate = self;
	settingsViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self.navigationController presentViewController:settingsViewController animated:YES completion:nil];
}
#pragma mark DataSource

- (CLLocation *)currentLocationForWallPostsTableViewController:(PAWWallPostsTableViewController *)controller {
	return self.currentLocation;
}


#pragma mark DataSource

- (CLLocation *)currentLocationForWallPostCrateViewController:(PAWWallPostCreateViewController *)controller {
	return self.currentLocation;
}

- (void)dealloc {
	//[_locationManager stopUpdatingLocation];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:PAWFilterDistanceDidChangeNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:PAWPostCreatedNotification object:nil];
}
@end

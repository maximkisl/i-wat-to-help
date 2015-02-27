#import "PAWAppDelegate.h"

#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import "VKSdk.h"
#import "PAWConstants.h"
#import "PAWConfigManager.h"
#import "PAWLoginViewController.h"
#import "PAWSettingsViewController.h"
#import "PAWWallViewController.h"
#import "mainF.h"

#import "mainFile.h"

#import "MainVC.h"

@interface PAWAppDelegate ()
<PAWLoginViewControllerDelegate,
PAWWallViewControllerDelegate,
PAWSettingsViewControllerDelegate, mainFileDelegate, mainFDelegate, MainVCDelegate>

@end

@implementation PAWAppDelegate

#pragma mark -
#pragma mark UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
 // Register for Push Notitications
	UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
													UIUserNotificationTypeBadge |
													UIUserNotificationTypeSound);
	UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
																			 categories:nil];
	[application registerUserNotificationSettings:settings];
	[application registerForRemoteNotifications];
	
//	[[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObject:@"ru_RU"] forKey:@"AppleLanguages"];

	
	
	// Override point for customization after application launch.
    // ****************************************************************************
    // Parse initialization
    [Parse setApplicationId:@"4oI0cGQvwuBbKpR6VbUIgK0gqYR6VgkiGj0weWfK" clientKey:@"iv1xOroJDMbhtN4aTazk46IkBIva8F2kS4jkH98v"];
    // ****************************************************************************
	[VKSdk initializeWithDelegate:self andAppId:@"4714824"];
	
	[PFFacebookUtils initializeFacebook];
	
	// Set the global tint on the navigation bar
	// Устанавливает глобальную оттенок на панели навигации
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:43.0f/255.0f green:181.0f/255.0f blue:46.0f/255.0f alpha:1.0f]];

    // Setup default NSUserDefaults
	// NSUserDefaults установки по умолчанию
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:PAWUserDefaultsFilterDistanceKey] == nil) {
        // If we have no accuracy in defaults, set it to 1000 feet.
		// Если у нас нет никакой точность по умолчанию , установите его в 1000 футов.
        [userDefaults setDouble:PAWFeetToMeters(PAWDefaultFilterDistance) forKey:PAWUserDefaultsFilterDistanceKey];
    }

    self.navigationController = [[UINavigationController alloc] initWithRootViewController:[[UIViewController alloc] init]];

    if ([PFUser currentUser]) {
        // Present wall straight-away
		// Современное стены прямо-таки

		
        [self presentWallViewControllerAnimated:NO];
    } else {
        // Go to the welcome screen and have them log in or create an account.
		// Перейти на экран приветствия и у них войти или зарегистрироваться .
        [self presentLoginViewController];
    }

    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];

	[[PAWConfigManager sharedManager] fetchConfigIfNeeded];

    return YES;
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
	[VKSdk processOpenURL:url fromApplication:sourceApplication];
	return YES;
}


- (void)applicationWillTerminate:(UIApplication *)application {
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark -
#pragma mark LoginViewController

-(void)mainFileViewControllerDidLogOut:(MainVC *)controller{
//	[controller dismissViewControllerAnimated:YES completion:nil];
//	[self presentLoginViewController];
	[self presentWallViewControllerAnimated:YES];

	NSLog(@"mainFileViewControllerDidLogOut");
}
- (void)settingsViewControllerDidLogout:(MainVC *)controller {
	[controller dismissViewControllerAnimated:YES completion:nil];
	[self presentLoginViewController];
}

- (void)presentLoginViewController {
    // Go to the welcome screen and have them log in or create an account.
	// Перейти на экран приветствия и у них войти или зарегистрироваться .
    PAWLoginViewController *viewController = [[PAWLoginViewController alloc] initWithNibName:nil bundle:nil];
    viewController.delegate = self;
    [self.navigationController setViewControllers:@[ viewController ] animated:NO];
	
}

#pragma mark Delegate

- (void)loginViewControllerDidLogin:(PAWLoginViewController *)controller {
    [self presentWallViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark WallViewController

- (void)presentWallViewControllerAnimated:(BOOL)animated {
//    MainVC *wallViewController = [[MainVC alloc] initWithNibName:nil bundle:nil];
 
	
	
	MainVC *wallViewController = [[MainVC alloc] initWithNibName:nil bundle:nil];
	wallViewController.delegate = self;
	[self.navigationController setViewControllers:@[ wallViewController ] animated:animated];
}

#pragma mark Delegate

- (void)wallViewControllerWantsToPresentSettings:(PAWWallViewController *)controller {
    [self presentSettingsViewController];
}

#pragma mark -
#pragma mark SettingsViewController

- (void)presentSettingsViewController {
    PAWSettingsViewController *settingsViewController = [[PAWSettingsViewController alloc] initWithNibName:nil bundle:nil];
    settingsViewController.delegate = self;
    settingsViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self.navigationController presentViewController:settingsViewController animated:YES completion:nil];
}

//#pragma mark Delegate
//
//- (void)settingsViewControllerDidLogout:(PAWSettingsViewController *)controller {
//    [controller dismissViewControllerAnimated:YES completion:nil];
//    [self presentLoginViewController];
//}




//- (void)mainFViewControllerDidLogout:(mainF *)controller {
//	[controller dismissViewControllerAnimated:YES completion:nil];
//	[self presentLoginViewController];
//}

//#pragma mark Delegate

//- (void)wallViewControllerWantsToPresentMainFile:(mainFile *)controller {
//	controller = [[mainFile alloc] initWithNibName:nil bundle:nil];
//}

//#pragma mark -
//#pragma mark mainFileViewController
//
//- (void)presentMainFileViewController {
//	mainF *settingsViewController = [[mainF alloc] initWithNibName:nil bundle:nil];
//	settingsViewController.delegate = self;
//	settingsViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//	[self.navigationController presentViewController:settingsViewController animated:YES completion:nil];
//}


#pragma mark Delegate

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
	// Store the deviceToken in the current installation and save it to Parse.
	PFInstallation *currentInstallation = [PFInstallation currentInstallation];
	[currentInstallation setDeviceTokenFromData:deviceToken];
	[currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
	[PFPush handlePush:userInfo];
}
@end

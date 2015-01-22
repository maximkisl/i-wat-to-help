

#import "PAWWallViewController.h"
#import "mainFile.h"
#import "PAWConstants.h"
#import "PAWPost.h"
#import "PAWWallPostCreateViewController.h"
#import "PAWWallPostsTableViewController.h"

//#import "FirstVC.h"

//#import "LeftMenuTVC.h"


@interface PAWWallViewController ()
<PAWWallPostsTableViewControllerDataSource,
PAWWallPostCreateViewControllerDataSource,mainFileDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *currentLocation;

@property (nonatomic, strong) MKCircle *circleOverlay;
@property (nonatomic, strong) NSMutableArray *annotations;
@property (nonatomic, assign) BOOL mapPinsPlaced;
@property (nonatomic, assign) BOOL mapPannedSinceLocationUpdate;

@property (nonatomic, strong) NSString *title2;
@property (nonatomic, strong) NSString *subtitle2;


@property (nonatomic, strong) PAWWallPostsTableViewController *wallPostsTableViewController;

@property (nonatomic, strong) NSMutableArray *allPosts;

@end

@implementation PAWWallViewController

#pragma mark -
#pragma mark Init

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
        self.title = @"I wont to help";

        _annotations = [[NSMutableArray alloc] initWithCapacity:10];
        _allPosts = [[NSMutableArray alloc] initWithCapacity:10];

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

#pragma mark -
#pragma mark Dealloc

- (void)dealloc {
    [_locationManager stopUpdatingLocation];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:PAWFilterDistanceDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:PAWPostCreatedNotification object:nil];
}

#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad {
	[super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	[self loadWallPostsTableViewController];

	

    // Set our nav bar items.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Post"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(postButtonSelected:)];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings"
//                                                                             style:UIBarButtonItemStylePlain
//                                                                            target:self
//                                                                            action:@selector(settingsButtonSelected:)];

    self.mapView.region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(00.000000f, -000.000000f),
                                                 MKCoordinateSpanMake(0.008516f, 0.021801f));
    self.mapPannedSinceLocationUpdate = NO;
    [self startStandardUpdates];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:NO animated:animated];

    [self.locationManager startUpdatingLocation];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    [self.locationManager stopUpdatingLocation];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    const CGRect bounds = self.view.bounds;

    CGRect tableViewFrame = CGRectZero;
    tableViewFrame.origin.x = 6.0f;
    tableViewFrame.origin.y = CGRectGetMaxY(self.mapView.frame) + 6.0f;
    tableViewFrame.size.width = CGRectGetMaxX(bounds) - CGRectGetMinX(tableViewFrame) * 2.0f;
    tableViewFrame.size.height = CGRectGetMaxY(bounds) - CGRectGetMaxY(tableViewFrame);
    self.wallPostsTableViewController.view.frame = tableViewFrame;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

#pragma mark -
#pragma mark WallPostsTableViewController

- (void)loadWallPostsTableViewController {
    // Add the wall posts tableview as a subview with view containment (new in iOS 5.0):
    self.wallPostsTableViewController = [[PAWWallPostsTableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.wallPostsTableViewController.dataSource = self;
    [self.view addSubview:self.wallPostsTableViewController.view];
    [self addChildViewController:self.wallPostsTableViewController];
    [self.wallPostsTableViewController didMoveToParentViewController:self];
}

#pragma mark DataSource

- (CLLocation *)currentLocationForWallPostsTableViewController:(PAWWallPostsTableViewController *)controller {
    return self.currentLocation;
}


#pragma mark -
#pragma mark WallPostCreatViewController

- (void)presentWallPostCreateViewController {
    PAWWallPostCreateViewController *viewController = [[PAWWallPostCreateViewController alloc] initWithNibName:nil bundle:nil];
    viewController.dataSource = self;
    [self.navigationController presentViewController:viewController animated:YES completion:nil];
}

#pragma mark DataSource

- (CLLocation *)currentLocationForWallPostCrateViewController:(PAWWallPostCreateViewController *)controller {
    return self.currentLocation;
}

#pragma mark -
#pragma mark NSNotificationCenter notification handlers

- (void)distanceFilterDidChange:(NSNotification *)note {
    CLLocationAccuracy filterDistance = [[note userInfo][kPAWFilterDistanceKey] doubleValue];

    if (self.circleOverlay != nil) {
        [self.mapView removeOverlay:self.circleOverlay];
        self.circleOverlay = nil;
    }
    self.circleOverlay = [MKCircle circleWithCenterCoordinate:self.currentLocation.coordinate radius:filterDistance];
    [self.mapView addOverlay:self.circleOverlay];

    // Update our pins for the new filter distance:
    [self updatePostsForLocation:self.currentLocation withNearbyDistance:filterDistance];

    // If they panned the map since our last location update, don't recenter it.
    if (!self.mapPannedSinceLocationUpdate) {
        // Set the map's region centered on their location at 2x filterDistance
        MKCoordinateRegion newRegion = MKCoordinateRegionMakeWithDistance(self.currentLocation.coordinate, filterDistance * 2.0f, filterDistance * 2.0f);

        [self.mapView setRegion:newRegion animated:YES];
        self.mapPannedSinceLocationUpdate = NO;
    } else {
        // Just zoom to the new search radius (or maybe don't even do that?)
        MKCoordinateRegion currentRegion = self.mapView.region;
        MKCoordinateRegion newRegion = MKCoordinateRegionMakeWithDistance(currentRegion.center, filterDistance * 2.0f, filterDistance * 2.0f);

        BOOL oldMapPannedValue = self.mapPannedSinceLocationUpdate;
        [self.mapView setRegion:newRegion animated:YES];
        self.mapPannedSinceLocationUpdate = oldMapPannedValue;
    }
}

- (void)setCurrentLocation:(CLLocation *)currentLocation {
    if (self.currentLocation == currentLocation) {
        return;
    }

    _currentLocation = currentLocation;

    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:PAWCurrentLocationDidChangeNotification
                                                            object:nil
                                                          userInfo:@{ kPAWLocationKey : currentLocation } ];
    });
    
    CLLocationAccuracy filterDistance = [[NSUserDefaults standardUserDefaults] doubleForKey:PAWUserDefaultsFilterDistanceKey];

    // If they panned the map since our last location update, don't recenter it.
    if (!self.mapPannedSinceLocationUpdate) {
        // Set the map's region centered on their new location at 2x filterDistance
        MKCoordinateRegion newRegion = MKCoordinateRegionMakeWithDistance(self.currentLocation.coordinate, filterDistance * 2.0f, filterDistance * 2.0f);

        BOOL oldMapPannedValue = self.mapPannedSinceLocationUpdate;
        [self.mapView setRegion:newRegion animated:YES];
        self.mapPannedSinceLocationUpdate = oldMapPannedValue;
    } // else do nothing.

    if (self.circleOverlay != nil) {
        [self.mapView removeOverlay:self.circleOverlay];
        self.circleOverlay = nil;
    }
    self.circleOverlay = [MKCircle circleWithCenterCoordinate:self.currentLocation.coordinate radius:filterDistance];
    [self.mapView addOverlay:self.circleOverlay];

    // Update the map with new pins:
    [self queryForAllPostsNearLocation:self.currentLocation withNearbyDistance:filterDistance];
    // And update the existing pins to reflect any changes in filter distance:
    [self updatePostsForLocation:self.currentLocation withNearbyDistance:filterDistance];
}

- (void)postWasCreated:(NSNotification *)note {
    CLLocationAccuracy filterDistance = [[NSUserDefaults standardUserDefaults] doubleForKey:PAWUserDefaultsFilterDistanceKey];
    [self queryForAllPostsNearLocation:self.currentLocation withNearbyDistance:filterDistance];
}

#pragma mark -
#pragma mark UINavigationBar-based actions

- (IBAction)settingsButtonSelected:(id)sender {
    [self.delegate wallViewControllerWantsToPresentSettings:self];
}

- (IBAction)postButtonSelected:(id)sender {
    [self presentWallPostCreateViewController];
}

#pragma mark -
#pragma mark CLLocationManagerDelegate methods and helpers

- (CLLocationManager *)locationManager {
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];

        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;

        // Set a movement threshold for new events.
        _locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters;
    }
    return _locationManager;
}

- (void)startStandardUpdates {
    [self.locationManager startUpdatingLocation];

    CLLocation *currentLocation = self.locationManager.location;
    if (currentLocation) {
        self.currentLocation = currentLocation;
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    switch (status) {
        case kCLAuthorizationStatusAuthorized:
        {
            NSLog(@"kCLAuthorizationStatusAuthorized");
            // Re-enable the post button if it was disabled before.
			// Снова включите кнопку пост, если он был отключен ранее .
            self.navigationItem.rightBarButtonItem.enabled = YES;
            [self.locationManager startUpdatingLocation];
        }
            break;
        case kCLAuthorizationStatusDenied:
            NSLog(@"kCLAuthorizationStatusDenied");
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Anywall can’t access your current location.\n\nTo view nearby posts or create a post at your current location, turn on access for Anywall to your location in the Settings app under Location Services." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alertView show];
            // Disable the post button.
			// Отключить кнопку после .
            self.navigationItem.rightBarButtonItem.enabled = NO;
        }
            break;
        case kCLAuthorizationStatusNotDetermined:
        {
            NSLog(@"kCLAuthorizationStatusNotDetermined");
        }
            break;
        case kCLAuthorizationStatusRestricted:
        {
            NSLog(@"kCLAuthorizationStatusRestricted");
        }
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    NSLog(@"%s", __PRETTY_FUNCTION__);

    self.currentLocation = newLocation;
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSLog(@"Error: %@", [error description]);

    if (error.code == kCLErrorDenied) {
        [self.locationManager stopUpdatingLocation];
    } else if (error.code == kCLErrorLocationUnknown) {
        // todo: retry?
        // set a timer for five seconds to cycle location, and if it fails again, bail and tell the user.
		// TODO: повторить?
		// Установить таймер на пять секунд до места цикла , и , если оно не раз , залог и сообщить пользователю .
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error retrieving location"
                                                        message:[error localizedDescription]
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil];
        [alert show];
    }
}

#pragma mark -
#pragma mark MKMapViewDelegate

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay {
	if ([overlay isKindOfClass:[MKCircle class]]) {
		MKCircleRenderer *circleRenderer = [[MKCircleRenderer alloc] initWithCircle:self.circleOverlay];
		[circleRenderer setFillColor:[[UIColor darkGrayColor] colorWithAlphaComponent:0.2f]];
		[circleRenderer setStrokeColor:[[UIColor darkGrayColor] colorWithAlphaComponent:0.7f]];
		[circleRenderer setLineWidth:1.0f];
		return circleRenderer;
	}
	return nil;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapVIew viewForAnnotation:(id<MKAnnotation>)annotation {
    // Let the system handle user location annotations.
	// Пусть система ручки аннотации местоположение пользователя .
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }

    static NSString *pinIdentifier = @"CustomPinAnnotation";

    // Handle any custom annotations.
	// Обработка любые пользовательские аннотации .
    if ([annotation isKindOfClass:[PAWPost class]]) {
        // Try to dequeue an existing pin view first.
		// Попытка из очереди существующего вида контактный первым.
        MKPinAnnotationView *pinView = (MKPinAnnotationView*)[mapVIew dequeueReusableAnnotationViewWithIdentifier:pinIdentifier];

		
		if (!pinView) {
			
			// If an existing pin view was not available, create one.
			// Еслисуществующие Вид Контакт не был доступен , создайте ее.
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                      reuseIdentifier:pinIdentifier];


		} else {
            pinView.annotation = annotation;

        }
		//        pinView.pinColor = [(PAWPost *)annotation pinColor];
		//  pinView.animatesDrop = [((PAWPost *)annotation) animatesDrop];
        pinView.canShowCallout = NO;
		//pinView.draggable = YES;
		pinView.image = [UIImage imageNamed:@"pin.png"];

		
        return pinView;
    }

	return nil;
	
}
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
		id<MKAnnotation> annotation = [view annotation];
	if ([annotation isKindOfClass:[PAWPost class]]) {
		PAWPost *post = [view annotation];
		self.title2 = post.title;
		self.subtitle2 = post.subtitle;
		[self.wallPostsTableViewController highlightCellForPost:post];
	}  else  if ([annotation isKindOfClass:[MKUserLocation class]]) {
		// Center the map on the user's current location:
		// ЦентрКарта текущего местоположения пользователя
		CLLocationAccuracy filterDistance = [[NSUserDefaults standardUserDefaults] doubleForKey:PAWUserDefaultsFilterDistanceKey];
		MKCoordinateRegion newRegion = MKCoordinateRegionMakeWithDistance(self.currentLocation.coordinate,
																		  filterDistance * 2.0f,
																		  filterDistance * 2.0f);
		
		[self.mapView setRegion:newRegion animated:YES];
		self.mapPannedSinceLocationUpdate = NO;
	}
	
	// Here we need to pass a full frame
	CustomIOS7AlertView *alertView = [[CustomIOS7AlertView alloc] init];
	// Add some custom content to the alert view
	//[alertView setContainerView:[self createDemoView:alertView]];
	// Modify the parameters
	[alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"Cansel", @"0", @"Info",@"0", nil]];
	[alertView setDelegate:self];
	alertView.hidden = nil;
	// You may use a Block, rather than a delegate.
	[alertView setOnButtonTouchUpInside:^(CustomIOS7AlertView *alertView, int buttonIndex) {
		NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, (int)[alertView tag]);
		
	}];
	UIImageView *imageBackround = [[UIImageView alloc] initWithFrame:CGRectMake(50, 165, 220, 150)];
	[imageBackround setImage:[UIImage imageNamed:@"postMenuBackground.png"]];
	
	UILabel *label = [[UILabel alloc] init];
	label.frame = CGRectMake(100, 165, 150, 50);
	//label.text = @"Донести тяжелые багажные сумки";
	
	
	label.text = self.title2;
	label.numberOfLines = 2;
	
	UILabel *label4 = [[UILabel alloc] init];
	label4.frame = CGRectMake(100, 195, 150, 70);
	[label4 setFont:[UIFont systemFontOfSize:14]];
//	label4.text = @"ул.Бэсхерст, 44б";
	label4.text = self.subtitle2;

	UILabel *label5 = [[UILabel alloc] init];
	label5.frame = CGRectMake(100, 225, 150, 70);
	[label5 setFont:[UIFont systemFontOfSize:14]];
	label5.text = @"Сейчас";
	
	
	
	UIImageView *imageTestProfil = [[UIImageView alloc] initWithFrame:CGRectMake(60, 170, 30, 30)];
	[imageTestProfil setImage:[UIImage imageNamed:@"testImage"]];
	imageTestProfil.backgroundColor = [UIColor darkGrayColor];
	
	CALayer * ourLayer = [imageTestProfil layer]; // Будем округлять UIImageView
	ourLayer.cornerRadius = 15.0f;           // Polovina korotkoi storoni, Задаем радиус для округления.
	ourLayer.masksToBounds = YES;           // Чтобы за овальной границей в углах ничего не рисовалось
	ourLayer.borderWidth = 0.0f;

	// And launch the dialog
	[alertView addSubview:imageBackround];
	[alertView addSubview:label];
	[alertView addSubview:label4];
	[alertView addSubview:label5];

	[alertView addSubview:imageTestProfil];

	[alertView show];
	//_______________________________________
	
	

}

- (void)customIOS7dialogButtonTouchUpInside: (CustomIOS7AlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
	if (buttonIndex == 0) {
		[alertView close];
	}
	if(buttonIndex == 1){
		[alertView close];

		CustomIOS7AlertView *alertView2 = [[CustomIOS7AlertView alloc] init];
		// Add some custom content to the alert view
		//[alertView2 setContainerView:[self createMoreInfo]];
		// Modify the parameters
		[alertView2 setButtonTitles:[NSMutableArray arrayWithObjects:@"0", @"Cansel2", @"0",@"Help",nil]];
		[alertView2 setDelegate:self];

		// You may use a Block, rather than a delegate.
		[alertView2 setOnButtonTouchUpInside:^(CustomIOS7AlertView *alertView, int buttonIndex) {
			NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, (int)[alertView tag]);
			
		}];
				
		UIImageView *imageBackround2 = [[UIImageView alloc] initWithFrame:CGRectMake(50, 120, 220, 300)];
		[imageBackround2 setImage:[UIImage imageNamed:@"moreInfoPostMenu.png"]];

		UILabel *label4 = [[UILabel alloc] init];
		label4.frame = CGRectMake(100, 210, 150, 70);
		[label4 setFont:[UIFont systemFontOfSize:14]];
		label4.text = @"ул.Бэсхерст, 44б";
		
		UILabel *label5 = [[UILabel alloc] init];
		label5.frame = CGRectMake(100, 250, 150, 70);
		[label5 setFont:[UIFont systemFontOfSize:14]];
		label5.text = @"Сейчас";
		
		UILabel *label6 = [[UILabel alloc] init];
		label6.frame = CGRectMake(100, 290, 150, 70);
		[label6 setFont:[UIFont systemFontOfSize:14]];
		label6.text = @"Рейтинг: +5";
		UILabel *label7 = [[UILabel alloc] init];
		label7.frame = CGRectMake(100, 330, 150, 70);
		[label7 setFont:[UIFont systemFontOfSize:14]];
		label7.text = @"8(987) 496-39-08";
	
		UILabel *label2 = [[UILabel alloc] init];
		label2.frame = CGRectMake(100, 170, 150, 70);
		[label2 setFont:[UIFont systemFontOfSize:14]];
		label2.text = @"Gastov Igor and gastov igor and";
		
		UILabel *label3 = [[UILabel alloc] init];
		label3.numberOfLines = 3;
		label3.frame = CGRectMake(100, 105, 150, 100);
		label3.text = @"Донести тяжелые багажные сумки (расширенное описание)";


		UIImageView *imageTestProfil2 = [[UIImageView alloc] initWithFrame:CGRectMake(60, 193, 30, 30)];
		[imageTestProfil2 setImage:[UIImage imageNamed:@"testImage"]];
		imageTestProfil2.backgroundColor = [UIColor darkGrayColor];
		
		CALayer * ourLayer = [imageTestProfil2 layer]; // Будем округлять UIImageView
		ourLayer.cornerRadius = 15.0f;           // Polovina korotkoi storoni, Задаем радиус для округления.
		ourLayer.masksToBounds = YES;           // Чтобы за овальной границей в углах ничего не рисовалось
		ourLayer.borderWidth = 0.0f;
		
		// And launch the dialog
		[alertView2 addSubview:imageBackround2];
		[alertView2 addSubview:label2];
		[alertView2 addSubview:label3];
		[alertView2 addSubview:label4];
		[alertView2 addSubview:label5];
		[alertView2 addSubview:label6];
		[alertView2 addSubview:label7];

		[alertView2 addSubview:imageTestProfil2];
		[alertView2 show];
		//_______________________________________
	}
	if (buttonIndex == 3) {
		NSLog(@"buttonIndex3");
	}
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    id<MKAnnotation> annotation = [view annotation];
    if ([annotation isKindOfClass:[PAWPost class]]) {
        PAWPost *post = [view annotation];
        [self.wallPostsTableViewController unhighlightCellForPost:post];
    }
}
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    self.mapPannedSinceLocationUpdate = YES;
}

#pragma mark -
#pragma mark Fetch map pins

- (void)queryForAllPostsNearLocation:(CLLocation *)currentLocation withNearbyDistance:(CLLocationAccuracy)nearbyDistance {
    PFQuery *query = [PFQuery queryWithClassName:PAWParsePostsClassName];

    if (currentLocation == nil) {
        NSLog(@"%s got a nil location!", __PRETTY_FUNCTION__);
    }

    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
	// Если объекты не загружаются в память , мы с нетерпением кэша первого заполнить таблицу
	// И впоследствии сделать запрос к сети.
    if ([self.allPosts count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }

    // Query for posts sort of kind of near our current location.
	// Запрос на должности вроде вид около нашего текущего местоположения.
    PFGeoPoint *point = [PFGeoPoint geoPointWithLatitude:currentLocation.coordinate.latitude longitude:currentLocation.coordinate.longitude];
    [query whereKey:PAWParsePostLocationKey nearGeoPoint:point withinKilometers:PAWWallPostMaximumSearchDistance];
    [query includeKey:PAWParsePostUserKey];
    query.limit = PAWWallPostsSearchDefaultLimit;

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"error in geo query!"); // todo why is this ever happening? // TODO почему это когда-нибудь случилось?
        } else {
            // We need to make new post objects from objects,
            // and update allPosts and the map to reflect this new array.
            // But we don't want to remove all annotations from the mapview blindly,
            // so let's do some work to figure out what's new and what needs removing.
			// Мы должны сделать новый пост объекты от объектов ,
			// И обновления allPosts икарта , чтобы отразить это новый массив .
			// Но мы не хотим , чтобы удалить все аннотации от MapView вслепую,
			// Так что давайте делать какую-то работу , чтобы выяснить, что нового и что должна быть удалена .

            // 1. Find genuinely new posts:
			// 1. Найти искренне Новые сообщения
            NSMutableArray *newPosts = [[NSMutableArray alloc] initWithCapacity:PAWWallPostsSearchDefaultLimit];
            // (Cache the objects we make for the search in step 2:)
			// (Кэш объектов , которые мы делаем для поиска в шаге 2 :)
            NSMutableArray *allNewPosts = [[NSMutableArray alloc] initWithCapacity:[objects count]];
            for (PFObject *object in objects) {
                PAWPost *newPost = [[PAWPost alloc] initWithPFObject:object];
                [allNewPosts addObject:newPost];
                if (![_allPosts containsObject:newPost]) {
                    [newPosts addObject:newPost];
                }
            }
            // newPosts now contains our new objects.
			// NewPosts теперь содержит наши новые объекты.

            // 2. Find posts in allPosts that didn't make the cut.
			// 2. Поиск сообщений в allPosts , что не делают разрез .
            NSMutableArray *postsToRemove = [[NSMutableArray alloc] initWithCapacity:PAWWallPostsSearchDefaultLimit];
            for (PAWPost *currentPost in _allPosts) {
                if (![allNewPosts containsObject:currentPost]) {
                    [postsToRemove addObject:currentPost];
                }
            }
            // postsToRemove has objects that didn't come in with our new results.
			// PostsToRemove есть объекты , которые не приходят в наши новые результаты.

            // 3. Configure our new posts; these are about to go onto the map.
			// 3. настроить наше новых сообщений ; это собирается идти на карте.
            for (PAWPost *newPost in newPosts) {
                CLLocation *objectLocation = [[CLLocation alloc] initWithLatitude:newPost.coordinate.latitude
                                                                        longitude:newPost.coordinate.longitude];
                // if this post is outside the filter distance, don't show the regular callout.
				// Если этот пост вне дистанции фильтра , не показывают регулярные выноски .
                CLLocationDistance distanceFromCurrent = [currentLocation distanceFromLocation:objectLocation];
                [newPost setTitleAndSubtitleOutsideDistance:( distanceFromCurrent > nearbyDistance ? YES : NO )];
                // Animate all pins after the initial load:
				// Анимация все контакты после первоначальной загрузки :
                newPost.animatesDrop = self.mapPinsPlaced;

				
            }

            // At this point, newAllPosts contains a new list of post objects.
            // We should add everything in newPosts to the map, remove everything in postsToRemove,
            // and add newPosts to allPosts.
			// В этой точке , newAllPosts содержит новый список почтовых предметов .
			// Мы должны добавить все, что в newPosts карте, удаления все в postsToRemove ,
			// И добавить newPosts в allPosts .
            [self.mapView removeAnnotations:postsToRemove];
           [self.mapView addAnnotations:newPosts];

            [_allPosts addObjectsFromArray:newPosts];
            [_allPosts removeObjectsInArray:postsToRemove];

            self.mapPinsPlaced = YES;
        }
    }];
}

// When we update the search filter distance, we need to update our pins' titles to match.
// Когда мы обновляем расстояние фильтр поиска, нам необходимо обновить названия наших Пен , чтобы соответствовать.
- (void)updatePostsForLocation:(CLLocation *)currentLocation withNearbyDistance:(CLLocationAccuracy) nearbyDistance {
    for (PAWPost *post in _allPosts) {
        CLLocation *objectLocation = [[CLLocation alloc] initWithLatitude:post.coordinate.latitude
                                                                longitude:post.coordinate.longitude];

        // if this post is outside the filter distance, don't show the regular callout.
		// Если этот пост вне дистанции фильтра , не показывают регулярные выноски .
        CLLocationDistance distanceFromCurrent = [currentLocation distanceFromLocation:objectLocation];
        if (distanceFromCurrent > nearbyDistance) { // Outside search radius   // Внешний радиус поиск
            [post setTitleAndSubtitleOutsideDistance:YES];
            [(MKPinAnnotationView *)[self.mapView viewForAnnotation:post] setPinColor:post.pinColor];
        } else {
            [post setTitleAndSubtitleOutsideDistance:NO]; // Inside search radius //Внутренний радиус поиска
            [(MKPinAnnotationView *)[self.mapView viewForAnnotation:post] setPinColor:post.pinColor];
        }
    }
}

@end

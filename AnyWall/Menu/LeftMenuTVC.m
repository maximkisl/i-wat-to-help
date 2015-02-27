#import "Settings.h"
#import "PAWConstants.h"
#import "LeftMenuTVC.h"
#import "mainFile.h"
#import "SecondVC.h"
#import "PAWWallViewController.h"
#import "mainF.h"
#import "SPHViewController.h"
#import "PAWMessages.h"
@interface LeftMenuTVC ()

@end

@implementation LeftMenuTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
//	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logOut:) name:kHMLogOut object:nil];
    // Do any additional setup after loading the view from its nib.
//	self.navigationController.navigationBar.alpha = 0.5;
//	self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];

    // Initilizing data souce
    self.tableData = [@[ @"Карта",@"Мой профиль", @"Сообщения", @"Настройки", @"Текущая задача", @"История помощи"] mutableCopy];
//	self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"postMenuBackground.png"]];
	
	
	self.tableView.separatorColor = [UIColor clearColor];
	self.tableView.rowHeight = 40;
	self.tableView.sectionIndexColor = [UIColor blackColor];
}
-(void)logOut:(NSNotification*) notification{
	[self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - TableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	
	UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 55)];
	
	[sectionView setBackgroundColor:[UIColor whiteColor]];
	
	PFUser *user = [PFUser currentUser];
	
	UILabel * textLabel = [[UILabel alloc]init];
	
	textLabel.text = [user objectForKey:@"firstname"];
	textLabel.font = [UIFont fontWithName:HMDamascusLight size:13];
	[textLabel setFrame:CGRectMake(60, 5, 100, 20)];
	

	UILabel * rankLabel = [[UILabel alloc]init];
	
	rankLabel.text = [user objectForKey:@"rank"];
	rankLabel.font = [UIFont fontWithName:HMDamascusLight size:13];
	[rankLabel setFrame:CGRectMake(60, 20, 100, 20)];
	
	UIImageView *imageView = [[UIImageView alloc] init];

	PFFile *imageData = [user objectForKey:@"avatar"];
	
	NSData *data = [imageData getData];
	imageView.image = [UIImage imageWithData:data];
	
	[imageView setFrame:CGRectMake(15, 7, 38, 38)];
	CALayer * ourLayer = [imageView layer];			// Будем округлять UIImageView
	ourLayer.cornerRadius =  19.0f;           // Polovina korotkoi storoni, Задаем радиус для округления.
	ourLayer.masksToBounds = YES;           // Чтобы за овальной границей в углах ничего не рисовалось
	ourLayer.borderWidth = 0.5f;
	
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[button addTarget:self
			   action:@selector(showReadmeView:)
	 forControlEvents:UIControlEventTouchUpInside];
	[button setTitle:@"ред." forState:UIControlStateNormal];
	button.frame = CGRectMake(200, 5, 40, 20);
	
	
	[sectionView addSubview:button];
	[sectionView addSubview:rankLabel];
	[sectionView addSubview:imageView];
	[sectionView addSubview:textLabel];
	
	[tableView addSubview:sectionView];
	return  @" ";
}


-(void) showReadmeView:(UIButton*)sender
{
	mainF *viewController = [[mainF alloc] initWithNibName:nil bundle:nil];
	//viewController.delegate = self;
	[self.navigationController pushViewController:viewController animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return [self.tableData count]+1 ;
	return  [self.tableData count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
	
			cell.textLabel.text = self.tableData[indexPath.row];
			
	

//    cell.textLabel.text = self.tableData[indexPath.row];
	cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cellbackgraund_80"]];

    return cell;
}
#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UINavigationController *nvc;
//    PAWWallViewController *rootVC;
    switch (indexPath.row) {
		
		case 0:
        {
			UINavigationController *nvc;
			PAWWallViewController *rootVC;
			rootVC = [[PAWWallViewController alloc] initWithNibName:@"PAWWallViewController" bundle:nil];
			
			nvc = [[UINavigationController alloc] initWithRootViewController:rootVC];
			
			[self openContentNavigationController:nvc];

        }
            break;
		case 1:
		{
			UINavigationController *nvc;
			mainFile *rootVC;
			
			rootVC = [[mainFile alloc] init] ;
			
			nvc = [[UINavigationController alloc] initWithRootViewController:rootVC];
			
			[self openContentNavigationController:nvc];
		}
			break;
		case 2:
		{
			UINavigationController *nvc;
			PAWMessages *rootVC;
			
			rootVC = [[PAWMessages alloc] init] ;
			
			nvc = [[UINavigationController alloc] initWithRootViewController:rootVC];
			
			[self openContentNavigationController:nvc];
		}
			break;
		case 3:
		{
			UINavigationController *nvc;
			Settings *rootVC;
			
			rootVC = [[Settings alloc] initWithNibName:@"Settings" bundle:nil];
			
			nvc = [[UINavigationController alloc] initWithRootViewController:rootVC];
			
			[self openContentNavigationController:nvc];
		}
			break;
        case 4:
        {
			UINavigationController *nvc;
			SecondVC *rootVC;
            rootVC = [[SecondVC alloc] initWithNibName:@"SecondVC" bundle:nil];
			
			nvc = [[UINavigationController alloc] initWithRootViewController:rootVC];
			
			[self openContentNavigationController:nvc];
        }
            break;
		
			
        default:
            break;
    }
//    nvc = [[UINavigationController alloc] initWithRootViewController:rootVC];
//    
//    [self openContentNavigationController:nvc];
}
-(void)dealloc{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

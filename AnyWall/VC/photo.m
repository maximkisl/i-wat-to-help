#import "photo.h"
#include <QuartzCore/QuartzCore.h>

#import "PAWSettingsViewController.h"
#import "PAWConstants.h"
#import "PAWWallViewController.h"
#include <QuartzCore/QuartzCore.h>
#import "PAWWallPostCreateViewController.h"
#import "PAWWallPostsTableViewController.h"


@interface photo ()

@end


@implementation photo

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

			self.title = @"Anywall";
	
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	UIImageView *imageTestProfil = [[UIImageView alloc] initWithFrame:CGRectMake(60, 170, 150, 150)];
	[imageTestProfil setImage:[UIImage imageNamed:@"testImage"]];
	imageTestProfil.backgroundColor = [UIColor darkGrayColor];
	
	CALayer * ourLayer = [imageTestProfil layer]; // Будем округлять UIImageView
	ourLayer.cornerRadius = 75.0f;           // Polovina korotkoi storoni, Задаем радиус для округления.
	ourLayer.masksToBounds = YES;           // Чтобы за овальной границей в углах ничего не рисовалось
	ourLayer.borderWidth = 0.0f;            // Границу рисовать не будем. Если нужна - указываем толщину
	
	[self.view addSubview:imageTestProfil];

	
}

- (void)dealloc {
	
}
@end

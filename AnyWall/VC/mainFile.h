#import <UIKit/UIKit.h>
#import "PAWWallViewController.h"
#import <CoreLocation/CoreLocation.h>

@class mainFile;


@protocol mainFileDelegate <NSObject>


//- (void)mainFileViewControllerDidLogOut:(mainFile*) controller;

@end
//@protocol mainFileDelegate <NSObject>
//
////- (CLLocation *)currentLocationFormainFileViewController:(mainFile *)controller;
//
//@end


@interface mainFile : UIViewController{
//
//	UIImagePickerController *picker2;
//	UIImageView *imageTestProfil2;
//	UIImage *_avatar;
	UILabel *rank;
}

@property (nonatomic, weak) id<mainFileDelegate> delegate;
@property (nonatomic, strong) CLLocationManager *locationManager;

- (IBAction)save:(id)sender;
-(NSString*)stringByAppendingString:first and:last;

@property (weak, nonatomic) IBOutlet UIImageView *imageTestProfil2;
@property (weak, nonatomic) IBOutlet UILabel *carma;
@property (weak, nonatomic) IBOutlet UILabel *rank;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *lastname;
@property (weak, nonatomic) IBOutlet UILabel *country;
@property (weak, nonatomic) IBOutlet UILabel *city;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *login;


@property (weak, nonatomic) IBOutlet UILabel *carmalabel;



@end

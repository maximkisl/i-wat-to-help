#import <UIKit/UIKit.h>
#import "PAWWallViewController.h"
#import <CoreLocation/CoreLocation.h>

@class mainFile;

@protocol mainFileDelegate <NSObject>

- (CLLocation *)currentLocationFormainFileViewController:(mainFile *)controller;

@end


@interface mainFile : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate>{

	UIImagePickerController *picker2;
	UIImageView *imageTestProfil;
}

@property (nonatomic, weak) id<mainFileDelegate> delegate;
@property (nonatomic, strong) CLLocationManager *locationManager;




@end

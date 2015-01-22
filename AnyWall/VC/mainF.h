

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>
#import "AMSlideMenuMainViewController.h"

@class mainF;

@protocol mainFDelegate <NSObject>

//- (void)wallViewControllerWantsToPresentSettings:(SecondVC *)controller;

@end

@class PAWPost;

@interface mainF : UIViewController <UIImagePickerControllerDelegate, MKMapViewDelegate, CLLocationManagerDelegate>{

UIImagePickerController *picker2;
UIImageView *imageTestProfil;
}
@property (nonatomic, weak) id<mainFDelegate> delegate;

@end




#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>
#import "AMSlideMenuMainViewController.h"

@class mainF;
@protocol mainFDelegate <NSObject>
@end

@interface mainF : UIViewController <UIImagePickerControllerDelegate, MKMapViewDelegate, CLLocationManagerDelegate>{

UIImagePickerController *picker2;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrolView;

@property (weak, nonatomic) IBOutlet UIImageView *imageTestProfil;

@property (weak, nonatomic) IBOutlet UILabel *country;
@property (weak, nonatomic) IBOutlet UILabel *city;

@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *phone;

@property (weak, nonatomic) IBOutlet UIButton *photoButton;
@property (weak, nonatomic) IBOutlet UIButton *countryButton;
@property (weak, nonatomic) IBOutlet UIButton *citiButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;


@property (nonatomic, weak) id<mainFDelegate> delegate;
//@property (nonatomic, weak) UIImage* avatar;
//@property(nonatomic, weak) UIImage * AVATAR;
@end


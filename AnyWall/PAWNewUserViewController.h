

#import <UIKit/UIKit.h>

@class PAWNewUserViewController;

@protocol PAWNewUserViewControllerDelegate <NSObject>

- (void)newUserViewControllerDidSignup:(PAWNewUserViewController *)controller;

@end

@interface PAWNewUserViewController : UIViewController <UIImagePickerControllerDelegate>
{
UIImagePickerController *picker2;
}
@property (nonatomic, weak) id<PAWNewUserViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UISwitch *agreementswitch;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
- (IBAction)avatarButton:(id)sender;
- (IBAction)agreementSwitch:(id)sender;
@property (nonatomic, strong) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *lastnameField;
@property (nonatomic, strong) IBOutlet UITextField *passwordField;
@property (nonatomic, strong) IBOutlet UITextField *passwordAgainField;
//@property (nonatomic, strong) IBOutlet UITextField *phoneFiled;
//@property (nonatomic, strong) IBOutlet UITextField *emailFiled;
@property (weak, nonatomic) IBOutlet UITextField *phoneFiled;
@property (weak, nonatomic) IBOutlet UITextField *emailFiled;
@property (weak, nonatomic) IBOutlet UITextField *countryField;
@property (weak, nonatomic) IBOutlet UITextField *cityField;

@end

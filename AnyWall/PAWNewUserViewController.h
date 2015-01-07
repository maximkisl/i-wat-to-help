

#import <UIKit/UIKit.h>

@class PAWNewUserViewController;

@protocol PAWNewUserViewControllerDelegate <NSObject>

- (void)newUserViewControllerDidSignup:(PAWNewUserViewController *)controller;

@end

@interface PAWNewUserViewController : UIViewController

@property (nonatomic, weak) id<PAWNewUserViewControllerDelegate> delegate;

@property (nonatomic, strong) IBOutlet UITextField *usernameField;
@property (nonatomic, strong) IBOutlet UITextField *passwordField;
@property (nonatomic, strong) IBOutlet UITextField *passwordAgainField;

@end

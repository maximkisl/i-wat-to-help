

#import "PAWLoginViewController.h"

#import <FacebookSDK/FacebookSDK.h>
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import "VKSdk.h"
#import "VKAuthorizeController.h"

#import "PAWActivityView.h"
#import "PAWNewUserViewController.h"

@interface PAWLoginViewController ()
<UITextFieldDelegate,
UIScrollViewDelegate,
PAWNewUserViewControllerDelegate>

@property (nonatomic, assign) BOOL activityViewVisible;
@property (nonatomic, strong) UIView *activityView;


@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIView *backgroundView;
@property (nonatomic, strong) IBOutlet UIButton *loginButton;

@end
static NSString *const NEXT_CONTROLLER_SEGUE_ID = @"START_WORK";
static NSArray  * SCOPE = nil;

@implementation PAWLoginViewController


#pragma mark -
#pragma mark Init

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
		if (self) {
        // Disable automatic adjustment, as we want to occupy all screen real estate
		// Отключите автоматическую настройку , как мы хотим , чтобы занять весь экран недвижимость
		self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}

#pragma mark -
#pragma mark Dealloc

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	SCOPE = @[VK_PER_WALL];

	    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(dismissKeyboard)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
	
	[VKSdk initializeWithDelegate:self andAppId:@"4714824"];
	if ([VKSdk wakeUpSession])
	{
		[self startWorking];
	}
	
    [self.view addGestureRecognizer:tapGestureRecognizer];

    [self registerForKeyboardNotifications];
}
- (void)startWorking {
	[self performSegueWithIdentifier:NEXT_CONTROLLER_SEGUE_ID sender:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];

	[self.scrollView flashScrollIndicators];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.activityView.frame = self.view.bounds;
    self.scrollView.contentSize = self.backgroundView.bounds.size;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark -
#pragma mark IBActions
-(void) vkSdkReceivedNewToken:(VKAccessToken*) newToken{
	
	VKRequest * audioReq = [[VKApi users] get];
	[audioReq executeWithResultBlock:^(VKResponse * response) {
		NSError *error;
		NSData *jsonData = [NSJSONSerialization dataWithJSONObject:response.json
														   options:NSJSONWritingPrettyPrinted
															 error:&error];
		// 1) Get the latest loan
		NSDictionary* loan = [response.json objectAtIndex:0];
		
		// 2) Get the funded amount and loan amount
		
		NSString* firstname = [loan objectForKey:@"first_name"];
		NSString* ln = [loan objectForKey:@"last_name"];
		NSString* p = @" ";

		NSString* lastname = [ln stringByAppendingString: p];
		
		NSString* password = [firstname stringByAppendingString: ln];
		NSString *username = [lastname stringByAppendingString: firstname];
		

		NSLog(@"Username: %@", username);
		NSLog(@"password: %@", password);

		PFUser *user = [PFUser user];
		user.username = username;
		user.password = password;
		[user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
			if (error && !kPFErrorUsernameTaken) {
				
				UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[error userInfo][@"error"]
																	message:nil
																   delegate:self
														  cancelButtonTitle:nil
														  otherButtonTitles:@"OK", nil];
				[alertView show];
				
				// Bring the keyboard back up, because they'll probably need to change something.
				// Принесите клавиатуры обратно , потому что они, наверное, нужно что-то менять
				[self.usernameField becomeFirstResponder];
				return;
			}
			if(kPFErrorUsernameTaken){
				[PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
					// Tear down the activity view in all cases.
					// Сорвите вид деятельности во всех случаях.
					self.activityViewVisible = NO;
					
					if (user) {
						[self.delegate loginViewControllerDidLogin:self];
					} else {
						// Didn't get a user.
						// Не получите пользователю .
						NSLog(@"%s didn't get a user!", __PRETTY_FUNCTION__);
						
						NSString *alertTitle = nil;
						
						if (error) {
							// Something else went wrong
							// Что-то еще пошло не так
							alertTitle = [error userInfo][@"error"];
						} else {
							// the username or password is probably wrong.
							//Имя пользователя или пароль , вероятно, неправильно .
							alertTitle = @"Couldn’t log in:\nThe username or password were wrong.";
						}
						UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle
																			message:nil
																		   delegate:self
																  cancelButtonTitle:nil
																  otherButtonTitles:@"OK", nil];
						[alertView show];
						
						// Bring the keyboard back up, because they'll probably need to change something.
						// Принесите клавиатуры обратно , потому что они, наверное, нужно что-то менять
						[self.usernameField becomeFirstResponder];
					}
				}];
				
				
			}
			// Success!
			// Успех !
			
			[self dismissViewControllerAnimated:YES completion:nil];
			[self.delegate loginViewControllerDidLogin:self];
			
		}];


	} errorBlock:^(NSError * error) {
		if (error.code != VK_API_ERROR) {
			[error.vkError.request repeat];
		}
		else {
			NSLog(@"VK error: %@", error);
		}
	}];
	
}

- (IBAction)loginPressed:(id)sender {
    [self dismissKeyboard];
    [self processFieldEntries];
}
- (IBAction)loginWithVkPressed:(id)sender {
	[VKSdk authorize:SCOPE revokeAccess:YES forceOAuth:YES];
	

}

- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError {
	VKCaptchaViewController *vc = [VKCaptchaViewController captchaControllerWithError:captchaError];
	[vc presentIn:self];
}

- (void)vkSdkTokenHasExpired:(VKAccessToken *)expiredToken {
	[self loginWithVkPressed:nil];
}


- (void)vkSdkShouldPresentViewController:(UIViewController *)controller {
	[self presentViewController:controller animated:YES completion:nil];
}

- (void)vkSdkAcceptedUserToken:(VKAccessToken *)token {
	[self startWorking];
}
- (void)vkSdkUserDeniedAccess:(VKError *)authorizationError {
	[[[UIAlertView alloc] initWithTitle:nil message:@"Access denied" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
}



- (IBAction)loginWithFacebookPressed:(id)sender {
    // Set up activity view
	// Устанавливаем вид деятельности
    self.activityViewVisible = YES;
    // Login PFUser using facebook
	// Войти PFUser с помощью Facebook
    [PFFacebookUtils logInWithPermissions:nil block:^(PFUser *user, NSError *error) {
        if (!user) {
            // Hide the activity view
			// Скрыть зрения деятельность
            self.activityViewVisible = NO;
            NSString *alertMessage, *alertTitle;
            if (error) {
                FBErrorCategory errorCategory = [FBErrorUtility errorCategoryForError:error];
                if ([FBErrorUtility shouldNotifyUserForError:error]) {
                    // If the SDK has a message for the user, surface it.
					// ЕслиSDK имеет сообщение для пользователя , поверхность его.
                    alertTitle = @"Something Went Wrong";
                    alertMessage = [FBErrorUtility userMessageForError:error];
                } else if (errorCategory == FBErrorCategoryAuthenticationReopenSession) {
                    // It is important to handle session closures. We notify the user.
					// Это важно обращаться закрытия сессии. Мы уведомляем пользователя.
					alertTitle = @"Session Error";
                    alertMessage = @"Your current session is no longer valid. Please log in again.";
                } else if (errorCategory == FBErrorCategoryUserCancelled) {
                    // The user has cancelled a login. You can inspect the error
                    // for more context. Here, we will simply ignore it.
					//Пользователь отменил логин. Вы можете проверить ошибку
					// Для получения более подробной контексте. Здесь мы будем просто игнорировать ее .
                    NSLog(@"user cancelled login");
                } else {
                    // Handle all other errors in a generic fashion
					// Обработка всех других ошибок в общем виде
                    alertTitle  = @"Unknown Error";
                    alertMessage = @"Error. Please try again later.";
                }

                if (alertMessage) {
                    [[[UIAlertView alloc] initWithTitle:alertTitle
                                                message:alertMessage
                                               delegate:nil
                                      cancelButtonTitle:@"Dismiss"
                                      otherButtonTitles:nil] show];
                }
            }
        } else {
            // Make a call to get user info
			// Выполнение вызова , чтобы получить информацию о пользователе
            [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
                dispatch_block_t completion = ^{
                    // Hide the activity view
					// Скрыть зрения деятельность
                    self.activityViewVisible = NO;
                    // Show the logged in view
					// Показатьзашли в силу
                    [self.delegate loginViewControllerDidLogin:self];
                };

                if (error) {
                    completion();
                } else {
                    // Save the name on Parse
					// Сохранить имя на Parse
                    [PFUser currentUser][@"name"] = user.name;
                    [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                        completion();
                    }];
                }
            }];
        }
    }];
}

- (IBAction)signUpPressed:(id)sender {
    [self presentNewUserViewController];
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.usernameField) {
        [self.passwordField becomeFirstResponder];
    }
    if (textField == self.passwordField) {
        [self.passwordField resignFirstResponder];
        [self processFieldEntries];
    }

    return YES;
}

#pragma mark -
#pragma mark NewUserViewController

- (void)presentNewUserViewController {
    PAWNewUserViewController *viewController = [[PAWNewUserViewController alloc] initWithNibName:nil bundle:nil];
    viewController.delegate = self;
    [self.navigationController presentViewController:viewController animated:YES completion:nil];
}

#pragma mark Delegate

- (void)newUserViewControllerDidSignup:(PAWNewUserViewController *)controller {
    [self.delegate loginViewControllerDidLogin:self];
}

#pragma mark -
#pragma mark Private

#pragma mark Field validation

- (void)processFieldEntries {
    // Get the username text, store it in the app delegate for now
	// Получить текст имя пользователя , храните его в приложение делегата сейчас
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    NSString *noUsernameText = @"username";
    NSString *noPasswordText = @"password";
    NSString *errorText = @"No ";
    NSString *errorTextJoin = @" or ";
    NSString *errorTextEnding = @" entered";
    BOOL textError = NO;

    // Messaging nil will return 0, so these checks implicitly check for nil text.
	// Сообщений ноль вернет 0 , так что эти проверки неявно проверить нулевой текста.
	if (username.length == 0 || password.length == 0) {
        textError = YES;

        // Set up the keyboard for the first field missing input:
		// Устанавливаем клавиатуру для первого поля отсутствует вход :
        if (password.length == 0) {
            [self.passwordField becomeFirstResponder];
        }
        if (username.length == 0) {
            [self.usernameField becomeFirstResponder];
        }
    }

    if ([username length] == 0) {
        textError = YES;
        errorText = [errorText stringByAppendingString:noUsernameText];
    }

    if ([password length] == 0) {
        textError = YES;
        if ([username length] == 0) {
            errorText = [errorText stringByAppendingString:errorTextJoin];
        }
        errorText = [errorText stringByAppendingString:noPasswordText];
    }

    if (textError) {
        errorText = [errorText stringByAppendingString:errorTextEnding];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:errorText
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"OK", nil];
        [alertView show];
        return;
    }

    // Everything looks good; try to log in.
	// Все выглядит хорошо ; попытаться войти .

    // Set up activity view
	// Устанавливаем вид деятельности
    self.activityViewVisible = YES;

    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
        // Tear down the activity view in all cases.
		// Сорвите вид деятельности во всех случаях.
        self.activityViewVisible = NO;

        if (user) {
            [self.delegate loginViewControllerDidLogin:self];
        } else {
            // Didn't get a user.
			// Не получите пользователю .
            NSLog(@"%s didn't get a user!", __PRETTY_FUNCTION__);

            NSString *alertTitle = nil;

            if (error) {
                // Something else went wrong
				// Что-то еще пошло не так
                alertTitle = [error userInfo][@"error"];
            } else {
                // the username or password is probably wrong.
				//Имя пользователя или пароль , вероятно, неправильно .
                alertTitle = @"Couldn’t log in:\nThe username or password were wrong.";
            }
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle
                                                                message:nil
                                                               delegate:self
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"OK", nil];
            [alertView show];

            // Bring the keyboard back up, because they'll probably need to change something.
			// Принесите клавиатуры обратно , потому что они, наверное, нужно что-то менять 
            [self.usernameField becomeFirstResponder];
        }
    }];
}

#pragma mark Keyboard

- (void)dismissKeyboard {
    [self.view endEditing:YES];
}

- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification*)notification {
    NSDictionary *userInfo = [notification userInfo];
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];

    CGRect keyboardFrame = [self.view convertRect:endFrame fromView:self.view.window];

    CGFloat scrollViewOffsetY = (CGRectGetHeight(keyboardFrame) -
                                 (CGRectGetMaxY(self.view.bounds) -
                                  CGRectGetMaxY(self.loginButton.frame) - 10.0f));

    if (scrollViewOffsetY < 0) {
        return;
    }

    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];

    [UIView animateWithDuration:duration
                          delay:0.0
                        options:curve << 16 | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [self.scrollView setContentOffset:CGPointMake(0.0f, scrollViewOffsetY) animated:NO];
                     }
                     completion:nil];

}

- (void)keyboardWillHide:(NSNotification*)notification {
    NSDictionary *userInfo = [notification userInfo];
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];

    [UIView animateWithDuration:duration
                          delay:0.0
                        options:curve << 16 | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [self.scrollView setContentOffset:CGPointZero animated:NO];
                     }
                     completion:nil];
}

#pragma mark ActivityView

- (void)setActivityViewVisible:(BOOL)visible {
    if (self.activityViewVisible == visible) {
        return;
    }

    _activityViewVisible = visible;

    if (_activityViewVisible) {
        PAWActivityView *activityView = [[PAWActivityView alloc] initWithFrame:self.view.bounds];
        activityView.label.text = @"Logging in";
        activityView.label.font = [UIFont boldSystemFontOfSize:20.f];
        [activityView.activityIndicator startAnimating];

        _activityView = activityView;
        [self.view addSubview:_activityView];
    } else {
        [_activityView removeFromSuperview];
        _activityView = nil;
    }
}

@end

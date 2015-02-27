

#import "PAWNewUserViewController.h"
#import "PAWConstants.h"
#import <Parse/Parse.h>
#import "PAWActivityView.h"

@interface PAWNewUserViewController () <UITextFieldDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet UIButton *createAccountButton;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIImageView *iconImageView;
@property (nonatomic, strong) IBOutlet UIImageView *logoImageView;

@property (nonatomic, assign) CGFloat iconImageViewOriginalY;
@property (nonatomic, assign) CGFloat iconLogoOffsetY;
@property (nonatomic, assign) UIImage* avatarImage;

@end

@implementation PAWNewUserViewController

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
	[self.avatarImageView setImage:[UIImage imageNamed:@"testImage"]];
	_avatarImage =[UIImage imageNamed:@"testImage"];
	CALayer * ourLayer = [self.avatarImageView layer]; // Будем округлять UIImageView
	ourLayer.cornerRadius = 50.0f;           // Polovina korotkoi storoni, Задаем радиус для округления.
	ourLayer.masksToBounds = YES;           // Чтобы за овальной границей в углах ничего не рисовалось
	ourLayer.borderWidth = 0.0f;            // Границу рисовать не будем. Если нужна - указываем толщину
	

	_scrollView.scrollEnabled = YES;
	_scrollView.contentSize = CGSizeMake(320, 1400);
    // Do any additional setup after loading the view from its nib.
	// У любой дополнительной настройки после загрузки видом из своего пера .

    // For dismissing keyboard
	// Для увольнения клавиатуры
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(dismissKeyboard)];
	
	
	[self.view addGestureRecognizer:tapGestureRecognizer];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self registerForKeyboardNotifications];
    // Save original y position and offsets for floating views
	// Сохранить оригинальный Позиция Y и смещения с плавающей Просмотры
    self.iconImageViewOriginalY = self.iconImageView.frame.origin.y;
    self.iconLogoOffsetY = self.logoImageView.frame.origin.y - self.iconImageView.frame.origin.y;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.usernameField becomeFirstResponder];
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
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if (textField == self.emailFiled) {
		[self.lastnameField becomeFirstResponder];
	}
	if (textField == self.lastnameField) {
		[self.phoneFiled becomeFirstResponder];
	}
	if (textField == self.phoneFiled) {
		[self.passwordField becomeFirstResponder];
	}
    if (textField == self.passwordField) {
        [self.passwordAgainField becomeFirstResponder];
    }
    if (textField == self.passwordAgainField) {
        [self.countryField becomeFirstResponder];
    }
	if (textField == self.countryField) {
		[self.cityField becomeFirstResponder];
	}
	if (textField == self.cityField) {
		[self.passwordAgainField resignFirstResponder];
		[self processFieldEntries];
	}

    return YES;
}

#pragma mark -
#pragma mark IBActions

- (IBAction)createAccountPressed:(id)sender {
    [self dismissKeyboard];
    [self processFieldEntries];
}

- (IBAction)closeButtonPressed:(id)sender {
    [self dismissKeyboard];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark Sign Up

- (void)processFieldEntries {
    // Check that we have a non-zero username and passwords.
    // Compare password and passwordAgain for equality
    // Throw up a dialog that tells them what they did wrong if they did it wrong.
	// Проверяем, что у нас есть ненулевой имя пользователя и пароль .
	//Сравните пароль и passwordAgain для равенства
	//Бросьте диалог, который говорит им, что они сделали неправильно , если они сделали это неправильно.

    NSString *login = self.emailFiled.text;
	NSString *username = self.usernameField.text;
	NSString *lastname = self.lastnameField.text;
	NSString *phone = self.phoneFiled.text;
    NSString *password = self.passwordField.text;
    NSString *passwordAgain = self.passwordAgainField.text;
//    NSString *email = ;
	NSString *country = self.countryField.text;
	NSString *city = self.cityField.text;
	NSString *carma = @"0";
	NSString *rank = @"Новичок";
    NSString *errorText = @"Please ";
    NSString *usernameBlankText = @"enter a username";
    NSString *passwordBlankText = @"enter a password";
    NSString *joinText = @", and ";
    NSString *passwordMismatchText = @"enter the same password twice";
	NSString *agreementswitchBlankText = @"Вы не согласились с правилами и условиями!";
    BOOL textError = NO;

    // Messaging nil will return 0, so these checks implicitly check for nil text.
	// Сообщений ноль вернет 0 , так что эти проверки неявно проверить нулевой текста.
    if (login.length == 0 || lastname.length == 0 || password.length == 0 || passwordAgain.length == 0 || phone.length == 0 ) {
        textError = YES;

        // Set up the keyboard for the first field missing input:
		// Устанавливаем клавиатуру для первого поля отсутствует вход :
        if (passwordAgain.length == 0) {
            [self.passwordAgainField becomeFirstResponder];
        }
        if (password.length == 0) {
            [self.passwordField becomeFirstResponder];
        }
        if (login.length == 0) {
            [self.usernameField becomeFirstResponder];
        }
		if (lastname.length == 0) {
			[self.lastnameField becomeFirstResponder];
		}
		if (phone.length == 0) {
			[self.phoneFiled becomeFirstResponder];
		}
		
        if (login.length == 0) {
            errorText = [errorText stringByAppendingString:usernameBlankText];
        }
		        if (password.length == 0 || passwordAgain.length == 0) {
            if (login.length == 0) { // We need some joining text in the error: // Нам нужна присоединения текст ошибки :
                errorText = [errorText stringByAppendingString:joinText];
            }
            errorText = [errorText stringByAppendingString:passwordBlankText];
        }
    } else if ([password compare:passwordAgain] != NSOrderedSame) {
        // We have non-zero strings.
        // Check for equal password strings.
		// У нас есть ненулевые строки .
		// Проверяем равных строк паролей.
        textError = YES;
        errorText = [errorText stringByAppendingString:passwordMismatchText];
        [self.passwordField becomeFirstResponder];
    }
	if([_agreementswitch isOn] == NO){
		textError = YES;
		errorText = [errorText stringByAppendingString:agreementswitchBlankText];
		NSLog(@"switch");
	}

    if (textError) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:errorText message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        return;
    }

    // Everything looks good; try to log in.
	// Все выглядит хорошо ; попытаться войти .
    PAWActivityView *activityView = [[PAWActivityView alloc] initWithFrame:CGRectMake(0.f, 0.f, 320, 1200)];
    UILabel *label = activityView.label;
    label.text = @"Signing You Up";
    label.font = [UIFont boldSystemFontOfSize:20.f];
    [activityView.activityIndicator startAnimating];
    [activityView layoutSubviews];

    [self.view addSubview:activityView];

    // Call into an object somewhere that has code for setting up a user.
    // The app delegate cares about this, but so do a lot of other objects.
    // For now, do this inline.
	// Вызов в объект где-то , что имеет код для настройки пользователя.
	//Приложение делегат заботится об этом, но так делают много других объектов.
	// В настоящее время, сделать это , как встроенные.

    PFUser *user = [PFUser user];
    user.username = login;
	user[PAWParsePostFirstNameKey] = username;
	user[PAWParsePostLastNameKey] = lastname;
	user[PAWParsePostPhoneKey] = phone;
    user.password = password;
	user[PAWParsePostCountryKey] = country;
	user[PAWParsePostCityKey] = city;
	user[PAWParsePostRankKey] = rank;
	user[PAWParsePostCarmaKey] = carma;
	
//	NSData *imageData = UIImagePNGRepresentation(_avatarImage);
//
//	
//	UIImage *myImage = [[UIImage alloc] initWithData:imageData];
////	[myImage setImage:[UIImage imageNamed:_avatarImage]];
//	
//	CGRect cropRect = CGRectMake(0.0, 0.0, 50.0, 50.0);
//	CGImageRef croppedImage = CGImageCreateWithImageInRect([myImage CGImage], cropRect);
//	
//	UIImage *myCroppedImage = [UIImage imageWithCGImage:croppedImage];
//	
//	CGImageRelease(croppedImage);
	
	CGSize size = CGSizeMake(100, 100);
	
	UIGraphicsBeginImageContext(size);
	[_avatarImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
	UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	NSData *imageData2 = UIImagePNGRepresentation(destImage);
	user[@"smallavatar"] = [PFFile fileWithData:imageData2];

	
	NSData *imageData = UIImagePNGRepresentation(_avatarImage);
	user[PAWParsePostAvatarKey] = [PFFile fileWithData:imageData];
	
	
	
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[error userInfo][@"error"]
                                                                message:nil
                                                               delegate:self
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"OK", nil];
            [alertView show];
            [activityView.activityIndicator stopAnimating];
            [activityView removeFromSuperview];
            // Bring the keyboard back up, because they'll probably need to change something.
			// Принесите клавиатуры обратно , потому что они, наверное, нужно что-то менять
            [self.usernameField becomeFirstResponder];
            return;
        }

        // Success!
		// Успех !
        [activityView.activityIndicator stopAnimating];
        [activityView removeFromSuperview];

        [self dismissViewControllerAnimated:YES completion:nil];
        [self.delegate newUserViewControllerDidSignup:self];
    }];
}

//- (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size {
//	UIGraphicsBeginImageContext(size);
//	[image drawInRect:CGRectMake(0, 0, size.width, size.height)];
//	UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
//	UIGraphicsEndImageContext();
//	return destImage;
//}


#pragma mark -
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
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];

    CGFloat scrollViewOffsetY = (keyboardFrame.size.height -
                                 (CGRectGetHeight(self.view.bounds) -
                                  CGRectGetMaxY(self.createAccountButton.frame)));
//     Check if scrolling needed
//	 Проверяем, если прокрутка необходима
    if (scrollViewOffsetY < 0) {
        return;
    }

    // Fix the icon and logo if necessary
	// Fix значок и логотип , если это необходимо
    CGFloat bottomViewToCheck = self.iconImageView.frame.origin.y + self.iconImageView.frame.size.height;
//     Only if the logo is party visible (happens for 3.5-inch device)
//	 Только еслилоготип является участником видно ( происходит из-за 3,5 - дюймовых устройств )
    if (scrollViewOffsetY > bottomViewToCheck) {
        return;
    }
    CGFloat yIconOffset = MAX(scrollViewOffsetY, self.iconImageViewOriginalY);
    __block CGRect iconFrame = self.iconImageView.frame;

    [UIView animateWithDuration:duration
                          delay:0.0
                        options:curve << 16 | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [self.scrollView setContentOffset:CGPointMake(0.0f, scrollViewOffsetY) animated:NO];

                         if (yIconOffset != iconFrame.origin.y) {
//                              Move icon
							 // Переместить значок
                             iconFrame.origin.y = yIconOffset + 20.0f;
                             self.iconImageView.frame = iconFrame;

                             // Move logo with respect to the icon and
                             // decrease distance between them slightly
                             // to avoid overlap with the first text field.
							 // Перемещение логотип по отношению к иконе и
							 // Уменьшение расстояния между ними немного
							 // Чтобы избежать дублирования с первого текстового поля.
                             CGRect logoFrame = self.logoImageView.frame;
                             logoFrame.origin.y = CGRectGetMinY(iconFrame) + self.iconLogoOffsetY - 7.0f;
                             self.logoImageView.frame = logoFrame;
                         }
                     }
                     completion:nil];
}

- (void)keyboardWillHide:(NSNotification*)notification {
//    NSDictionary *userInfo = [notification userInfo];
//    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    CGRect keyboardFrame = [self.view convertRect:endFrame fromView:self.view.window];
//    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
//
//    [UIView animateWithDuration:duration
//                          delay:0.0
//                        options:curve << 16 | UIViewAnimationOptionBeginFromCurrentState
//                     animations:^{
//                         [self.scrollView setContentOffset:CGPointZero animated:NO];
//
//                         if (self.iconImageView.frame.origin.y != self.iconImageViewOriginalY) {
//                             CGRect iconFrame = self.iconImageView.frame;
//                             iconFrame.origin.y = self.iconImageViewOriginalY;
//                             self.iconImageView.frame = iconFrame;
//
//                             CGRect logoFrame = self.logoImageView.frame;
//                             logoFrame.origin.y = self.iconImageViewOriginalY + self.iconLogoOffsetY;
//                             self.logoImageView.frame = logoFrame;
//                         }
//                     }
//                     completion:nil];
}

- (IBAction)avatarButton:(id)sender {
		picker2 = [[UIImagePickerController alloc] init];
	picker2.delegate = self;
	[picker2 setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
	[self presentModalViewController:picker2 animated:YES];
}

- (IBAction)agreementSwitch:(id)sender {
	UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"согласие с правилами" message:@"Это простой UIAlertView, он просто показывает сообщение" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
	[alert show];
}



-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
	UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
	_avatarImage = image;
	[self.avatarImageView setImage:image];
	[self dismissModalViewControllerAnimated:YES];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
	[self dismissModalViewControllerAnimated:YES];
	
}

@end

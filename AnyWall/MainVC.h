#import "AMSlideMenuMainViewController.h"

@class MainVC;

@protocol MainVCDelegate <NSObject>


- (void)settingsViewControllerDidLogout:(MainVC *) controller;

@end


@interface MainVC : AMSlideMenuMainViewController

//@property (nonatomic, weak) id<PAWWallViewControllerDelegate> delegate;
@property (nonatomic, weak) id<MainVCDelegate> delegate;

@end

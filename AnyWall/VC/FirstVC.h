#import <UIKit/UIKit.h>

@class FirstVC;

@protocol FirstVCDelegate <NSObject>

// - (void)wallViewControllerWantsToPresentSettings:(FirstVC *)controller;

@end



@interface FirstVC : UIViewController

@property (nonatomic, weak) id<FirstVCDelegate> delegate;

@end

#import <UIKit/UIKit.h>

@class photo;

@protocol photoDelegate <NSObject>

@end



@interface photo : UIViewController

@property (nonatomic, weak) id<photoDelegate> delegate;

@end

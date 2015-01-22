
#import <UIKit/UIKit.h>

@class PAWPostMenu;

@protocol PAWPostMenu <NSObject>

- (void)settingsViewControllerDidLogout:(PAWPostMenu*)controller;

@end

@interface PAWPostMenu: UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (nonatomic, weak) id<PAWPostMenu> delegate;

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end


#import "mainFile.h"
#import "AMSlideMenuLeftTableViewController.h"



@interface LeftMenuTVC : AMSlideMenuLeftTableViewController


#pragma mark - Outlets
@property (strong, nonatomic) IBOutlet UITableView *view;

#pragma mark - Properties
@property (strong, nonatomic) NSMutableArray *tableData;
//@property (nonatomic, weak) id<LeftMenuDelegate> delegate;

@end

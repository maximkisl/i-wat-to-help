

#import "LeftMenuTVC.h"
#import "mainFile.h"
#import "SecondVC.h"
#import "PAWWallViewController.h"
#import "mainF.h"

@interface LeftMenuTVC ()

@end

@implementation LeftMenuTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Initilizing data souce
    self.tableData = [@[@"Help",@"Profile", @"Messages", @"Setting", @"Current task", @"History assistance"] mutableCopy];
}

#pragma mark - TableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = self.tableData[indexPath.row];
    
    return cell;
}
#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UINavigationController *nvc;
    PAWWallViewController *rootVC;
    switch (indexPath.row) {
        case 0:
        {
			rootVC = [[PAWWallViewController alloc] initWithNibName:@"PAWWallViewController" bundle:nil];

        }
            break;
        case 4:
        {
            rootVC = [[SecondVC alloc] initWithNibName:@"SecondVC" bundle:nil];
        }
            break;
        case 1:
        {
			mainFile *f = [[mainFile alloc] init];
			rootVC = f;
        }
            break;
			
        default:
            break;
    }
    nvc = [[UINavigationController alloc] initWithRootViewController:rootVC];
    
    [self openContentNavigationController:nvc];
}

@end

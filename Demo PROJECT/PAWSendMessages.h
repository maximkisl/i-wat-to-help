//
//  PAWSendMessages.h
//  IWontToHelp
//
//  Created by Mac on 2/15/15.
//  Copyright (c) 2015 Parse Inc. All rights reserved.
//

#import <Parse/Parse.h>
@protocol PAWSendMessagesDelegat <NSObject>


@end
@interface PAWSendMessages : PFQueryTableViewController{
	
}
@property (nonatomic, weak) id<PAWSendMessagesDelegat> dataSource;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSString *marray;
//@property (strong, nonatomic) NSMutableArray *blogPostArray;

- (id)initWithPFObject:(PFObject *)object WithStyle:(UITableViewStyle)style selfArray:(BOOL)check;
//- (instancetype)initWithTitle:(NSString *)title;

@end

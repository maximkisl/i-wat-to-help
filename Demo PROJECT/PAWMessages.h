//
//  PAWMessages.h
//  IWontToHelp
//
//  Created by Mac on 2/9/15.
//  Copyright (c) 2015 Parse Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol PAWMessagesDelegat <NSObject>


@end

@interface PAWMessages : PFQueryTableViewController{

}
@property (nonatomic, weak) id<PAWMessagesDelegat> dataSource;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

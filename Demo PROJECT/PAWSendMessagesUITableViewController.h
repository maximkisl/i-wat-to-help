//
//  PAWSendMessagesUITableViewController.h
//  IWontToHelp
//
//  Created by Mac on 2/17/15.
//  Copyright (c) 2015 Parse Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PAWSendMessagesUITableViewController : UIViewController <UITableViewDelegate,UITextFieldDelegate>{

}

- (instancetype)initWithPFObject:(PFObject *)object;
- (void)viewDidLoad ;
@property (weak, nonatomic) IBOutlet UITableView *colorsTable;
@property (weak, nonatomic) IBOutlet UITextField *taxtFiled;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)send:(id)sender;

@end

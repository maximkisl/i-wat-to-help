//
//  PAWSendFriendsMessage.h
//  IWontToHelp
//
//  Created by Mac on 2/25/15.
//  Copyright (c) 2015 Parse Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PAWSendFriendsMessage : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *textFiled;
- (IBAction)send:(id)sender;
- (instancetype)initWithPFObject:(PFUser *)object;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *lastname;
@property (weak, nonatomic) IBOutlet UILabel *carma;
@property (weak, nonatomic) IBOutlet UILabel *rank;

@end

//
//  PAWFriendsProfile.h
//  IWontToHelp
//
//  Created by Mac on 2/25/15.
//  Copyright (c) 2015 Parse Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PAWFriendsProfile : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageTestProfil2;
@property (weak, nonatomic) IBOutlet UILabel *carma;
@property (weak, nonatomic) IBOutlet UILabel *rank;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *lastname;
@property (weak, nonatomic) IBOutlet UILabel *country;
@property (weak, nonatomic) IBOutlet UILabel *city;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *carmalabel;

- (instancetype)initWithPFObject:(PFObject *)object;
- (IBAction)sendToFriend:(id)sender;
- (IBAction)cell:(id)sender;

@end

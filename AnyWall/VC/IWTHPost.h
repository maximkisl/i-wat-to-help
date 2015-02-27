//
//  IWTHPost.h
//  IWontToHelp
//
//  Created by Mac on 2/1/15.
//  Copyright (c) 2015 Parse Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@class IWTHPost;






@interface IWTHPost : UIViewController {
}
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *Opesanie;
@property (strong, nonatomic) IBOutlet UIView *view;

@property (weak, nonatomic) IBOutlet UITextField *info;
@property (weak, nonatomic) IBOutlet UITextField *moreInfo;
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;

//@property (strong, nonatomic) IBOutlet UIScrollView *ScrollView;
- (IBAction)helpButton:(id)sender;

@end

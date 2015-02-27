//
//  IWTHNewPostViewController.h
//  IWontToHelp
//
//  Created by Mac on 2/21/15.
//  Copyright (c) 2015 Parse Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IWTHNewPostViewController : UIViewController<UIPickerViewDelegate, UIImagePickerControllerDelegate>{
	UIImagePickerController * picker2;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrolView;

@property (weak, nonatomic) IBOutlet UITextField *infoTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *moreInfoTextFiled;

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

- (IBAction)category:(id)sender;
- (IBAction)complexity:(id)sender;
- (IBAction)count:(id)sender;
- (IBAction)pickerPhoto:(id)sender;
- (IBAction)helpButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (weak, nonatomic) IBOutlet UIButton *countRank;
@property (weak, nonatomic) IBOutlet UIButton *category;
@property (weak, nonatomic) IBOutlet UIButton *complexity;

@property (weak, nonatomic) IBOutlet UISwitch *switchLocation;
@end

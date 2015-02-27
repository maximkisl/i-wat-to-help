//
//  SPHViewController.h
//  SPHChatCollectionView
//
//  Created by Siba Prasad Hota on 14/06/14.
//  Copyright (c) 2014 Wemakeappz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPHViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource,UITextFieldDelegate>
{
    NSMutableArray *sphBubbledata;
	
	
    BOOL isfromMe;
}
- (instancetype)initWithTitle:(NSString *)title;

- (instancetype)initWithPFObject:(PFObject *)object;

@property (nonatomic, strong, readonly) PFObject *object;

@property (nonatomic, copy, readonly) NSString *title;
@property (strong, nonatomic) NSString *marray;
@property (strong, nonatomic) NSString *marray2;

@property (weak, nonatomic) IBOutlet UICollectionView *sphChatTable;
@property (weak, nonatomic) IBOutlet UIView *msgInPutView;
@property (weak, nonatomic) IBOutlet UITextField *messageField;

- (IBAction)sendMessageNow:(id)sender;
@end

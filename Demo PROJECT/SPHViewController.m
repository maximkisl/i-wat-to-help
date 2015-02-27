//
//  SPHViewController.m
//  SPHChatCollectionView
//
//  Created by Siba Prasad Hota on 14/06/14.
//  Copyright (c) 2014 Wemakeappz. All rights reserved.
//

#import "SPHViewController.h"
#import "PAWConstants.h"



// BELOW ITEMS FOR COLLECTION VIEW

#import "SPHCollectionViewcell.h"
#import "SPH_PARAM_List.h"
#import "iosMacroDefine.h"
#import "PAWConstants.h"
static NSString *CellIdentifier = @"cellIdentifier";
//NSMutableArray *marray;


@interface SPHViewController ()
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) PFObject *object;

@end


@implementation SPHViewController
@synthesize marray;
@synthesize marray2;

NSData *data;
NSData *data2;

NSArray *blogPostArray;
NSArray *blogPostArray2;

NSDate *createdAt;
NSDate *createdAt2;



- (instancetype)initWithTitle:(NSString *)title

{

	self = [super init];
	if (self) {
	}
	return self;
	
}

-(void)dealloc{
	
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (instancetype)initWithPFObject:(PFObject *)object {
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificatioNewMaasage:) name:kHMnotificatioNewMaasage object:nil];

		
	[self apdate:object];

	
	
	//self = [self initWithTitle:title];
	if (self) {
		self.object = object;
		self.marray = marray;
//		_userPointer = object[PAWParsePostUserKey];;
	}
	return self;
}
-(void) notificatioNewMaasage:(NSNotification*) notification{
	NSLog(@"notificatioNewMaasage ");
	
	blogPostArray = [self.object objectForKey:@"messages"];
	for(PFObject *object in blogPostArray){
		NSString *objectId = object.objectId;
		
		PFQuery *query = [PFQuery queryWithClassName:@"BlogPost"];
		[query whereKey:@"objectId" equalTo:object.objectId];
		
		//[query orderByAscending:@"updatedAt"];
		
		[query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
			
			if(error){
			
				NSLog(@"getFirstObjectInBackgroundWithBlock error ", error);
			}
			PFUser *user =[object objectForKey:@"user"];
			
			NSLog(@"user id: %@", user.objectId);
			
			
			createdAt= object.createdAt;
			
			marray = [object objectForKey:@"message"];
			
			[self SetupDummyMessages:createdAt andUseId:user.objectId];
			
			NSLog(@"marray marray marray : %@", marray );
		}];
		
	}
}
-(void)apdate:(PFObject *) object{
	[object fetchIfNeeded];
	
	PFFile *imageData =  [object objectForKey:@"smallavatar"];
	data = [imageData getData];
	
	
	
	NSString *title = [object objectForKey:@"message"];
	blogPostArray = [object objectForKey:@"messages"];
	for(PFObject *object in blogPostArray){
		NSString *objectId = object.objectId;
		@synchronized(self)
		{
			PFQuery *query = [PFQuery queryWithClassName:@"BlogPost"];
			[query whereKey:@"objectId" equalTo:objectId];
			
			[query orderByAscending:@"updatedAt"];
			
			[query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
				PFUser *user =[object objectForKey:@"user"];
				
				NSLog(@"user id: %@", user.objectId);
				
				
				createdAt= object.createdAt;
				
				marray = [object objectForKey:@"message"];
				
				[self SetupDummyMessages:createdAt andUseId:user.objectId];
				
				NSLog(@"marray marray marray : %@", marray );
			}];
		}
	}

}

- (void)viewDidLoad
{
    [super viewDidLoad];

//	self.messageField.delegate = self;
//	[self.messageField becomeFirstResponder];
	
	
//	self.navigationController.view.backgroundColor = [UIColor clearColor];

    [[UIApplication sharedApplication] setStatusBarHidden:NO];
	
    sphBubbledata =[[NSMutableArray alloc]init];
    
    UINib *cellNib = [UINib nibWithNibName:@"View" bundle:nil];
    [self.sphChatTable registerNib:cellNib forCellWithReuseIdentifier:CellIdentifier];
    
	//[self SetupDummyMessages:nil];

    isfromMe=NO;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.sphChatTable addGestureRecognizer:tap];
     self.sphChatTable.backgroundColor =[UIColor clearColor];
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
	
    self.messageField.leftView = paddingView;
    self.messageField.leftViewMode = UITextFieldViewModeAlways;
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)dismissKeyboard
{
    [self.view endEditing:YES];
}


/////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////******* GENERATE RANDOM ID to SAVE IN LOCAL **************/////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////


-(NSString *) genRandStringLength: (int) len {
	
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
    }
    
    return randomString;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////******* SETUP DUMMY MESSAGE / REPLACE THEM IN LIVE **************/////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////

-(void)SetupDummyMessages:(NSDate *)createdAt andUseId:(NSString *)userId
{
	@synchronized(self)
	{
	
    NSDate *date = [NSDate date];
	date = createdAt;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
	[formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"]];
	
//	NSLog(@"%lu", (unsigned long)[marray count]);
//    //  mediaPath  : Your Message  or  Path of the Image
//	
//	NSInteger intc = [marray count];
	
//	for (int i = 1; i < intc; i++)
//	{
//		NSString *string = [marray objectAtIndex:i];

	NSLog(@"userId %@", userId);
	
	PFUser *currentUser = [PFUser currentUser];
	BOOL check = [currentUser.objectId  isEqualToString: userId];
	
	if(check){
			NSString *rowNum=[NSString stringWithFormat:@"%d",(int)sphBubbledata.count];
			[self adddMediaBubbledata:kSTextByme mediaPath:marray mtime:[formatter stringFromDate:createdAt] thumb:@"" downloadstatus:@"" sendingStatus:kSending msg_ID:[self genRandStringLength:7]];
			[self performSelector:@selector(messageSent:) withObject:rowNum afterDelay:1];
			
			isfromMe=NO;
	}
		else
		{
			[self adddMediaBubbledata:kSTextByOther mediaPath:marray mtime:[formatter stringFromDate:createdAt] thumb:@"" downloadstatus:@"" sendingStatus:kSent msg_ID:[self genRandStringLength:7]];
			isfromMe=YES;
		}
	

    [self.sphChatTable reloadData];
	}
}


/////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////******* UPDATE WHEN MESSAGE SENT                   **************/////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////


-(void)messageSent:(NSString*)rownum
{
    int rowID=[rownum intValue];
    
    SPH_PARAM_List *feed_data=[[SPH_PARAM_List alloc]init];
    feed_data=[sphBubbledata objectAtIndex:rowID];
    
    [sphBubbledata  removeObjectAtIndex:rowID];
    feed_data.chat_send_status=kSent;
    [sphBubbledata insertObject:feed_data atIndex:rowID];
   
   // [self.sphChatTable reloadData];
   
    NSArray *indexPaths = [NSArray arrayWithObjects:
                           [NSIndexPath indexPathForRow:rowID inSection:0],
                           // Add some more index paths if you want here
                           nil];
    BOOL animationsEnabled = [UIView areAnimationsEnabled];
    [UIView setAnimationsEnabled:NO];
    [self.sphChatTable reloadItemsAtIndexPaths:indexPaths];
    [UIView setAnimationsEnabled:animationsEnabled];
}

-(void)scrollTableview
{
    
    NSInteger item = [self collectionView:self.sphChatTable numberOfItemsInSection:0] - 1;
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForItem:item inSection:0];
    [self.sphChatTable
     scrollToItemAtIndexPath:lastIndexPath
     atScrollPosition:UICollectionViewScrollPositionBottom
     animated:NO];
}


/////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////*******       SEND MESSAGE PRESSED                 **************/////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////

- (IBAction)sendMessageNow:(id)sender
{
	// create blogpost post
	
	PFObject *blogpost = [PFObject objectWithClassName:@"BlogPost"];
	
	[blogpost setObject:@"Fucking my text!=)" forKey:@"message"];
	
	[blogpost setObject:[PFUser currentUser] forKey:@"user"];

	PFUser *user = [PFUser currentUser];
	
	PFFile *imageData =	[user objectForKeyedSubscript:@"smallavatar"];
	
//	NSData *data = [imageData getData];
	
	[blogpost setObject:imageData forKey:@"smallavatar"];

	
	//record  blogpost post in array
	
	NSMutableArray * mArrayblogPost = [[NSMutableArray alloc] initWithArray:blogPostArray];
	
	[mArrayblogPost addObject:blogpost];
	
	// save array in background
	PFObject *objectSaveArray = self.object;
	
	objectSaveArray[@"messages"] = mArrayblogPost;
	[objectSaveArray saveEventually:^(BOOL succeeded, NSError *error) {
		
	}];
	

	
	
	[[NSNotificationCenter defaultCenter] postNotificationName:kHMnotificatioNewMaasage object:nil];

//	PFFile *imageData2 =  [objectSaveArray objectForKey:@"smallavatar"];
//	data = [imageData2 getData];
	
	
	
//	NSString *title = [objectSaveArray objectForKey:@"message"];

	

//	NSString *title = [self.object objectForKey:@"message"];
//	blogPostArray = [self.object objectForKey:@"messages"];
//	for(PFObject *object in blogPostArray){
//		NSString *objectId = object.objectId;
//		@synchronized(self)
//		{
//			PFQuery *query = [PFQuery queryWithClassName:@"BlogPost"];
//			[query whereKey:@"objectId" equalTo:objectId];
//			
//			[query orderByAscending:@"updatedAt"];
//			
//			[query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
//				PFUser *user =[object objectForKey:@"user"];
//				
//				NSLog(@"user id: %@", user.objectId);
//				
//				
//				createdAt= object.createdAt;
//				
//				marray = [object objectForKey:@"message"];
//				
//				[self SetupDummyMessages:createdAt andUseId:user.objectId];
//				
//				NSLog(@"marray marray marray : %@", marray );
//			}];
//		}
//	}


//	PFQuery *query = [PFQuery queryWithClassName:@"Comment"];
//	[query whereKey:@"author" equalTo:[PFUser currentUser]];
//	
//	PFQuery *query2 = [PFQuery queryWithClassName:@"Comment"];
//	[query2 whereKey:@"frends" equalTo:[PFUser currentUser]];
//	
//	PFQuery *mainQuery = [PFQuery orQueryWithSubqueries:@[query,query2]];
//	[mainQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
//		NSLog(@"findObjectsInBackgroundWithBlock %@", objects);
//		if(objects.count > 0){
//			for (PFObject *object in objects) {
//				NSLog(@"PFUser %@", object);
//			}
//		}else
//		{
//			
//			
//			PFObject *blogpost = [PFObject objectWithClassName:@"BlogPost"];
//			
//			[blogpost setObject:@"message text for user" forKey:@"message"];
//			
//			[blogpost setObject:[PFUser currentUser] forKey:@"user"];
//			
//			
//			PFObject *comment = [PFObject objectWithClassName:@"Comment"];
//			
//			[comment addUniqueObjectsFromArray:@[blogpost]forKey:@"messages"];
//			
//			[comment setObject:[PFUser currentUser] forKey:@"author"];
//			
//			[comment setObject:[PFUser currentUser] forKey:@"frends"];
//			
//			[comment setObject:blogpost forKey:@"post"];
//			
//			[comment saveEventually];
//			
//		}
//	}];
	
	
	
	
//    NSDate *date = [NSDate date];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"HH:mm"];
//	
//    
//    if ([self.messageField.text length]>0) {
//        
//        if (isfromMe)
//        {
//            NSString *rowNum=[NSString stringWithFormat:@"%d",(int)sphBubbledata.count];
//            [self adddMediaBubbledata:kSTextByme mediaPath:self.messageField.text mtime:[formatter stringFromDate:date] thumb:@"" downloadstatus:@"" sendingStatus:kSending msg_ID:[self genRandStringLength:7]];
//         //   [self performSelector:@selector(messageSent:) withObject:rowNum afterDelay:1];
//            
//            isfromMe=NO;
//        }
//        else
//        {
//            [self adddMediaBubbledata:kSTextByOther mediaPath:self.messageField.text mtime:[formatter stringFromDate:date] thumb:@"" downloadstatus:@"" sendingStatus:kSent msg_ID:[self genRandStringLength:7]];
//            isfromMe=YES;
//        }
//        
////        [self.sphChatTable reloadData];
////        [self scrollTableview];
//    }
}


-(void)adddMediaBubbledata:(NSString*)mediaType  mediaPath:(NSString*)mediaPath mtime:(NSString*)messageTime thumb:(NSString*)thumbUrl  downloadstatus:(NSString*)downloadstatus sendingStatus:(NSString*)sendingStatus msg_ID:(NSString*)msgID
{
    
    SPH_PARAM_List *feed_data=[[SPH_PARAM_List alloc]init];
    feed_data.chat_message=mediaPath;
    feed_data.chat_date_time=messageTime;
    feed_data.chat_media_type=mediaType;
    feed_data.chat_send_status=sendingStatus;
    feed_data.chat_Thumburl=thumbUrl;
    feed_data.chat_downloadStatus=downloadstatus;
    feed_data.chat_messageID=msgID;
    [sphBubbledata addObject:feed_data];
}




/////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////******* KEYBOARD UPDOWN EVENT                      **************/////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{


	return  YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
//	[self.messageField becomeFirstResponder];
//	[self.messageField selectAll:self];
//	[self.view endEditing:<#(BOOL)#>:NO];

	[textField becomeFirstResponder];
	
	if (sphBubbledata.count>2) {
        [self performSelector:@selector(scrollTableview) withObject:nil afterDelay:0.0];
    }
    
    CGRect msgframes=self.msgInPutView.frame;
    //CGRect btnframes=self.sendChatBtn.frame;
    CGRect tableviewframe=self.sphChatTable.frame;
    msgframes.origin.y=self.view.frame.size.height-760; // -260
    tableviewframe.size.height-=0; //-=200
    
    [UIView animateWithDuration:0.25 animations:^{
        self.msgInPutView.frame=msgframes;
        self.sphChatTable.frame=tableviewframe;
    }];
	
   
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
	CGRect msgframes=self.msgInPutView.frame;
    //CGRect btnframes=self.sendChatBtn.frame;
    CGRect tableviewframe=self.sphChatTable.frame;
    
    msgframes.origin.y=self.view.frame.size.height-570; //-50
    tableviewframe.size.height+=200;
    self.sphChatTable.frame=tableviewframe;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.msgInPutView.frame=msgframes;
    }];
}

//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//
//	return YES;
//}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
//	[textField resignFirstResponder];

    [self.view endEditing:YES];
    return YES;
}


/////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////******* COLLECTION VIEW DELEGATE METHODS           **************/////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    SPH_PARAM_List *feed_data=[[SPH_PARAM_List alloc]init];
    feed_data=[sphBubbledata objectAtIndex:indexPath.row];
    
    if ([feed_data.chat_media_type isEqualToString:kSTextByme]||[feed_data.chat_media_type isEqualToString:kSTextByOther])
    {
        
        NSStringDrawingContext *ctx = [NSStringDrawingContext new];
        NSAttributedString *aString = [[NSAttributedString alloc] initWithString:feed_data.chat_message];
        UITextView *calculationView = [[UITextView alloc] init];
        [calculationView setAttributedText:aString];
        CGRect textRect = [calculationView.text boundingRectWithSize: CGSizeMake(TWO_THIRDS_OF_PORTRAIT_WIDTH, 10000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:calculationView.font} context:ctx];
        
        return CGSizeMake(306,textRect.size.height+40);
    }
    
    
    return CGSizeMake(306, 90);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return sphBubbledata.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
     SPHCollectionViewcell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.layer.shouldRasterize = YES;
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    dispatch_async(dispatch_get_main_queue(), ^
    {
        for (UIView *v in [cell.contentView subviews])
            [v removeFromSuperview];
        
        if ([self.sphChatTable.indexPathsForVisibleItems containsObject:indexPath])
        {
            [cell setFeedData:(SPH_PARAM_List*)[sphBubbledata objectAtIndex:indexPath.row] andFrendImage:data];
        }
    });
    return cell;
}


/////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////******* COLLECTION VIEW DELEGATE ENDS     **************/////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

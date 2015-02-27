//
//  PAWSendMessagesUITableViewController.m
//  IWontToHelp
//
//  Created by Mac on 2/17/15.
//  Copyright (c) 2015 Parse Inc. All rights reserved.
//
#import "PAWConstants.h"
#import "PAWSendMessagesUITableViewController.h"

@interface PAWSendMessagesUITableViewController ()

@end

@implementation PAWSendMessagesUITableViewController
NSMutableArray *blogPostArray;
NSMutableArray *pfObjectsArray;
CGFloat countHe;
CGFloat countHeCounter;


NSInteger count;
NSMutableArray *arrayObjects;
@synthesize colorsTable;
UIRefreshControl *refreshControl;
NSInteger count = 0;
BOOL checkScrol = YES;
NSInteger heiRowPluss;
BOOL check = YES;
PFObject *myObject;
PFUser *currentUser;
- (instancetype)initWithPFObject:(PFObject *)object{
	myObject = object;
	PFUser *currentUser = [PFUser currentUser];

//	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aMethod:) name:kHMnotificatioNewMaasage object:nil];

	//	CGRect msgframes=self.tableView.frame;
	//
	//	msgframes.origin.y=self.view.frame.size.height-760; // -260
	
	//	tableView.size.height-=0; //-=200
	
	//	[UIView animateWithDuration:0.25 animations:^{
	//		self.msgInPutView.frame=msgframes;
	
//	UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//	[button addTarget:self
//			   action:@selector(aMethod:)
//	 forControlEvents:UIControlEventTouchUpInside];
//	[button setTitle:@"Show View" forState:UIControlStateNormal];
//	button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
//	
//	[self.view addSubview:button];
	
	
//	blogPostArray =  [[NSMutableArray alloc] initWithArray:[object objectForKey:@"messages"]];
	
	blogPostArray =  [[NSMutableArray alloc] initWithArray:[object objectForKey:@"messages"]];

//	NSMutableArray *pfObjectsArray = [[NSMutableArray alloc]init];

	arrayObjects = [[NSMutableArray alloc]init];
	for(PFObject *object in blogPostArray){
		
		[arrayObjects addObject:object.objectId];
		
	}
	
	NSLog(@"queryForTable blogPostArray%@", blogPostArray);
	
//	self = [super initWithStyle:style];
	if (self) {
//		self.textKey = @"text";
//		self.tableView.rowHeight = 55;
//		self.pullToRefreshEnabled = YES;
//		self.paginationEnabled = YES;
//		//		self.isLoading = YES;
//		self.objectsPerPage = 24;
	
	}
	return self;
}

-(void)downloadForParse{

	NSString *objectId = myObject.objectId;
	
	PFQuery *query = [PFQuery queryWithClassName:@"Comment"];
	[query whereKey:@"objectId" equalTo:objectId];
	
	[query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
		blogPostArray = [object objectForKey:@"messages"];
		
		arrayObjects = [[NSMutableArray alloc]init];
		
		for(PFObject *object in blogPostArray){
			[arrayObjects addObject:object.objectId];
		}
		
		[self retrieveFromParse];
//		[self viewDidAppear:NO];
	}];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.colorsTable.separatorColor = [UIColor clearColor];

	refreshControl = [[UIRefreshControl alloc] init];
	refreshControl.backgroundColor = [UIColor clearColor];
	refreshControl.tintColor = [UIColor lightGrayColor];
	[refreshControl addTarget:self
							action:@selector(getLatestLoans)
				  forControlEvents:UIControlEventValueChanged];
	
	[self.colorsTable addSubview:refreshControl];
	
	[self performSelector:@selector(retrieveFromParse)];
  }

-(void)getLatestLoans{
	
	if(count == 0){
	 count = 12;
	}
	PFQuery *mainQuery = [PFQuery queryWithClassName:@"BlogPost"];
	
	NSArray *arrayObjects2 =[[NSArray alloc]initWithArray:arrayObjects];
	
	[mainQuery whereKey:@"objectId" containedIn:arrayObjects2];
	
	[mainQuery orderByAscending:@"createdAt"];
	
	
	
	[mainQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
		
		if(objects){
			pfObjectsArray =[[NSMutableArray alloc] init];
			
			NSMutableArray *mar =[[NSMutableArray alloc] init];
			for(PFObject * object in objects){
				[mar addObject: object];
				
			}
			
			NSMutableArray *ar =[[NSMutableArray alloc] init];
			NSInteger inte= mar.count;
			if(count> inte){
				for(int i = 0; i <inte; i++){
					[ar addObject:[mar lastObject]];
					[mar removeLastObject];
					
				}
				
				for(int i = 0; i <inte; i++){
					
					[pfObjectsArray addObject:[ar lastObject]];
					[ar removeLastObject];
				}
				
				
			}else{
			for(int i = 0; i <count; i++){
				[ar addObject:[mar lastObject]];
				[mar removeLastObject];
				
			}
			
			for(int i = 0; i <count; i++){
				
				[pfObjectsArray addObject:[ar lastObject]];
				[ar removeLastObject];
			}
			
			}
			count += 6;
			[colorsTable reloadData];
		}
	}];
	[refreshControl endRefreshing];
}

-(void)dealloc{
	count = 0;
}
- (void) retrieveFromParse {
	
	PFQuery *mainQuery = [PFQuery queryWithClassName:@"BlogPost"];
	
	NSArray *arrayObjects2 =[[NSArray alloc]initWithArray:arrayObjects];
	
	[mainQuery whereKey:@"objectId" containedIn:arrayObjects2];
	
	[mainQuery orderByAscending:@"createdAt"];
	
	
	
	[mainQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
		
		if(objects){
		pfObjectsArray =[[NSMutableArray alloc] init];
		
		NSMutableArray *mar =[[NSMutableArray alloc] init];
		for(PFObject * object in objects){
			[mar addObject: object];
			
		}
		
			NSMutableArray *ar =[[NSMutableArray alloc] init];
			NSInteger inte= mar.count;
			NSInteger mainCount = 9;
			if(mainCount> inte){
				for(int i = 0; i <inte; i++){
					[ar addObject:[mar lastObject]];
					[mar removeLastObject];
					
				}
				
				for(int i = 0; i <inte; i++){
					
					[pfObjectsArray addObject:[ar lastObject]];
					[ar removeLastObject];
				}
				
				
			}else{
				for(int i = 0; i <mainCount; i++){
					[ar addObject:[mar lastObject]];
					[mar removeLastObject];
					
				}
				
				for(int i = 0; i <mainCount; i++){
					
					[pfObjectsArray addObject:[ar lastObject]];
					[ar removeLastObject];
				}
				
			}
		}
		[colorsTable reloadData];

	}];
	
}

- (void) viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	if (self.colorsTable.contentSize.height > self.colorsTable.frame.size.height)
	{
		CGPoint offset = CGPointMake(0, self.colorsTable.contentSize.height  - self.colorsTable.frame.size.height);
		[self.colorsTable setContentOffset:offset animated:YES];
	}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
	
}

#pragma mark - Table view data source
- (void)endUpdates{
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//
//	if (self.colorsTable.contentSize.height > self.colorsTable.frame.size.height)
//	{
//	
////		CGPoint offset = CGPointMake(0, self.colorsTable.contentSize.height  - self.colorsTable.frame.size.height);
////		[self.colorsTable setContentOffset:offset animated:YES];
//	}
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return pfObjectsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//	[self viewDidAppear:YES];
	return countHe;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *identifier = @"Cell";
	
	UITableViewCell  *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
	
		if(cell == nil){
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
		}
	

	PFObject *object = [pfObjectsArray objectAtIndex:indexPath.row];
	
	
	NSString *user = [object  objectForKey:@"userId"];
	
	PFUser *userC = [PFUser currentUser];

	NSString *currentU =userC.objectId;
	
	
	BOOL check = [currentU isEqualToString:user];
	if(check){
		//	cell.textLabel.text =[object  objectForKey:@"message"];
		UILabel * nameLabel = [[UILabel alloc]init];
		
		nameLabel.text = [object  objectForKey:@"userName"];
		nameLabel.font = [UIFont fontWithName:@"AlNile-Bold" size:14];
		
		[nameLabel setFrame:CGRectMake(60, 0, 180, 20)];
		
		
		
		UILabel * textMessageLabel = [[UILabel alloc]init];
		
		textMessageLabel.text = [object  objectForKey:@"message"];
		textMessageLabel.font = [UIFont fontWithName:HMDamascusLight size:15];
		
		[textMessageLabel setFrame:CGRectMake(60, 20, 180, 20)];
		
		CGRect currentFrame = textMessageLabel.frame;
		CGSize max = CGSizeMake(textMessageLabel.frame.size.width, 180);
		CGSize expected = [[object  objectForKey:@"message"] sizeWithFont:textMessageLabel.font constrainedToSize:max lineBreakMode:textMessageLabel.lineBreakMode];
		currentFrame.size.height = expected.height;
		
		textMessageLabel.frame = currentFrame;
		
		
		
		if((currentFrame.size.height) < 21){
			countHe = currentFrame.size.height + 50;
		}else {
			countHe = currentFrame.size.height + 25;
		}
		
		NSInteger ingh = [pfObjectsArray count];
		
		if(ingh -1 == indexPath.row){
			[self viewDidAppear:YES];
		}
		
		textMessageLabel.text = [object  objectForKey:@"message"];
		
		
		textMessageLabel.lineBreakMode = NSLineBreakByWordWrapping;
		textMessageLabel.numberOfLines = 0;
		
		
		UILabel * TimeMessageLabel = [[UILabel alloc]init];
		
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setDateFormat:@"dd,MMM"];
		[formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"]];
		
		
		TimeMessageLabel.text = [formatter stringFromDate:object.createdAt];
		TimeMessageLabel.font = [UIFont fontWithName:HMDamascusLight size:10];
		
		[TimeMessageLabel setFrame:CGRectMake(265, 25, 80, 20)];
		
		
		
		UILabel * TimeMessageLabelyyyy = [[UILabel alloc]init];
		
		NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
		[formatter setDateFormat:@"HH:mm"];
		[formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"]];
		
		
		TimeMessageLabelyyyy.text = [formatter stringFromDate:object.createdAt];
		TimeMessageLabelyyyy.font = [UIFont fontWithName:HMDamascusLight size:13];
		
		[TimeMessageLabelyyyy setFrame:CGRectMake(265, 5, 80, 20)];
		
		
		
		UIImageView *imageView = [[UIImageView alloc] init];
		
		PFFile *imageData = [object objectForKey:@"smallavatar"];
		
		NSData *data = [imageData getData];
		imageView.image = [UIImage imageWithData:data];
		
		[imageView setFrame:CGRectMake(15, 5, 38, 38)];
		CALayer * ourLayer = [imageView layer];			// Будем округлять UIImageView
		ourLayer.cornerRadius =  19.0f;           // Polovina korotkoi storoni, Задаем радиус для округления.
		ourLayer.masksToBounds = YES;           // Чтобы за овальной границей в углах ничего не рисовалось
		ourLayer.borderWidth = 0.5f;
		
		
		//	cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cellbackgraund"]];
		
		
		[cell addSubview:TimeMessageLabelyyyy];
		[cell addSubview:textMessageLabel];
		[cell addSubview:imageView];
		[cell addSubview:TimeMessageLabel];
		[cell addSubview:nameLabel];

		
		//	NSInteger intpfObjectsArray = pfObjectsArray.count;
		//
		//	if(indexPath.row == intpfObjectsArray){
		//		
		//		if(check){
		//			[self viewDidAppear:NO];
		//		}
		//	}
		//

		
	}else
		{
	
	UILabel * nameLabel = [[UILabel alloc]init];
			
	nameLabel.text = [object  objectForKey:@"userName"];
	nameLabel.font = [UIFont fontWithName:@"AlNile-Bold" size:14];
			
	[nameLabel setFrame:CGRectMake(60, 0, 180, 20)];
	
//	cell.textLabel.text =[object  objectForKey:@"message"];
	
	UILabel * textMessageLabel = [[UILabel alloc]init];
	
	textMessageLabel.text = [object  objectForKey:@"message"];
	textMessageLabel.font = [UIFont fontWithName:HMDamascusLight size:15];
	
	[textMessageLabel setFrame:CGRectMake(60, 20, 180, 20)];
			
//			UIImage *image = [UIImage imageNamed: @"ImageBubble"];
//			
//			[self imageWithView:]
			
//			_____scile image
//			UIImage *img = [UIImage imageNamed:@"ImageBubble~iphone"];
//			CGSize imgSize = textMessageLabel.frame.size;
//			
//			UIGraphicsBeginImageContext( imgSize );
//			[img drawInRect:CGRectMake(0,0,imgSize.width,imgSize.height)];
//			UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
//			UIGraphicsEndImageContext();
			
			
			
//	[textMessageLabel setBackgroundColor:[UIColor lightGrayColor]];
	 
			
	CGRect currentFrame = textMessageLabel.frame;
	CGSize max = CGSizeMake(textMessageLabel.frame.size.width, 180);
	CGSize expected = [[object  objectForKey:@"message"] sizeWithFont:textMessageLabel.font constrainedToSize:max lineBreakMode:textMessageLabel.lineBreakMode];
	currentFrame.size.height = expected.height;
	
	textMessageLabel.frame = currentFrame;
	
	
	
	if((currentFrame.size.height) < 21){
		countHe = currentFrame.size.height + 50;
	}else {
		countHe = currentFrame.size.height + 25;
	}
//	countHeCounter = countHeCounter + countHe;

	NSInteger ingh = [pfObjectsArray count];
	
	if(ingh -1 == indexPath.row){
		[self viewDidAppear:YES];
	}
	
	textMessageLabel.text = [object  objectForKey:@"message"];
	
	
	textMessageLabel.lineBreakMode = NSLineBreakByWordWrapping;
	textMessageLabel.numberOfLines = 0;
	
	//	cell.textLabel.text =[object  objectForKey:@"message"];
	
	
	//	if ((currentFrame.size.height)>72) {
	//		self.tableView.rowHeight = currentFrame.size.height;
	//
	//	}
	
	//	[cell setFrame:CGRectMake(0, 0, 170, currentFrame.size.height)];
	
	UILabel * TimeMessageLabel = [[UILabel alloc]init];
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"dd,MMM"];
	[formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"]];
	
	
	TimeMessageLabel.text = [formatter stringFromDate:object.createdAt];
	TimeMessageLabel.font = [UIFont fontWithName:HMDamascusLight size:10];
	
	[TimeMessageLabel setFrame:CGRectMake(265, 25, 80, 20)];
	
	
	
	UILabel * TimeMessageLabelyyyy = [[UILabel alloc]init];
	
	NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"HH:mm"];
	[formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"]];
	
	
	TimeMessageLabelyyyy.text = [formatter stringFromDate:object.createdAt];
	TimeMessageLabelyyyy.font = [UIFont fontWithName:HMDamascusLight size:13];
	
	[TimeMessageLabelyyyy setFrame:CGRectMake(265, 5, 80, 20)];
	
	
	
	UIImageView *imageView = [[UIImageView alloc] init];
	
	PFFile *imageData = [object objectForKey:@"smallavatar"];
	
	NSData *data = [imageData getData];
	imageView.image = [UIImage imageWithData:data];
	
	[imageView setFrame:CGRectMake(15, 5, 38, 38)];
	CALayer * ourLayer = [imageView layer];			// Будем округлять UIImageView
	ourLayer.cornerRadius =  19.0f;           // Polovina korotkoi storoni, Задаем радиус для округления.
	ourLayer.masksToBounds = YES;           // Чтобы за овальной границей в углах ничего не рисовалось
	ourLayer.borderWidth = 0.5f;
	
	
	//	cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cellbackgraund"]];
	
	
	[cell addSubview:TimeMessageLabelyyyy];
	[cell addSubview:textMessageLabel];
	[cell addSubview:imageView];
	[cell addSubview:TimeMessageLabel];
	[cell addSubview:nameLabel];

//	cell.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"cellbackgraund"]];

//	NSInteger intpfObjectsArray = pfObjectsArray.count;
//	
//	if(indexPath.row == intpfObjectsArray){
//		
//		if(check){
//			[self viewDidAppear:NO];
//		}
//	}
//
		
	}
	return cell;
		
}

//- (UIImage *) imageWithView:(UIView *)view
//{
//	UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
//	[view.layer renderInContext:UIGraphicsGetCurrentContext()];
//	
//	UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
//	
//	UIGraphicsEndImageContext();
//	
//	return img;
//}

#pragma mark - textFiled

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	NSLog(@"textFieldDidBeginEditing");
	CGPoint offset = CGPointMake(0, self.scrollView.contentSize.height + 220);
	[self.scrollView setContentOffset:offset animated:YES];

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	textField.text = nil;
	return NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	NSLog(@"textFieldDidBeginEditing");
	CGPoint offset = CGPointMake(0, self.scrollView.contentSize.height);
	[self.scrollView setContentOffset:offset animated:YES];
	
}

#pragma mark - IBAction

- (IBAction)send:(id)sender {
	
	NSString *trimmed = [self.taxtFiled.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	
	NSUInteger len = [trimmed lengthOfBytesUsingEncoding: NSUTF8StringEncoding];

	if(len > 0){
	// create blogpost post
	
	PFObject *blogpost = [PFObject objectWithClassName:@"BlogPost"];
	
	[blogpost setObject:trimmed forKey:@"message"];
		
		[blogpost setObject:[PFUser currentUser].objectId forKey:@"userId"];

		[blogpost setObject:[PFUser currentUser][@"firstname"] forKey:@"userName"];

	[blogpost setObject:[PFUser currentUser] forKey:@"user"];
	
	PFUser *user = [PFUser currentUser];
	
	PFFile *imageData =	[user objectForKeyedSubscript:@"smallavatar"];
	
	//	NSData *data = [imageData getData];
	
	[blogpost setObject:imageData forKey:@"smallavatar"];

	//record  blogpost post in array
	
	//	lastobj = blogpost;
	
	
	NSMutableArray * mArrayblogPost = [[NSMutableArray alloc] initWithArray:blogPostArray];
	
	[mArrayblogPost addObject:blogpost];
	
	
	
	// save array in background
	//	PFObject *objectSaveArray = m;
	
	myObject[@"messages"] = mArrayblogPost;
	
	[myObject save];
	
	[self downloadForParse];
	}
	
	[self.colorsTable clearsContextBeforeDrawing];
	self.taxtFiled.text = nil;

}



@end

//
//  PAWSendMessages.m
//  IWontToHelp
//
//  Created by Mac on 2/15/15.
//  Copyright (c) 2015 Parse Inc. All rights reserved.
//
#import "PAWConstants.h"
#import "PAWSendMessages.h"
@interface PAWSendMessages ()
@property (nonatomic, strong) PFObject *MyObject;

@end
@implementation PAWSendMessages

@synthesize marray;

NSData *data;

NSMutableArray *blogPostArray;
NSMutableArray *blogPostArray2;
PFObject * lastobj;
NSMutableArray *arrayObjects;
NSDate *createdAt;

CGFloat countHe;

BOOL check;


- (id)initWithPFObject:(PFObject *)object WithStyle:(UITableViewStyle)style selfArray:(BOOL)check{

//	CGRect msgframes=self.tableView.frame;
//	
//	msgframes.origin.y=self.view.frame.size.height-760; // -260
	
//	tableView.size.height-=0; //-=200
	
//	[UIView animateWithDuration:0.25 animations:^{
//		self.msgInPutView.frame=msgframes;
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[button addTarget:self
			   action:@selector(aMethod:)
	 forControlEvents:UIControlEventTouchUpInside];
	[button setTitle:@"Show View" forState:UIControlStateNormal];
	button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
		
	[self.view addSubview:button];

	
		blogPostArray =  [[NSMutableArray alloc] initWithArray:[object objectForKey:@"messages"]];
	

	
	self.MyObject = object;
	
	
	self = [super initWithStyle:style];
	if (self) {
		self.textKey = @"text";
		self.tableView.rowHeight = 55;
		self.pullToRefreshEnabled = YES;
		self.paginationEnabled = YES;
//		self.isLoading = YES;
		self.objectsPerPage = 24;
	}
	return self;
}


- (void)objectsWillLoad  {
	[super objectsWillLoad];

//	[self findDuplicates2];
	
	
	
}
-(void)findDuplicates2
{
	PFQuery *mainQuery3 = [PFQuery queryWithClassName:@"Comment"];
	
	[mainQuery3 whereKey:@"objectId" equalTo:self.MyObject.objectId];

	
		[mainQuery3 getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
			NSArray *array 	= [[NSArray alloc] initWithArray:[object  objectForKey:@"messages"]];
			blogPostArray = [array copy];
			
		}];
		
		
		
		
	
	
	//			[self loadObjects];
}
-(void)findDuplicates
{
	PFQuery *mainQuery2 = [PFQuery queryWithClassName:@"Comment"];
	
	[mainQuery2 whereKey:@"objectId" equalTo:self.MyObject.objectId];
	
	PFObject *object = [mainQuery2 getFirstObject];
		
	
		NSArray *array 	= [[NSArray alloc] initWithArray:[object  objectForKey:@"messages"]];
		blogPostArray = [array copy];
	
		
//		self.MyObject = object;
	
	
//			[self loadObjects];
}

-(PFQuery *)queryForTable {
	
	arrayObjects =[[NSMutableArray alloc]init] ;
	
//	NSInteger inte = [arrayObjects count];
	
	NSMutableArray *newblogPostArray = [[NSMutableArray alloc]init];
	
//	for (int i = 0; i < 10; i++) {
//		PFObject *lastObject = [blogPostArray lastObject];
//		[blogPostArray removeLastObject];
//		[newblogPostArray addObject:lastObject];
//	}
	
	
	for(PFObject *object in blogPostArray){
		
		[arrayObjects addObject:object.objectId];
		
		
	}
	
//	if (lastobj) {
//		[arrayObjects addObject:lastobj];
//	}
	
	//[self findDuplicates];
 
 
	
	
	
	NSLog(@"queryForTable blogPostArray%@", blogPostArray);


	PFQuery *mainQuery = [PFQuery queryWithClassName:@"BlogPost"];
	
	NSArray *arrayObjects2 =[[NSArray alloc]initWithArray:arrayObjects];
	
	[mainQuery whereKey:@"objectId" containedIn:arrayObjects2];

	
	
 [mainQuery orderByAscending:@"createdAt"];
	
	
	
//	[mainQuery setLimit:5];
//	[mainQuery whereKey:@"createdAt" lessThanOrEqualTo:createdAtDate]
	
//	[mainQuery setSkip: 5];
// mainQuery.cachePolicy = kPFCachePolicyCacheThenNetwork;
//	if ([self.objects count] == 0) {
//		query.cachePolicy = kPFCachePolicyCacheThenNetwork;
//	}
	[self viewDidAppear: YES];

	return   mainQuery;


}
- (void)beginUpdates{


	NSLog(@"beginUpdates" );
}


#pragma mark -
#pragma mark UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	
////	CGFloat heightfloat = 100.0f;
//	
////	CGRect currentFrame = textMessageLabel.frame;
//	CGSize max = CGSizeMake(100, 170);
//	
//	PFObject *object = [self.objects objectAtIndex:indexPath.row];
//	
//	CGSize expected = [[object  objectForKey:@"message"] sizeWithFont:[UIFont fontWithName:HMDamascusLight size:15] constrainedToSize:max lineBreakMode:0];
////	currentFrame.size.height = expected.height;
//	

	return countHe;
}


- (PFTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object{
	
	
	
	static NSString *identifier = @"Cell";
	
//	PFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	PFTableViewCell  *cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];

	
	
	//	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	//	[formatter setDateFormat:@"HH:mm"];
	//	[formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"]];
	
	
	
	
	
//	if(cell == nil){
//		cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//		
//	}
	
	
	UILabel * textMessageLabel = [[UILabel alloc]init];
	
	textMessageLabel.text = [object  objectForKey:@"message"];
	textMessageLabel.font = [UIFont fontWithName:HMDamascusLight size:15];
	
	[textMessageLabel setFrame:CGRectMake(60, 5, 180, 20)];
	
	CGRect currentFrame = textMessageLabel.frame;
	CGSize max = CGSizeMake(textMessageLabel.frame.size.width, 180);
	CGSize expected = [[object  objectForKey:@"message"] sizeWithFont:textMessageLabel.font constrainedToSize:max lineBreakMode:textMessageLabel.lineBreakMode];
	currentFrame.size.height = expected.height;
	
	textMessageLabel.frame = currentFrame;
	
	if((currentFrame.size.height) < 21){
		countHe = currentFrame.size.height + 30;
	}else {
		countHe = currentFrame.size.height + 5;
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

	

	
	return cell;
}

- (void) viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	if (self.tableView.contentSize.height > self.tableView.frame.size.height)
	{
		CGPoint offset = CGPointMake(0, self.tableView.contentSize.height -     self.tableView.frame.size.height);
		[self.tableView setContentOffset:offset animated:YES];
	}
}

- (void)aMethod:(UIButton*)sender {
	
	// create blogpost post
	
	PFObject *blogpost = [PFObject objectWithClassName:@"BlogPost"];
	
	[blogpost setObject:@"Fucking my text!=)" forKey:@"message"];
	
	[blogpost setObject:[PFUser currentUser] forKey:@"user"];
	
	PFUser *user = [PFUser currentUser];
	
	PFFile *imageData =	[user objectForKeyedSubscript:@"smallavatar"];
	
	//	NSData *data = [imageData getData];
	
	[blogpost setObject:imageData forKey:@"smallavatar"];
	//record  blogpost post in array
	
	lastobj = blogpost;
	
	

	
	
	
	
	NSMutableArray * mArrayblogPost = [[NSMutableArray alloc] initWithArray:blogPostArray];
	
	[mArrayblogPost addObject:lastobj];

	

	// save array in background
	PFObject *objectSaveArray = self.MyObject;
	
	objectSaveArray[@"messages"] = mArrayblogPost;
	
	[objectSaveArray save];
	
	
	[self initWithPFObject:self.MyObject WithStyle:UITableViewStylePlain selfArray:NO];
	

	[self loadObjects];


}
@end

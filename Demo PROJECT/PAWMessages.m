//
//  PAWMessages.m
//  IWontToHelp
//
//  Created by Mac on 2/9/15.
//  Copyright (c) 2015 Parse Inc. All rights reserved.
//
#import "SPHViewController.h"
#import "PAWMessages.h"
#import "PAWConstants.h"
#import "PAWSendMessages.h"
#import "PAWSendMessagesUITableViewController.h"
@interface PAWMessages()
//@property (nonatomic, copy) NSMutableArray *array;

@end

@implementation PAWMessages


-(id)initWithStyle:(UITableViewStyle)style{
	self = [super initWithStyle:style];
	if(self){
//		self.pullToRefreshEnabled = YES;
//		self.paginationEnabled = NO;
//		self.objectsPerPage = 25;
		self.title = @"Мои диалоги";
	}
	return  self;
	
}
-(void)rankNotification:(NSNotification*) notification{
	[self loadObjects];
}

#pragma mark -
#pragma mark PFQueryTableViewController

-(PFQuery *)queryForTable {
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rankNotification:) name:kHMnotificatioNewMaasage object:nil]; // dedload deleit notification

	PFQuery *query = [PFQuery queryWithClassName:@"Comment"];
	[query whereKey:@"author" equalTo:[PFUser currentUser]];
	
	PFQuery *query2 = [PFQuery queryWithClassName:@"Comment"];
	[query2 whereKey:@"frends" equalTo:[PFUser currentUser]];
	
	PFQuery *mainQuery = [PFQuery orQueryWithSubqueries:@[query,query2]];
	
//	if([self.objects count] ==0){
//		mainQuery.cachePolicy = kPFCachePolicyCacheThenNetwork;
//	}
	
	[mainQuery orderByAscending:@"createdAt"];
	
	self.tableView.rowHeight = 55;
	self.tableView.separatorColor = [UIColor clearColor];

	return  mainQuery;
}
- (void)objectsDidLoad:(NSError *)error {
	[super objectsDidLoad:error];
	
}
#pragma mark -
#pragma mark UITableViewDataSource


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object{
	NSMutableArray *marray = [[NSMutableArray alloc]init] ;
	static NSString *identifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

	if(cell == nil){
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
		
		UILabel * lastTimeMessageLabel = [[UILabel alloc]init];
		
		//	UILabel * textLabel = [[UILabel alloc]init];
		//	NSString *text =[object objectForKey:@"message"];
		//
		//	textLabel.text = text;
		//	textLabel.font = [UIFont fontWithName:HMDamascusLight size:12];
		//	[textLabel setFrame:CGRectMake(80, 2, 100, 20)];
		
		
		
		UILabel * updateLabel = [[UILabel alloc]init];
		
		//NSDate *date = [NSDate date];
		
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setDateFormat:@"HH:mm"];
		[formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"]];
		
		updateLabel.font = [UIFont fontWithName:HMDamascusLight size:12];
		[updateLabel setFrame:CGRectMake(270, 20, 100, 20)];
		
		//	cell.textLabel.text =[object objectForKey:@"message"];
		
		
		
		//[marray addObject:[object objectForKey:@"message"]];
		NSArray *array = [object objectForKey:@"messages"];
		
		NSInteger integer = [array count];
		//	NSLog(@"integer :%d", indexPath.row);
		//	if(integer == indexPath.row)
		//	{
		
		//	PFObject * objectArray = [array objectAtIndex:integer -1];
		PFObject * objectArray = [array lastObject];
		
		
		
		NSLog(@"objectArray :%@", objectArray);
		
		//	for(PFObject *object in array){
		NSString *objectId = objectArray.objectId;
		
		UIImageView *imageFrendView = [[UIImageView alloc] init];
		
		PFQuery *query = [PFQuery queryWithClassName:@"BlogPost"];
		[query whereKey:@"objectId" equalTo:objectId];
		
		[query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
			//[marray addObject:[object objectForKey:@"message"]];
			NSDate *createdAt = object.createdAt;
			
			//NSInteger inte = [marray count];
			
			PFFile *imageData = [object objectForKey:@"smallavatar"];
			NSData *data = [imageData getData];
			imageFrendView.image = [UIImage imageWithData:data];
			
			[imageFrendView setFrame:CGRectMake(67, 3, 16, 16)];
			CALayer * ourLayer = [imageFrendView layer];			// Будем округлять UIImageView
			ourLayer.cornerRadius =  8.0f;           // Polovina korotkoi storoni, Задаем радиус для округления.
			ourLayer.masksToBounds = YES;           // Чтобы за овальной границей в углах ничего не рисовалось
			ourLayer.borderWidth = 0.0f;
			
			NSString *text;
			if(!text){
				//				 text= [marray objectAtIndex:inte - 1];
				text= [object objectForKey:@"message"];
				
			}
			
			lastTimeMessageLabel.text = text;
			lastTimeMessageLabel.font = [UIFont fontWithName:HMDamascusLight size:15];
			
			[lastTimeMessageLabel setFrame:CGRectMake(70, 20, 180, 20)];
			
			updateLabel.text = [formatter stringFromDate:object.updatedAt];
			
		}];
		//	}
		
		
		NSString *authorNameLabel =[object objectForKey:@"authorname"];
		NSString *frendsNameLabel =[object objectForKey:@"frendname"];
		
		PFUser *user = [PFUser currentUser];
		NSString *currentUserName = user.username;
		NSString *currentFirstname = user[@"firstname"];
		
		UILabel * textNameLabel = [[UILabel alloc]init];
		
		//textNameLabel.text = textNameLabel;
		textNameLabel.font = [UIFont fontWithName:HMDamascusLight size:12];
		textNameLabel.textAlignment = NSTextAlignmentCenter;
		[textNameLabel setFrame:CGRectMake(0, 38, 70, 20)];
		
		BOOL check = [currentFirstname isEqualToString: authorNameLabel];
		BOOL check2 = [currentFirstname isEqualToString: frendsNameLabel];
		
		if (!check) {
			textNameLabel.text = authorNameLabel;
			
		}
		
		if (!check2) {
			textNameLabel.text = frendsNameLabel;
			
		}
		
		//	PFUser *currentUser = [PFUser currentUser];
		//	PFObject *authorname = [object objectForKey:@"author"];
		//	PFUser *frendname = [object objectForKey:@"frends"];
		
		NSString *authorName =[object objectForKey:@"autorUsername"];
		NSString *frendsname =[object objectForKey:@"frendsUsername"];
		
		BOOL check1 =[currentUserName isEqualToString: authorName];
		if(!check1){
			
			//		PFFile *imageData = [object objectForKey:@"smallavatar"];
			UIImageView *imageView = [[UIImageView alloc] init];
			
			PFFile *avatarString = [object objectForKey:@"smallavatar"];
			NSData *data = [avatarString getData];
			imageView.image = [UIImage imageWithData:data];
			[imageView setFrame:CGRectMake(15, 5, 38, 38)];
			
			CALayer * ourLayer = [imageView layer]; // Будем округлять UIImageView
			ourLayer.cornerRadius = 19.0f;           // Polovina korotkoi storoni, Задаем радиус для округления.
			ourLayer.masksToBounds = YES;           // Чтобы за овальной границей в углах ничего не рисовалось
			ourLayer.borderWidth = 0.0f;
			[cell addSubview:imageView];
			
			//		[avatarString getDataInBackgroundWithBlock:^(NSData *data, NSError *error){
			//			if(!error){
			//
			//				[imageView setImage:[UIImage imageWithData:data]];
			//
			//
			//
			//			} if (error)
			//			{
			//				NSLog(@"Failed to save Parse assignment with error: %@", error.localizedDescription);
			//			}
			//		}];
			
		}
		BOOL check3 = [currentUserName isEqualToString: frendsname];
		if(!check3){
			//		UIImageView *imageView = [[UIImageView alloc] init];
			//
			//		PFFile *imageData = [object objectForKey:@"smallavatar"];
			//
			//		NSData *data = [imageData getData];
			//		imageView.image = [UIImage imageWithData:data];
			//
			//		[imageView setFrame:CGRectMake(15, 5, 38, 38)];
			//		CALayer * ourLayer = [imageView layer];			// Будем округлять UIImageView
			//		ourLayer.cornerRadius =  19.0f;           // Polovina korotkoi storoni, Задаем радиус для округления.
			//		ourLayer.masksToBounds = YES;           // Чтобы за овальной границей в углах ничего не рисовалось
			//		ourLayer.borderWidth = 0.5f;
			
			
			UIImageView *imageView = [[UIImageView alloc] init];
			
			PFFile *avatarString = [object objectForKey:@"smallavatarf"];
			NSData *data = [avatarString getData];
			imageView.image = [UIImage imageWithData:data];
			[imageView setFrame:CGRectMake(15, 5, 38, 38)];
			
			CALayer * ourLayer = [imageView layer]; // Будем округлять UIImageView
			ourLayer.cornerRadius = 19.0f;           // Polovina korotkoi storoni, Задаем радиус для округления.
			ourLayer.masksToBounds = YES;           // Чтобы за овальной границей в углах ничего не рисовалось
			ourLayer.borderWidth = 0.0f;
			[cell addSubview:imageView];
			
		}
		
		
		
		
		//cell.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0.05];
		cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cellbackgraund"]];
		
		[cell addSubview:imageFrendView];
		
		[cell addSubview:textNameLabel];
		[cell addSubview:updateLabel];
		[cell addSubview:lastTimeMessageLabel];
		//	[cell addSubview:textLabel];
		

	}
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"didSelectRowAtIndexPath");

	[tableView deselectRowAtIndexPath:indexPath animated:YES];	

	PFObject *object = [self.objects objectAtIndex:indexPath.row];
	
	PAWSendMessagesUITableViewController *viewController = [[PAWSendMessagesUITableViewController alloc] initWithPFObject:object];
//	viewController = [viewController initWithPFObject:object WithStyle:UITableViewStyleGrouped];
	
		[self.navigationController pushViewController:viewController animated:YES];
}

@end

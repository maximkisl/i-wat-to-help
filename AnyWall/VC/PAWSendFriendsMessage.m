//
//  PAWSendFriendsMessage.m
//  IWontToHelp
//
//  Created by Mac on 2/25/15.
//  Copyright (c) 2015 Parse Inc. All rights reserved.
//

#import "PAWSendFriendsMessage.h"
#import "PAWMessages.h"
#import "PAWConstants.h"
@interface PAWSendFriendsMessage ()

@end

@implementation PAWSendFriendsMessage
PFUser* user;
NSMutableArray *blogPostArray;
NSMutableArray *arrayObjects;
NSString* username;
NSString* currentuser;

- (instancetype)initWithPFObject:(PFUser *)object{
	
	user =  object;
	username = user.objectId;
	
	
	PFFile *avatarString = user[@"avatar"];
	[avatarString getDataInBackgroundWithBlock:^(NSData *data, NSError *error){
		if(!error){
			[self.imageView setImage:[UIImage imageWithData:data]];
			CALayer * ourLayer = [self.imageView layer]; // Будем округлять UIImageView
			ourLayer.cornerRadius = 50.0f;           // Polovina korotkoi storoni, Задаем радиус для округления.
			ourLayer.masksToBounds = YES;           // Чтобы за овальной границей в углах ничего не рисовалось
			ourLayer.borderWidth = 0.0f;
			
		} if (error)
		{
			NSLog(@"Failed to save Parse assignment with error: %@", error.localizedDescription);
		}
	}];
	
	PFUser * currentuserPF = [PFUser currentUser];
	currentuser = currentuserPF.objectId;
	
	if (self) {
	}
	return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
	[self.carma setText:user[@"carma"]];
	self.carma.font = [UIFont fontWithName:HMDamascusLight size:17];

	self.username.text = user[@"firstname"];
	self.username.font = [UIFont fontWithName:HMDamascusLight size:17];

	self.lastname.text = user[@"lastname"];
	self.lastname.font = [UIFont fontWithName:HMDamascusLight size:17];

	self.rank.text = user[@"rank"];
	self.rank.font = [UIFont fontWithName:HMDamascusLight size:17];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)send:(id)sender {

	PFQuery *query = [PFQuery queryWithClassName:@"Comment"];
	[query whereKey:@"author" equalTo:[PFUser currentUser]];
	
	PFQuery *query2 = [PFQuery queryWithClassName:@"Comment"];
	[query2 whereKey:@"frends" equalTo:[PFUser currentUser]];
	
	PFQuery *query3 = [PFQuery queryWithClassName:@"Comment"];
	[query3 whereKey:@"author" equalTo:user];
	
	PFQuery *query4 = [PFQuery queryWithClassName:@"Comment"];
	[query4 whereKey:@"frends" equalTo:user];
	
	PFQuery *mainQuery = [PFQuery orQueryWithSubqueries:@[query,query2,query3,query4]];
	[mainQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
		if(objects.count > 0){
				for (PFObject *object in objects) {
				
				  PFUser * userAuthor =	[object objectForKey:@"author"];
				  NSString * userAuthorS = userAuthor.objectId;
				
					
				  PFUser * usetFrends = [object objectForKey:@"frends"];
				  NSString * usetFrendsS = usetFrends.objectId;

					BOOL check1 = [userAuthorS isEqualToString:currentuser];
					BOOL check2 = [usetFrendsS isEqualToString:username];

					BOOL check3 = [userAuthorS isEqualToString:username];
					BOOL check4 = [usetFrendsS isEqualToString:currentuser];

					if(((check1 == YES) && (check2 == YES)) || ((check3 == YES) && (check4 == YES)))
					{
			
				NSString *objectId = object.objectId;
				
				PFQuery *query = [PFQuery queryWithClassName:@"Comment"];
				[query whereKey:@"objectId" equalTo:objectId];
				
				[query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
					blogPostArray = [object objectForKey:@"messages"];
					
					arrayObjects = [[NSMutableArray alloc]init];
					
					for(PFObject *object in blogPostArray){
						[arrayObjects addObject:object.objectId];
					}
					
					
					
					NSString *trimmed = [self.textFiled.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
					
					NSUInteger len = [trimmed lengthOfBytesUsingEncoding: NSUTF8StringEncoding];
					
					if(len > 0){
						// create blogpost post
						
						PFObject *blogpost = [PFObject objectWithClassName:@"BlogPost"];
						
						[blogpost setObject:trimmed forKey:@"message"];
						
						[blogpost setObject:[PFUser currentUser] forKey:@"user"];
						
						[blogpost setObject:[PFUser currentUser].objectId forKey:@"userId"];

						[blogpost setObject:[PFUser currentUser][@"smallavatar"] forKey:@"smallavatar"];
						[blogpost setObject:[PFUser currentUser][@"firstname"] forKey:@"userName"];
						
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
						
//						PFObject* myObject;
						object[@"messages"] = mArrayblogPost;
						
						[object saveEventually:^(BOOL succeeded, NSError *error) {
							if(succeeded){
							PAWMessages *wallViewController = [[PAWMessages alloc] initWithNibName:nil bundle:nil];
							//	wallViewController.delegate = self;
							[self.navigationController setViewControllers:@[ wallViewController ] animated:NO];
							}
						}];
						
						}
					}];
				}
			
					
			}	 }
		
		if(objects.count == 0)
		{
			
			
			PFObject *blogpost = [PFObject objectWithClassName:@"BlogPost"];
			
			[blogpost setObject:self.textFiled.text forKey:@"message"];
			
			[blogpost setObject:[PFUser currentUser] forKey:@"user"];
			
			[blogpost setObject:[PFUser currentUser].objectId forKey:@"userId"];
			
			[blogpost setObject:[PFUser currentUser][@"smallavatar"] forKey:@"smallavatar"];
			[blogpost setObject:[PFUser currentUser][@"firstname"] forKey:@"userName"];
			
			
			PFObject *comment = [PFObject objectWithClassName:@"Comment"];
			
			[comment addUniqueObjectsFromArray:@[blogpost]forKey:@"messages"];
			
			[comment setObject:[PFUser currentUser].username forKey:@"autorUsername"];
			
			[comment setObject:user.username forKey:@"frendsUsername"];
			
			//				NSData *imageData = [[PFUser currentUser][@"smallavatar"] getData];
			comment[@"smallavatar"] = [PFUser currentUser][@"smallavatar"];
			
			//				NSData *imageData2 = [user[@"smallavatar"] getData];
			//
			comment[@"smallavatarf"] = user[@"smallavatar"];
			
			comment[@"authorname"] = [PFUser currentUser][@"firstname"];
			
			comment[@"frendname"] = user[@"firstname"];
			
			[comment setObject:[PFUser currentUser] forKey:@"author"];
			
			[comment setObject:user forKey:@"frends"];
			
			[comment setObject:blogpost forKey:@"post"];
			
			[comment saveEventually:^(BOOL succeeded, NSError *error) {
				if(succeeded){
					PAWMessages *wallViewController = [[PAWMessages alloc] initWithNibName:nil bundle:nil];
					//	wallViewController.delegate = self;
					[self.navigationController setViewControllers:@[ wallViewController ] animated:NO];
				}
			}];
		}

	
	
	}];
	
}
@end

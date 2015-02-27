//
//  PAWFriendsProfile.m
//  IWontToHelp
//
//  Created by Mac on 2/25/15.
//  Copyright (c) 2015 Parse Inc. All rights reserved.
//

#import "PAWFriendsProfile.h"
#import "PAWConstants.h"
#import "PAWMessages.h"
#import "PAWSendFriendsMessage.h"
@interface PAWFriendsProfile ()

@end

@implementation PAWFriendsProfile
NSString *username;
NSString *lastname;
NSString *carma;
NSString *rank;
NSString *country;
NSString *city;
NSString *email;
NSString *phone;
NSString *carmaLabel;
PFUser *user;


- (instancetype)initWithPFObject:(PFObject *)object{

	user =  [object objectForKey:@"user"];
	
	username =user[@"firstname"];
	lastname =user[@"lastname"];
	carma =user[@"carma"];
	rank =user[@"rank"];
	country =user[@"country"];
	city =user[@"city"];
	email =user[@"username"];
	phone =user[@"phone"];

	PFFile *avatarString = user[@"avatar"];
	[avatarString getDataInBackgroundWithBlock:^(NSData *data, NSError *error){
		if(!error){
			[self.imageTestProfil2 setImage:[UIImage imageWithData:data]];
			CALayer * ourLayer = [self.imageTestProfil2 layer]; // Будем округлять UIImageView
			ourLayer.cornerRadius = 50.0f;           // Polovina korotkoi storoni, Задаем радиус для округления.
			ourLayer.masksToBounds = YES;           // Чтобы за овальной границей в углах ничего не рисовалось
			ourLayer.borderWidth = 0.0f;
			
		} if (error)
		{
			NSLog(@"Failed to save Parse assignment with error: %@", error.localizedDescription);
		}
	}];

		
	if (self) {
			}
	return self;
}

- (IBAction)sendToFriend:(id)sender {
//	
//
//	PFQuery *query = [PFQuery queryWithClassName:@"Comment"];
//		[query whereKey:@"author" equalTo:[PFUser currentUser]];
//	
//		PFQuery *query2 = [PFQuery queryWithClassName:@"Comment"];
//		[query2 whereKey:@"frends" equalTo:[PFUser currentUser]];
//	
//		PFQuery *mainQuery = [PFQuery orQueryWithSubqueries:@[query,query2]];
//		[mainQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
//					NSLog(@"findObjectsInBackgroundWithBlock %@", objects);
//			if(objects.count > 0){
//					for (PFObject *object in objects) {
//						NSLog(@"PFUser %@", object);
//					}
//			}else
//					{
//	
//	
//				PFObject *blogpost = [PFObject objectWithClassName:@"BlogPost"];
//	
//				[blogpost setObject:@"message text for user" forKey:@"message"];
//	
//				[blogpost setObject:[PFUser currentUser] forKey:@"user"];
//	
//	
//		
//						
//				PFObject *comment = [PFObject objectWithClassName:@"Comment"];
//	
//				[comment addUniqueObjectsFromArray:@[]forKey:@"messages"];
//	
//				[comment setObject:[PFUser currentUser].username forKey:@"autorname"];
//
//				[comment setObject:user.username forKey:@"frendsname"];
//						
////				NSData *imageData = [[PFUser currentUser][@"smallavatar"] getData];
//				comment[@"smallavatar"] = [PFUser currentUser][@"smallavatar"];
//				
////				NSData *imageData2 = [user[@"smallavatar"] getData];
////
//				comment[@"smallavatarf"] = user[@"smallavatar"];
//						
//				comment[@"authorname"] = [PFUser currentUser][@"firstname"];
//						
//				comment[@"frendname"] = user[@"firstname"];
//
//				[comment setObject:[PFUser currentUser] forKey:@"author"];
//	
//				[comment setObject:user forKey:@"frends"];
//	
////				[comment setObject:blogpost forKey:@"post"];
//	
//				[comment saveEventually];
//				
//			}
//		}];
	
	PAWSendFriendsMessage *wallViewController = [[PAWSendFriendsMessage alloc]initWithPFObject:user];
//	wallViewController.delegate = self;
	[self.navigationController pushViewController:wallViewController animated:YES];
}

- (IBAction)cell:(id)sender {
	
	NSString *phone80 = @"tel:80";
	NSString* resultPhone = [phone80 stringByAppendingString: phone];

	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:resultPhone]]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
	[self.username setText:username];
	self.username.font = [UIFont fontWithName:HMDamascusLight size:17];

	[self.lastname setText:lastname];
	self.lastname.font = [UIFont fontWithName:HMDamascusLight size:17];

	[self.carma setText:carma];
	self.carma.font = [UIFont fontWithName:HMDamascusLight size:17];

	[self.rank setText:rank];
	self.rank.font = [UIFont fontWithName:HMDamascusLight size:17];

	[self.country setText:country];
	self.country.font = [UIFont fontWithName:HMDamascusLight size:17];

	[self.city setText:city];
	self.city.font = [UIFont fontWithName:HMDamascusLight size:17];

	[self.email setText:email];
	self.email.font = [UIFont fontWithName:HMDamascusLight size:17];

	[self.phone setText:phone];
	self.phone.font = [UIFont fontWithName:HMDamascusLight size:17];



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




@end

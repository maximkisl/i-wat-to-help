#import "PAWPost.h"
#import "PAWConstants.h"

@interface PAWPost ()

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *moreinfo;
@property (nonatomic, copy) NSString *complexity;
@property (nonatomic, copy) NSString *rank;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSDate *time;
@property (nonatomic, copy) NSString *locationstring;

@property (nonatomic, copy) NSString *userPointer;


@property (nonatomic, copy) UIImage *avatarImage;


@property (nonatomic, strong) PFObject *object;
@property (nonatomic, strong) PFUser *user;
@property (nonatomic, assign) MKPinAnnotationColor pinColor;

@end

@implementation PAWPost

#pragma mark -
#pragma mark Init

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate
                          andTitle:(NSString *)title
					   andSubtitle:(NSString *)subtitle
					  andRank:(NSString *)rank
						 andAvatar:(UIImage *)avatarImage
							   andText:(NSString *)text
					   andMoreinfo:(NSString *)moreinfo
					  andComplexity:(NSString *)complexity
						  andPhone:(NSString *)phone
						   andTime:(NSDate *)time
						  andLocationString:(NSString *)locationstring

		
						   {
    self = [super init];
    if (self) {
		self.avatarImage = _avatarImage;
		self.coordinate = coordinate;
        self.title = title;
        self.subtitle = subtitle;
		self.rank = rank;
		self.userPointer = _userPointer;
		self.text = text;
		self.moreinfo = moreinfo;
		self.complexity = complexity;
		self.phone = phone;
		self.time = time;
		self.locationstring = locationstring;
    }
	return self;
}

- (instancetype)initWithPFObject:(PFObject *)object {
    [object fetchIfNeeded];

    PFGeoPoint *geoPoint = object[PAWParsePostLocationKey];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude);
    NSString *title = object[PAWParsePostTextKey];
    NSString *subtitle = object[PAWParsePostUserKey][PAWParsePostNameKey] ?: object[PAWParsePostUserKey][PAWParsePostUsernameKey];
	NSString *rank = object[@"countRank"];
	NSString *text = object[@"text"];
	NSString *moreinfo = object[@"moreinfo"];
	NSString *complexity = object[@"complexity"];
	NSString *phone = object[PAWParsePostUserKey][@"phone"];
	NSDate *time = object[@"time"];
	NSString *locationstring = object[@"locationstring"];

	PFFile *avatarString = object[@"smalluseravatar"];
	[avatarString getDataInBackgroundWithBlock:^(NSData *data, NSError *error){
		if(!error){
			NSLog(@"getTmage");
			_avatarImage = [UIImage imageWithData:data];
		} if (error)
		{
			NSLog(@"Failed to save Parse assignment with error: %@", error.localizedDescription);
		}
	}];
	self = [self initWithCoordinate:coordinate andTitle:title andSubtitle:subtitle andRank:rank andAvatar:_avatarImage andText:text andMoreinfo:moreinfo andComplexity:complexity andPhone:phone andTime:time andLocationString:locationstring];
    if (self) {
        self.object = object;
        self.user = object[PAWParsePostUserKey];
		_userPointer = object[PAWParsePostUserKey];;
    }
    return self;
}

#pragma mark -
#pragma mark Equal

- (BOOL)isEqual:(id)other {
    if (![other isKindOfClass:[PAWPost class]]) {
        return NO;
    }

    PAWPost *post = (PAWPost *)other;

    if (post.object && self.object) {
        // We have a PFObject inside the PAWPost, use that instead.
		// У нас есть PFObject внутри PAWPost , использовать его.
        return [post.object.objectId isEqualToString:self.object.objectId];
    }

    // Fallback to properties
	// Возврат к свойствам
    return ([post.title isEqualToString:self.title] &&
            [post.subtitle isEqualToString:self.subtitle] &&
			[post.rank isEqualToString:self.rank] &&
            post.coordinate.latitude == self.coordinate.latitude &&
            post.coordinate.longitude == self.coordinate.longitude);
}

#pragma mark -
#pragma mark Accessors

- (void)setTitleAndSubtitleOutsideDistance:(BOOL)outside {
    if (outside) {
		self.title = kPAWWallCantViewPost;
        self.subtitle = nil;
//		self.rank = nil;
//		self.avatarImage = nil;
//        self.pinColor = MKPinAnnotationColorRed;
    } else {
		self.text = self.object[@"text"];
		self.moreinfo = self.object[@"moreinfo"];
		self.complexity = self.object[@"complexity"];
		self.phone = self.object[PAWParsePostUserKey][@"phone"];
		self.time = self.object[@"time"];
		self.locationstring = self.object[@"locationstring"];

        self.title = self.object[PAWParsePostTextKey];
        self.subtitle = self.object[PAWParsePostUserKey][PAWParsePostNameKey] ?:
        self.object[PAWParsePostUserKey][PAWParsePostUsernameKey];
		
		self.rank = self.object[@"countRank"];

		self.avatarImage = self.object[@"smalluseravatar"];
    }
}

@end

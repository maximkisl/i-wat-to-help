

#ifndef Anywall_PAWConstants_h
#define Anywall_PAWConstants_h

static double PAWFeetToMeters(double feet) {
    return feet * 0.3048;
}

static double PAWMetersToFeet(double meters) {
    return meters * 3.281;
}

static double PAWMetersToKilometers(double meters) {
    return meters / 1000.0;
}
CLLocation * currentLocation;
NSString* countRank;
NSString* category;
NSString* complexity;
UIImage *image;
static double const PAWDefaultFilterDistance = 1000.0;
static double const PAWWallPostMaximumSearchDistance = 100.0; // Value in kilometers
// double  PAWDefaultFilterDistance = 1000.0;
// double  PAWWallPostMaximumSearchDistance = 100.0; // Value in kilometers

static NSUInteger const PAWWallPostsSearchDefaultLimit = 20; // Query limit for pins and tableviewcells

// Parse API key constants:
static NSString * const PAWParsePostsClassName = @"Posts";
static NSString * const PAWParsePostUserKey = @"user";
static NSString * const PAWParsePostUsernameKey = @"username";
static NSString * const PAWParsePostTextKey = @"text";
static NSString * const PAWParsePostLocationKey = @"location";
static NSString * const PAWParsePostNameKey = @"name";

static NSString * const PAWParsePostFirstNameKey = @"firstname";
static NSString * const PAWParsePostLastNameKey = @"lastname";
static NSString * const PAWParsePostPhoneKey = @"phone";
static NSString * const PAWParsePostCityKey = @"city";
static NSString * const PAWParsePostCountryKey = @"country";
static NSString * const PAWParsePostAvatarKey = @"avatar";
static NSString * const PAWParsePostEmailKey = @"email";
static NSString * const PAWParsePostCarmaKey = @"carma";
static NSString * const PAWParsePostRankKey = @"rank";

//fonts

static NSString * const HMDamascusLight = @"AppleSDGothicNeo-Thin";

// NSNotification userInfo keys:
static NSString * const kPAWFilterDistanceKey = @"filterDistance";
static NSString * const kPAWLocationKey = @"location";
static NSString * const kHMLogOut = @"kHMLogOut";
static NSString * const kHMnotificatioNewMaasage = @"kHMnotificatioNewMaasage";

// Notification names:
static NSString * const PAWFilterDistanceDidChangeNotification = @"PAWFilterDistanceDidChangeNotification";
static NSString * const PAWCurrentLocationDidChangeNotification = @"PAWCurrentLocationDidChangeNotification";
static NSString * const PAWPostCreatedNotification = @"PAWPostCreatedNotification";

static NSString * const HMAvatarImageDidChangeNotification = @"HMAvatarImageDidChangeNotification";
static NSString * const HMUserNameDidChangeNotification = @"HMUserNameDidChangeNotification";
static NSString * const HMCountRankDidChangeNotification = @"HMCountRankDidChangeNotification";
static NSString * const HMCategoryDidChangeNotification = @"HMCategoryDidChangeNotification";
static NSString * const HMComplexityDidChangeNotification = @"HMComplexityDidChangeNotification";

static NSString * const HMFirstNameDidChangeNotification = @"HMFirstNameDidChangeNotification";
static NSString * const HMLastNameDidChangeNotification = @"HMLastNameDidChangeNotification";
static NSString * const HMPhoneDidChangeNotification = @"HMPhoneDidChangeNotification";
static NSString * const HMEmailDidChangeNotification = @"HMEmailDidChangeNotification";
static NSString * const HMCityDidChangeNotification = @"HMCityDidChangeNotification";
static NSString * const HMCountryDidChangeNotification = @"HMCountryDidChangeNotification";
static NSString * const HMRankDidChangeNotification = @"HMRankDidChangeNotification";
static NSString * const HMCarmaDidChangeNotification = @"HMCarmaDidChangeNotification";



// UI strings:
static NSString * const kPAWWallCantViewPost = @"Can’t view post! Get closer.";

// NSUserDefaults
static NSString * const PAWUserDefaultsFilterDistanceKey = @"filterDistance";

typedef double PAWLocationAccuracy;

UIImage *curentUserAvatar;
#endif // Anywall_PAWConstants_h

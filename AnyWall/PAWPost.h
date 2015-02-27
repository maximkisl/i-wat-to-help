

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>

@interface PAWPost : NSObject <MKAnnotation, UIAlertViewDelegate>

//@protocol MKAnnotation <NSObject>

// Center latitude and longitude of the annotion view.
// The implementation of this property must be KVO compliant.
@property (nonatomic, assign, readonly) CLLocationCoordinate2D coordinate;

// @optional
// Title and subtitle for use by selection UI.
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *subtitle;

@property (nonatomic, copy, readonly) NSString *text;
@property (nonatomic, copy, readonly) NSString *moreinfo;

@property (nonatomic, copy, readonly) NSString *complexity;
@property (nonatomic, copy, readonly) NSString *rank;
@property (nonatomic, copy, readonly) NSString *phone;
@property (nonatomic, copy, readonly) NSDate *time;
@property (nonatomic, copy, readonly) NSString *locationstring;


@property (nonatomic, copy, readonly) NSString *userPointer;



@property (nonatomic, copy, readonly) UIImage *avatarImage;

// @end

// Other properties:
@property (nonatomic, strong, readonly) PFObject *object;
@property (nonatomic, strong, readonly) PFUser *user;
@property (nonatomic, assign) BOOL animatesDrop;
@property (nonatomic, assign, readonly) MKPinAnnotationColor pinColor;

// Designated initializer.
- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate
                          andTitle:(NSString *)title
					   andSubtitle:(NSString *)subtitle
						 andAvatar:(UIImage *)avatarImage;

- (instancetype)initWithPFObject:(PFObject *)object;


- (void)setTitleAndSubtitleOutsideDistance:(BOOL)outside;

@end

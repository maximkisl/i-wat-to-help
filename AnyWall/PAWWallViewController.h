

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>
#import "AMSlideMenuMainViewController.h"
#import "CustomIOS7AlertView.h"

@class PAWWallViewController;

@protocol PAWWallViewControllerDelegate <NSObject>
- (void)wallViewControllerWantsToPresentSettings:(PAWWallViewController *)controller;
@property (nonatomic, assign) BOOL closeWin;

@end

@class PAWPost;

@interface PAWWallViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, CustomIOS7AlertViewDelegate>

@property (nonatomic, weak) id<PAWWallViewControllerDelegate> delegate;

@property (nonatomic, strong) IBOutlet MKMapView *mapView;
- (IBAction)postButtonSelected:(id)sender;

@end

@protocol PAWWallViewControllerHighlight <NSObject>

- (void)highlightCellForPost:(PAWPost *)post;
- (void)unhighlightCellForPost:(PAWPost *)post;

@end



#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>
#import "AMSlideMenuMainViewController.h"

@class SecondVC;

@protocol SecondVCDelegate <NSObject>

//- (void)wallViewControllerWantsToPresentSettings:(SecondVC *)controller;

@end

@class PAWPost;

@interface SecondVC : AMSlideMenuMainViewController <MKMapViewDelegate, CLLocationManagerDelegate>


@property (nonatomic, weak) id<SecondVCDelegate> delegate;

@property (nonatomic, strong) IBOutlet MKMapView *mapView;

- (IBAction)postButtonSelected:(id)sender;

@end

@protocol PAWWallViewControllerHighlight <NSObject>

- (void)highlightCellForPost:(PAWPost *)post;
- (void)unhighlightCellForPost:(PAWPost *)post;

@end

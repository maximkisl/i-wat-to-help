

#import <Foundation/Foundation.h>

/*!
 Manages config for the entire application.
 Acts as a proxy for PFConfig to get the values for options.
 */
@interface PAWConfigManager : NSObject

+ (instancetype)sharedManager;

- (void)fetchConfigIfNeeded;

- (NSArray *)filterDistanceOptions;
- (NSUInteger)postMaxCharacterCount;

@end

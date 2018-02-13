//
//  Location.h
//  MapTest
//
//  Created by Michael on 26/03/16.
//  Copyright © 2016 Michael. All rights reserved.
//




#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>




typedef NS_ENUM(NSUInteger, LocationStatus) {
    LocationStatusOK = 0,
    LocationStatusNotAllowed,
    LocationStatusError
};

typedef void (^LocationBlock)(LocationStatus status, CLLocationCoordinate2D location);




/**
 * Asks user to allow location service.
 * Returns LocationStatusOK and user's coordinates CLLocationCoordinate2D if success.
 * Returns LocationStatusNotAllowed or LocationStatusError
 * and kCLLocationCoordinate2DInvalid if not.
 */
@interface Location : NSObject

/**
 * Main initializer.
 */
+ (nonnull instancetype)locationWithBlock:(nullable LocationBlock)callback;

/**
 * Stops the process.
 */
- (void)stop;

@end

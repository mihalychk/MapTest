//
//  KMLMatcher.h
//  MapTest
//
//  Created by Michael on 26/03/16.
//  Copyright © 2016 Michael. All rights reserved.
//




#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocation.h>




@class KMLMatch, KMLCountry;




/**
 * Matcher Object, it finds match between user's location and country.
 */
@interface KMLMatcher : NSObject

+ (nullable KMLMatch *)matchCoordinates:(CLLocationCoordinate2D)coordinates inCountries:(nullable NSArray<KMLCountry *> *)countries;

@end
//
//  KMLPolygon.h
//  MapTest
//
//  Created by Michael on 26/03/16.
//  Copyright © 2016 Michael. All rights reserved.
//




#import "KMLCommon.h"




@class KMLLocation, KMLCountry;




/**
 * Country's Polygon Object.
 */
@interface KMLPolygon : NSObject

/**
 * Polygon has coordinates.
 */
@property (nonatomic, nullable, copy) NSArray<KMLLocation *> * locations;

/**
 * Link to Polygon's parent Country.
 */
@property (nonatomic, nullable, weak) KMLCountry * country;

/**
 * Polygon has bounding box.
 */
@property (nonatomic, assign) KMLRect frame;

/**
 * Polygon creation method.
 */
+ (nonnull instancetype)polygon;

/**
 * Parse coordinates from the string.
 */
- (void)setLocationsFromString:(nullable NSString *)string;

@end
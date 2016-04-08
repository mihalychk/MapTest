//
//  KMLCountry.h
//  MapTest
//
//  Created by Michael on 25/03/16.
//  Copyright © 2016 Michael. All rights reserved.
//




#import "KMLCommon.h"




@class KMLPolygon;




/**
 * Country Object.
 */
@interface KMLCountry : NSObject

/**
 * Country has a name.
 */
@property (nonatomic, nullable, strong) NSString * name;

/**
 * Country has polygons.
 */
@property (nonatomic, nullable, strong) NSMutableArray<KMLPolygon *> * polygons;

/**
 * Country creation method.
 */
+ (nonnull instancetype)country;

@end
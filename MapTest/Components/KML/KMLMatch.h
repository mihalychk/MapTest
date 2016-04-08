//
//  KMLMatch.h
//  MapTest
//
//  Created by Michael on 26/03/16.
//  Copyright © 2016 Michael. All rights reserved.
//




#import <Foundation/Foundation.h>




typedef NS_ENUM(NSUInteger, KMLMatchAccuracy) {
    KMLMatchAccuracyUnknown = 0,
    KMLMatchAccuracyRough,
    KMLMatchAccuracyAccurate
};

@class KMLCountry;




/**
 * Match Object, it contains matched Country and accuracy.
 */
@interface KMLMatch : NSObject

/**
 * Accuracy, KMLMatchAccuracyRough means that coordinates in the bounding box
 * but they do not belong to any country's polygon.
 * KMLMatchAccuracyAccurate means that coordinates belongs to the polygon of the country.
 */
@property (nonatomic, assign) KMLMatchAccuracy accuracy;

/**
 * Matching Country.
 */
@property (nonatomic, nullable, strong) KMLCountry * country;

+ (nonnull instancetype)matchWithCountry:(nullable KMLCountry *)country andAccuracy:(KMLMatchAccuracy)accuracy;

@end
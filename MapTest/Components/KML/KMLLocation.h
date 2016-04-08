//
//  KMLLocation.h
//  MapTest
//
//  Created by Michael on 26/03/16.
//  Copyright © 2016 Michael. All rights reserved.
//




#import <Foundation/Foundation.h>




/**
 * Location Object.
 */
@interface KMLLocation : NSObject

/**
 * Location coordinates latitude & longitude.
 */
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;

/**
 * Location creation method.
 */
+ (nonnull instancetype)loactionWithLatitude:(double)latitude andLongitude:(double)longitude;

@end
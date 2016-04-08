//
//  Storage.h
//  MapTest
//
//  Created by Michael on 26/03/16.
//  Copyright © 2016 Michael. All rights reserved.
//




#import <Foundation/Foundation.h>




/**
 * Storage Object, it serializes Objects and saves them to the cache directory.
 * Object has to implement NSCoding protocol.
 */
@interface Storage : NSObject

/**
 * Returns cache file path;
 */
+ (nonnull NSString *)cachePath;

/**
 * Saves object to cache directory.
 */
+ (BOOL)saveObject:(nullable id)object withKey:(nullable NSString *)key;

/**
 * Loads object from the store, returns nil if it was not found.
 */
+ (nullable id)loadObjectWithkey:(nullable NSString *)key;

@end
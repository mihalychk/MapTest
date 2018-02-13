//
//  KML.h
//  MapTest
//
//  Created by Michael on 26/03/16.
//  Copyright © 2016 Michael. All rights reserved.
//




#import <Foundation/Foundation.h>




typedef void(^KMLCallback)(NSError * _Nullable error);

@class KMLCountry;




/**
 * Data Manager.
 */
@interface KML : NSObject

/**
 * Map Data.
 */
@property (nonatomic, nullable, readonly) NSArray<KMLCountry *> * countries;

/**
 * Shared instance of singleton object.
 */
+ (nonnull instancetype)sharedKML;

/**
 * Loads data from Storage, if it is not there parses .kml file.
 * Callback will return in Main Thread.
 */
- (void)loadDataForced:(BOOL)forced callback:(nullable KMLCallback)callback;

@end

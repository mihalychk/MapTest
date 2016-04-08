//
//  KMLParser.h
//  MapTest
//
//  Created by Michael on 25/03/16.
//  Copyright © 2016 Michael. All rights reserved.
//




#import <Foundation/Foundation.h>




@class KMLCountry;
@protocol KMLParserDelegate;




/**
 * Data Parser from .kml file.
 */
@interface KMLParser : NSObject

/**
 * Delegate.
 */
@property (nonatomic, nullable, weak) id<KMLParserDelegate> delegate;

/**
 * Parser's last error.
 */
@property (nonatomic, nullable, readonly) NSError * lastError;

- (nonnull instancetype)initWithFileName:(nullable NSString *)fileName;

- (BOOL)start;
- (void)stop;

@end




@protocol KMLParserDelegate <NSObject>

@optional

- (void)parser:(nonnull KMLParser *)parser didFindCountry:(nonnull KMLCountry *)country;

@end
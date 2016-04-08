//
//  KML.m
//  MapTest
//
//  Created by Michael on 26/03/16.
//  Copyright © 2016 Michael. All rights reserved.
//




#import "KML.h"
#import "KMLParser.h"
#import "Storage.h"
#import "Common.h"




#define kKMLStorageDataKey @"data.dat"




@interface KML () <KMLParserDelegate> {
    __strong NSMutableArray<KMLCountry *> * countries;
    __strong KMLParser * parser;
}

@end




@implementation KML


#pragma mark - init & dealloc

- (instancetype)init {
    if ((self = [super init])) {
        LOG(@"created");
    }
    
    return self;
}


#pragma mark - Private Methods

- (void)_storeData:(KMLCallback)callback {
    LOG(@"storeData: %@", SBOOL([Storage saveObject:countries withKey:kKMLStorageDataKey]));
    
    IN_MAINTHREAD(^{
        LOG(@"loaded");

        if (callback)
            callback(nil);
    });
}


- (void)_parseData:(KMLCallback)callback {
    parser              = [[KMLParser alloc] initWithFileName:[[NSBundle mainBundle] pathForResource:@"world-stripped" ofType:@"kml"]];
    parser.delegate     = self;
    countries           = [NSMutableArray array];

    if (![parser start]) {
        NSError * error     = parser.lastError;

        IN_MAINTHREAD(^{
            if (callback)
                callback(error);
        });
    }
    else
        [self _storeData:callback];

    parser              = nil;
}


- (void)_loadDataForced:(BOOL)forced callback:(KMLCallback)callback {
    countries           = forced ? nil : [Storage loadObjectWithkey:kKMLStorageDataKey];
    
    if (VALID_ARRAY_1(countries))
        IN_MAINTHREAD(^{
            LOG(@"loaded");
            
            if (callback)
                callback(nil);
        });
    
    else
        [self _parseData:callback];
}


#pragma mark - Public Methods

- (void)loadDataForced:(BOOL)forced callback:(KMLCallback)callback {
    LOG(@"loadDataForced: %@", SBOOL(forced));
    
    IN_BACKGROUNG(^{
        [self _loadDataForced:forced callback:callback];
    });
}


#pragma mark - KMLParserDelegate

- (void)parser:(nonnull KMLParser *)parser didFindCountry:(nonnull KMLCountry *)country {
    [countries addObject:country];
}


#pragma mark - Getters & Setters

- (NSArray<KMLCountry *> *)countries {
    return countries;
}


#pragma mark - Singleton

+ (instancetype)sharedKML {
    static KML * sharedKML  = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedKML               = [[KML alloc] init];
    });
    
    return sharedKML;
}


@end
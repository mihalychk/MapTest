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




@interface KML () <KMLParserDelegate>

@property (nonatomic, strong) NSArray<KMLCountry *> * countries;
@property (nonatomic, strong) KMLParser * parser;

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
    LOG(@"storeData: %@", SBOOL([Storage saveObject:self.countries withKey:kKMLStorageDataKey]));

    IN_MAINTHREAD(^{
        LOG(@"loaded");

        if (callback)
            callback(nil);
    });
}


- (void)_parseData:(KMLCallback)callback {
    self.parser = [[KMLParser alloc] initWithFileName:[NSBundle.mainBundle pathForResource:@"world-stripped" ofType:@"kml"]];
    self.parser.delegate = self;
    self.countries = NSArray.array;

    if (![self.parser start]) {
        NSError * error = self.parser.lastError;

        IN_MAINTHREAD(^{
            if (callback)
                callback(error);
        });
    }
    else
        [self _storeData:callback];

    self.parser = nil;
}


- (void)_loadDataForced:(BOOL)forced callback:(KMLCallback)callback {
    self.countries = forced ? nil : [Storage loadObjectWithkey:kKMLStorageDataKey];

    if (VALID_ARRAY_1(self.countries))
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

- (void)parser:(KMLParser *)parser didFindCountry:(KMLCountry *)country {
    self.countries = [self.countries arrayByAddingObject:country];
}


#pragma mark - Singleton

+ (instancetype)sharedKML {
    static KML * sharedKML = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        sharedKML = [[self.class alloc] init];
    });

    return sharedKML;
}


@end

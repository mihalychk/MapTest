//
//  KMLMatch.m
//  MapTest
//
//  Created by Michael on 26/03/16.
//  Copyright © 2016 Michael. All rights reserved.
//




#import "KMLMatch.h"
#import "KMLCountry.h"
#import "Common.h"




@implementation KMLMatch


#pragma mark - Static Methods

+ (nonnull instancetype)matchWithCountry:(nullable KMLCountry *)country andAccuracy:(KMLMatchAccuracy)accuracy {
    __autoreleasing KMLMatch * match = [[self.class alloc] init];

    match.country = country;
    match.accuracy = accuracy;

    return match;
}


#pragma mark - NSObject

- (NSString *)description {
    return FORMAT(@"<KMLMatch: %p> { name: %@, accuracy: %@ }", self, self.country.name, SUINT(self.accuracy));
}


@end

//
//  KMLCountry.m
//  MapTest
//
//  Created by Michael on 25/03/16.
//  Copyright © 2016 Michael. All rights reserved.
//




#import "KMLCountry.h"
#import "KMLLocation.h"
#import "KMLPolygon.h"
#import "Common.h"
#import <CoreLocation/CLLocation.h>




@interface KMLCountry () <NSSecureCoding> {
    
}

@end




@implementation KMLCountry


#pragma mark - Static Methods

+ (instancetype)country {
    __autoreleasing KMLCountry * country = [[self.class alloc] init];

    return country;
}


#pragma mark - init & dealloc

- (instancetype)init {
    if ((self = [super init]))
        self.polygons = NSMutableArray.array;

    return self;
}


#pragma mark - NSSecureCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super init])) {
        DECODE(name);
        DECODE_MUTABLE(polygons);
    }

    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder {
    ENCODE(name);
    ENCODE(polygons);
}


+ (BOOL)supportsSecureCoding {
    return YES;
}


#pragma mark - NSObject

- (NSString *)description {
    return FORMAT(@"<KMLCountry: %p> { name: %@, polygons: %@ }", self, self.name, SUINT(self.polygons.count));
}


@end

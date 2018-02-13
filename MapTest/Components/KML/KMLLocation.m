//
//  KMLLocation.m
//  MapTest
//
//  Created by Michael on 26/03/16.
//  Copyright © 2016 Michael. All rights reserved.
//




#import "KMLLocation.h"
#import "Common.h"




@interface KMLLocation () <NSSecureCoding>

@end




@implementation KMLLocation


#pragma mark - Static Methods

+ (instancetype)loactionWithLatitude:(double)latitude andLongitude:(double)longitude {
    __autoreleasing KMLLocation * location = [[self.class alloc] init];

    location.latitude = latitude;
    location.longitude = longitude;

    return location;
}


#pragma mark - NSSecureCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super init])) {
        DECODE_DOUBLE(latitude);
        DECODE_DOUBLE(longitude);
    }

    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder {
    ENCODE_DOUBLE(latitude);
    ENCODE_DOUBLE(longitude);
}


+ (BOOL)supportsSecureCoding {
    return YES;
}


#pragma mark - NSObject

- (NSString *)description {
    return FORMAT(@"<KMLLocation: %p> { latitude: %.10f, longitude: %.10f }", self, self.latitude, self.longitude);
}


@end

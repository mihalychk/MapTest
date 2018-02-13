//
//  KMLPolygon.m
//  MapTest
//
//  Created by Michael on 26/03/16.
//  Copyright © 2016 Michael. All rights reserved.
//




#import "KMLPolygon.h"
#import "KMLLocation.h"
#import "Common.h"




@interface KMLPolygon () <NSSecureCoding>

@end




@implementation KMLPolygon


#pragma mark - Static Methods

+ (instancetype)polygon {
    __autoreleasing KMLPolygon * polygon = [[self.class alloc] init];

    return polygon;
}


#pragma mark - NSSecureCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super init])) {
        DECODE(locations);
        DECODE(country);

        double x = [aDecoder decodeDoubleForKey:@"frame.origin.x"];
        double y = [aDecoder decodeDoubleForKey:@"frame.origin.y"];
        double width = [aDecoder decodeDoubleForKey:@"frame.size.width"];
        double height = [aDecoder decodeDoubleForKey:@"frame.size.height"];

        self.frame = KMLRectMake(x, y, width, height);
    }

    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder {
    ENCODE(locations);
    ENCODE(country);

    [aCoder encodeDouble:self.frame.origin.x forKey:@"frame.origin.x"];
    [aCoder encodeDouble:self.frame.origin.y forKey:@"frame.origin.y"];
    [aCoder encodeDouble:self.frame.size.width forKey:@"frame.size.width"];
    [aCoder encodeDouble:self.frame.size.height forKey:@"frame.size.height"];
}


+ (BOOL)supportsSecureCoding {
    return YES;
}


#pragma mark - Public Methods

- (void)setLocationsFromString:(NSString *)string {
    if (!VALID_STRING_1(string))
        return;

    @autoreleasepool {
        NSArray * stringItems = [string componentsSeparatedByString:@" "];
        
        if (!VALID_ARRAY_1(stringItems))
            return;
        
        NSMutableArray * array = NSMutableArray.array;

        double x = 0.0f, y = 0.0f, width = 0.0f, height = 0.0f;

        for (NSString * stringItem in stringItems) {
            if (!VALID_STRING_1(stringItem))
                continue;

            @autoreleasepool {
                NSArray * items = [stringItem componentsSeparatedByString:@","];

                if (!VALID_ARRAY_1(items) || items.count < 3)
                    continue;

                double latitude = [items[1] doubleValue];
                double longitude = [items[0] doubleValue];

                if (latitude == 0.0f || longitude == 0.0f)
                    continue;

                [array addObject:[KMLLocation loactionWithLatitude:latitude andLongitude:longitude]];

                /* Calculating bounding box */
                if (x == 0.0f)
                    x = latitude;

                if (y == 0.0f)
                    y = longitude;

                if (width == 0.0f)
                    width = latitude;

                if (height == 0.0f)
                    height = longitude;

                if (latitude < x)
                    x = latitude;

                if (longitude < y)
                    y = longitude;

                if (latitude > width)
                    width = latitude;

                if (longitude > height)
                    height = longitude;
            }
        }

        self.frame = KMLRectMake(x, y, width - x, height - y);
        self.locations = array;
    }
}


#pragma mark - NSObject

- (NSString *)description {
    return FORMAT(@"<KMLPolygon: %p> { locations: %@ }", self, SUINT(self.locations.count));
}


@end

//
//  KMLMatcher.m
//  MapTest
//
//  Created by Michael on 26/03/16.
//  Copyright © 2016 Michael. All rights reserved.
//




#import "KMLMatcher.h"
#import "KMLCountry.h"
#import "KMLPolygon.h"
#import "KMLLocation.h"
#import "KMLMatch.h"
#import "Common.h"
#import <CoreGraphics/CGPath.h>




@implementation KMLMatcher


#pragma mark - Private Methods

+ (BOOL)coordinates:(CLLocationCoordinate2D)coordinates inPolygon:(KMLPolygon *)polygon {
    /* Build the Polygon and detect are the coordinates belong to this Polygon */
    CGMutablePathRef path = CGPathCreateMutable();

    BOOL firstOne = YES;

    for (KMLLocation * location in polygon.locations) {
        if (firstOne) {
            CGPathMoveToPoint(path, NULL, location.latitude, location.longitude);

            firstOne = NO;
        }
        else
            CGPathAddLineToPoint(path, NULL, location.latitude, location.longitude);
    }

    CGPathCloseSubpath(path);

    BOOL result = CGPathContainsPoint(path, NULL, CGPointMake(coordinates.latitude, coordinates.longitude), YES);

    CGPathRelease(path);

    return result;
}


+ (KMLMatch *)_matchCoordinates:(CLLocationCoordinate2D)coordinates withRoughMatches:(NSArray<KMLPolygon *> *)roughMatches {
    LOG(@"matchCoordinates: { latitude = %.10f, longitude = %.10f } withRoughMatches: %@", coordinates.latitude, coordinates.longitude, SUINT(roughMatches.count));

    for (KMLPolygon * polygon in roughMatches)
        if ([KMLMatcher coordinates:coordinates inPolygon:polygon])
            return [KMLMatch matchWithCountry:polygon.country andAccuracy:KMLMatchAccuracyAccurate];

    return nil;
}


#pragma mark - Static Methods

+ (KMLMatch *)matchCoordinates:(CLLocationCoordinate2D)coordinates inCountries:(NSArray<KMLCountry *> *)countries {
    LOG(@"matchCoordinates: { latitude = %.10f, longitude = %.10f }", coordinates.latitude, coordinates.longitude);

    if (!VALID_ARRAY_1(countries) || !CLLocationCoordinate2DIsValid(coordinates))
        return nil;

    NSMutableArray * roughMatches = NSMutableArray.array;

    /* Check that coordinates belong to bounding box */
    for (KMLCountry * country in countries) {
        for (KMLPolygon * polygon in country.polygons) {
            KMLRect frame = polygon.frame;

            if (coordinates.latitude < frame.origin.x || coordinates.latitude > (frame.origin.x + frame.size.width))
                continue;

            if (coordinates.longitude < frame.origin.y || coordinates.longitude > (frame.origin.y + frame.size.height))
                continue;

            [roughMatches addObject:polygon];
        }
    }

    if (!VALID_ARRAY_1(roughMatches))
        return nil;

   KMLMatch * result = [KMLMatcher _matchCoordinates:coordinates withRoughMatches:roughMatches];

    if (!result && roughMatches.count > 0)
        return [KMLMatch matchWithCountry:((KMLPolygon *)roughMatches.firstObject).country andAccuracy:KMLMatchAccuracyRough];

    return result;
}


@end

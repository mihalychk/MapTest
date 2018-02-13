//
//  MatcherTests.m
//  MapTest
//
//  Created by Michael on 29/03/16.
//  Copyright © 2016 Michael. All rights reserved.
//




#import <XCTest/XCTest.h>
#import "KMLMatcher.h"
#import "KMLMatch.h"
#import "KMLCountry.h"
#import "KMLPolygon.h"
#import "KMLLocation.h"
#import "KMLCommon.h"




@interface MatcherTests : XCTestCase

@property (nonatomic, strong) KMLCountry * country;

@end




@implementation MatcherTests


- (void)setUp {
    [super setUp];
    
    self.country = KMLCountry.country;
    self.country.name = @"Andorra";
    
    KMLPolygon * polygon = KMLPolygon.polygon;
    polygon.country = self.country;

    [polygon setLocationsFromString:@"1.710966944694519,42.4734992980957,0 1.533332943916321,42.43610000610352,0 1.448333024978638,42.45082092285156,0 1.446388006210327,42.57220840454102,0 1.435246944427491,42.59714889526367,0 1.541110992431641,42.65386962890625,0 1.781666994094849,42.58166122436523,0 1.710966944694519,42.4734992980957,0 "];
    
    [self.country.polygons addObject:polygon];
}


- (void)testMatch {
    KMLMatch * match = [KMLMatcher matchCoordinates:CLLocationCoordinate2DMake(42.560139f, 1.6448903f) inCountries:@[self.country]];
    
    XCTAssertTrue(match.accuracy == KMLMatchAccuracyAccurate, @"Wrong Accuracy Value");
    XCTAssertTrue(match.country == self.country, @"Wrong Country Detected");
}


- (void)testUnmatch {
    KMLMatch * match = [KMLMatcher matchCoordinates:CLLocationCoordinate2DMake(32.460639f, 19.994489f) inCountries:@[self.country]];
    
    XCTAssertNil(match, @"Wrong Match");
}


@end

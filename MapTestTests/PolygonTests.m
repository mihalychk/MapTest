//
//  PolygonTests.m
//  MapTestTests
//
//  Created by Michael on 25/03/16.
//  Copyright © 2016 Michael. All rights reserved.
//




#import <XCTest/XCTest.h>
#import "KMLPolygon.h"
#import "KMLLocation.h"
#import "KMLCommon.h"




@interface MapTestTests : XCTestCase

@property (nonatomic, strong) KMLPolygon * polygon;

@end




@implementation MapTestTests


- (void)setUp {
    [super setUp];

    self.polygon            = [KMLPolygon polygon];
}


- (void)testLocationsFromString {
    [self.polygon setLocationsFromString:@"-1.234,4.567,0 7.890,0.1234,0 -5.67890,1.2345,0"];

    XCTAssertTrue(self.polygon.locations.count == 3, @"Wrong Locations count");

    KMLLocation * location  = self.polygon.locations[1];
    
    XCTAssertTrue(location.latitude == 0.1234, @"Wrong Location latitude");
    XCTAssertTrue(location.longitude == 7.89, @"Wrong Location longitude");
}


@end
//
//  StorageTests.m
//  MapTest
//
//  Created by Michael on 28/03/16.
//  Copyright © 2016 Michael. All rights reserved.
//




#import <XCTest/XCTest.h>
#import "KMLCountry.h"
#import "KMLPolygon.h"
#import "KMLCommon.h"
#import "Storage.h"




@interface StorageTests : XCTestCase

@property (nonatomic, strong) KMLCountry * country;

@end




@implementation StorageTests


- (void)setUp {
    [super setUp];

    self.country            = [KMLCountry country];
    self.country.name       = @"My Country";

    KMLPolygon * polygon    = [KMLPolygon polygon];
    polygon.country         = self.country;
    polygon.frame           = KMLRectMake(1.0f, 2.0f, 3.0f, 4.0f);

    [self.country.polygons addObject:polygon];
}


- (void)testStoring {
    NSString * key          = @"testStoring.key";

    [Storage saveObject:self.country withKey:key];

    KMLCountry * result     = [Storage loadObjectWithkey:key];
    
    XCTAssertTrue([result.name isEqualToString:self.country.name], @"Name is wrong");
    XCTAssertTrue(result.polygons.count == 1, @"Wrong Polygons count");

    KMLPolygon * polygon    = result.polygons.firstObject;
    
    XCTAssertTrue(polygon.country == result, @"Wrong Polygon parent country");
    XCTAssertTrue(polygon.frame.origin.x == 1.0f, @"Wrong Polygon's frame.origin.x");
    XCTAssertTrue(polygon.frame.origin.y == 2.0f, @"Wrong Polygon's frame.origin.y");
    XCTAssertTrue(polygon.frame.size.width == 3.0f, @"Wrong Polygon's frame.size.width");
    XCTAssertTrue(polygon.frame.size.height == 4.0f, @"Wrong Polygon's frame.size.height");
}


@end
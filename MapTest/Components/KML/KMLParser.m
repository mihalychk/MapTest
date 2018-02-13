//
//  KMLParser.m
//  MapTest
//
//  Created by Michael on 25/03/16.
//  Copyright © 2016 Michael. All rights reserved.
//




#import "KMLParser.h"
#import "KMLCountry.h"
#import "KMLPolygon.h"
#import "Common.h"




#define kKMLParserTagPlacemark      @"Placemark"
#define kKMLParserTagName           @"name"
#define kKMLParserTagCoordinates    @"coordinates"




@interface KMLParser () <NSXMLParserDelegate> {
    BOOL isNameTime;
    BOOL isCoordinatesTime;
}

@property (nonatomic, strong) NSMutableString * contentString;
@property (nonatomic, strong) KMLCountry * currentCountry;
@property (nonatomic, strong) NSString * fileName;
@property (nonatomic, strong) NSXMLParser * xmlParser;

@end




@implementation KMLParser


@synthesize lastError;


#pragma mark - init & dealloc

- (instancetype)initWithFileName:(NSString *)fileName {
    if ((self = [super init])) {
        LOG(@"created");

        self.fileName = fileName;
    }

    return self;
}


- (void)dealloc {
    LOG(@"dead");
}


#pragma mark - NSXMLParserDelegate

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    LOG(@"started");

    [self cleanUp];
}


- (void)parserDidEndDocument:(NSXMLParser *)parser {
    LOG(@"completed");
}


- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    LOG(@"parser: parseErrorOccurred: %@", parseError);
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict {
    if ([elementName isEqualToString:kKMLParserTagPlacemark]) {
        self.currentCountry = KMLCountry.country;

        return;
    }

    if (self.currentCountry) {
        isNameTime = [elementName isEqualToString:kKMLParserTagName];
        isCoordinatesTime = [elementName isEqualToString:kKMLParserTagCoordinates];

        if (isNameTime || isCoordinatesTime)
            self.contentString = NSMutableString.string;
    }
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (isNameTime) {
        self.currentCountry.name = string;
        isNameTime = NO;
    }

    if (isCoordinatesTime)
        [self.contentString appendString:string];
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if (self.currentCountry) {
        if ([elementName isEqualToString:kKMLParserTagCoordinates]) {
            isCoordinatesTime = NO;

            KMLPolygon * polygon = KMLPolygon.polygon;
            polygon.country = self.currentCountry;

            [polygon setLocationsFromString:self.contentString];

            [self.currentCountry.polygons addObject:polygon];
        }

        if ([elementName isEqualToString:kKMLParserTagPlacemark]) {
            if ([self.delegate respondsToSelector:@selector(parser:didFindCountry:)])
                [self.delegate parser:self didFindCountry:self.currentCountry];

            self.currentCountry = nil;
        }
    }

    self.contentString = nil;
}


#pragma mark - Private Methods

- (void)cleanUp {
    self.currentCountry = nil;
    self.contentString = nil;
    isNameTime = NO;
    isCoordinatesTime = NO;
}


#pragma mark - Public Methods

- (BOOL)start {
    [self stop];

    self.xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:URLFORMAT(@"file://%@", self.fileName)];
    self.xmlParser.delegate = self;

    BOOL result = [self.xmlParser parse];
    self.xmlParser = nil;

    [self cleanUp];

    return result;
}


- (void)stop {
    [self.xmlParser abortParsing];

    self.xmlParser = nil;
}


@end

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
    __strong NSString * fileName;
    __strong NSXMLParser * xmlParser;
    __strong KMLCountry * currentCountry;
    __strong NSMutableString * contentString;
    __strong NSError * lastError;
    
    BOOL isNameTime;
    BOOL isCoordinatesTime;
}

@end




@implementation KMLParser


@synthesize lastError;


#pragma mark - init & dealloc

- (instancetype)initWithFileName:(NSString *)_fileName {
    if ((self = [super init])) {
        LOG(@"created");

        fileName            = _fileName;
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


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict {
    if ([elementName isEqualToString:kKMLParserTagPlacemark]) {
        currentCountry      = [KMLCountry country];

        return;
    }

    if (currentCountry) {
        isNameTime          = [elementName isEqualToString:kKMLParserTagName];
        isCoordinatesTime   = [elementName isEqualToString:kKMLParserTagCoordinates];

        if (isNameTime || isCoordinatesTime)
            contentString       = [NSMutableString string];
    }
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (isNameTime) {
        currentCountry.name     = string;
        isNameTime              = NO;
    }
    
    if (isCoordinatesTime)
        [contentString appendString:string];
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName {
    if (currentCountry) {
        if ([elementName isEqualToString:kKMLParserTagCoordinates]) {
            isCoordinatesTime       = NO;
            
            KMLPolygon * polygon    = [KMLPolygon polygon];
            polygon.country         = currentCountry;
            
            [polygon setLocationsFromString:contentString];
            
            [currentCountry.polygons addObject:polygon];
        }
        if ([elementName isEqualToString:kKMLParserTagPlacemark]) {
            if ([self.delegate respondsToSelector:@selector(parser:didFindCountry:)])
                [self.delegate parser:self didFindCountry:currentCountry];

            currentCountry          = nil;
        }
    }

    contentString           = nil;
}


#pragma mark - Private Methods

- (void)cleanUp {
    currentCountry          = nil;
    contentString           = nil;
    isNameTime              = NO;
    isCoordinatesTime       = NO;
}


#pragma mark - Public Methods

- (BOOL)start {
    [self stop];

    xmlParser               = [[NSXMLParser alloc] initWithContentsOfURL:URLFORMAT(@"file://%@", fileName)];
    xmlParser.delegate      = self;

    BOOL result             = [xmlParser parse];
    xmlParser               = nil;

    [self cleanUp];

    return result;
}


- (void)stop {
    [xmlParser abortParsing];

    xmlParser           = nil;
}


@end
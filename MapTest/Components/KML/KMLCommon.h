//
//  KMLCommon.h
//  MapTest
//
//  Created by Michael on 26/03/16.
//  Copyright © 2016 Michael. All rights reserved.
//




#import <Foundation/Foundation.h>




/* Points. */

typedef struct KMLPoint {
    double x;
    double y;
} KMLPoint;


/* Sizes. */

typedef struct KMLSize {
    double width;
    double height;
} KMLSize;


/* Rectangles. */

typedef struct KMLRect {
    KMLPoint origin;
    KMLSize size;
} KMLRect;


KMLPoint KMLPointMake(double x, double y);
KMLRect KMLRectMake(double x, double y, double width, double height);

NSString * NSStringFromKMLPoint(KMLPoint point);
NSString * NSStringFromKMLRect(KMLRect rect);



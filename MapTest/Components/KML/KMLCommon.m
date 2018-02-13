//
//  KMLCommon.m
//  MapTest
//
//  Created by Michael on 26/03/16.
//  Copyright © 2016 Michael. All rights reserved.
//




#import "KMLCommon.h"
#import "Common.h"




KMLPoint KMLPointMake(double x, double y) {
    KMLPoint point = { 0.0f, 0.0f };

    point.x = x;
    point.y = y;

    return point;
}


KMLRect KMLRectMake(double x, double y, double width, double height) {
    KMLRect rect = { 0.0f, 0.0f, 0.0f, 0.0f };

    rect.origin.x = x;
    rect.origin.y = y;
    rect.size.width = width;
    rect.size.height = height;

    return rect;
}


NSString * NSStringFromKMLPoint(KMLPoint point) {
    return FORMAT(@"{ x = %.10f, y = %.10f }", point.x, point.y);
}


NSString * NSStringFromKMLRect(KMLRect rect) {
    return FORMAT(@"{ x = %.10f, y = %.10f width = %.10f height = %.10f }", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
}


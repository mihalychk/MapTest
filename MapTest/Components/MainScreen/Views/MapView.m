//
//  MapView.m
//  MapTest
//
//  Created by Michael on 26/03/16.
//  Copyright © 2016 Michael. All rights reserved.
//




#import "MapView.h"
#import "KML.h"
#import "KMLCountry.h"
#import "KMLPolygon.h"
#import "KMLLocation.h"
#import "Common.h"




@interface MapView () {
    __strong KMLCountry * country;
}

@end




@implementation MapView


@synthesize country;


#pragma mark - UIView Stuff

- (void)drawRect:(CGRect)rect {
    CGContextRef context    = UIGraphicsGetCurrentContext();
    double correctionX      = -180.0f;
    double correctionY      = 180.0f;
    CGFloat scale           = self.bounds.size.width / 360.0f;

    /* Correct map's scale to fit screen width */
    CGAffineTransform trans = CGAffineTransformMakeScale(scale, scale);
    
    CGContextRotateCTM(context, -M_PI_2);

    /* Drawing a map, current country will be painted in red */
    for (KMLCountry * kmlCountry in [KML sharedKML].countries) {
        CGContextSetStrokeColorWithColor(context, kmlCountry == country ? CRGBA(0xDD, 0x00, 0x00, 1.0f) : CRGBA(0xAA, 0xAA, 0xAA, 0.75f));
        CGContextSetLineWidth(context, 0.5f);

        for (KMLPolygon * polygon in kmlCountry.polygons) {
            CGMutablePathRef path   = CGPathCreateMutable();

            BOOL firstOne           = YES;

            for (KMLLocation * location in polygon.locations) {
                double xCoord           = location.latitude + correctionX;
                double yCoord           = location.longitude + correctionY;

                if (firstOne) {
                    CGPathMoveToPoint(path, &trans, xCoord, yCoord);
                    
                    firstOne                = NO;
                }
                else
                    CGPathAddLineToPoint(path, &trans, xCoord, yCoord);
            }
            
            CGPathCloseSubpath(path);
            CGContextAddPath(context, path);
            CGContextStrokePath(context);

            CGPathRelease(path);
        }
    }

    /* If country is detected draw user's location mark */
    if (country) {
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);

        CGMutablePathRef path   = CGPathCreateMutable();
        
        CGPathAddEllipseInRect(path, &trans, CGRectMake(self.myLocation.latitude + correctionX - 3.0f, self.myLocation.longitude + correctionY - 3.0f, 6.0f, 6.0f));
        CGPathCloseSubpath(path);
        CGContextAddPath(context, path);
        CGContextFillPath(context);
        
        CGPathRelease(path);
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];

    /* Redraw */
    [self setNeedsDisplay];
}


#pragma mark - Getters & Setters

- (void)setCountry:(KMLCountry *)_country {
    country             = _country;
    
    /* Redraw */
    [self setNeedsDisplay];
}


@end
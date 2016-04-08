//
//  MapView.h
//  MapTest
//
//  Created by Michael on 26/03/16.
//  Copyright © 2016 Michael. All rights reserved.
//




#import <UIKit/UIKit.h>
#import <CoreLocation/CLLocation.h>




@class KMLCountry;




/**
 * View class to display map and user's location.
 */
@interface MapView : UIView

/**
 * Detected Country, if this property is set, it will highlight it on the map by red.
 */
@property (nonatomic, nullable, strong) KMLCountry * country;

/**
 * User's location.
 */
@property (nonatomic, assign) CLLocationCoordinate2D myLocation;

@end
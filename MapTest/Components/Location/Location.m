//
//  Location.m
//  MapTest
//
//  Created by Michael on 26/03/16.
//  Copyright © 2016 Michael. All rights reserved.
//




#import "Location.h"
#import "Common.h"




#define LOCATION_TIMEOUT 60.0f




@interface Location () <CLLocationManagerDelegate> {
    __strong CLLocationManager * manager;
    __strong NSTimer * timer;
}

@property (nonatomic, nullable, copy) LocationBlock callback;

- (void)start;
- (void)stop;
- (void)callback:(LocationStatus)status location:(CLLocationCoordinate2D)location;

@end




@implementation Location


#pragma mark - init & dealloc

- (id)init {
    if ((self = [super init])) {
        LOG(@"created");
        
        timer               = [NSTimer scheduledTimerWithTimeInterval:LOCATION_TIMEOUT target:self selector:@selector(onTimer:) userInfo:nil repeats:NO];
    }
    
    return self;
}


- (void)dealloc {
    [self stop];
    
    LOG(@"dead");
}


#pragma mark - Static Methods

+ (nonnull instancetype)locationWithBlock:(LocationBlock)callback {
    __autoreleasing Location * location = [[Location alloc] init];
    location.callback                   = callback;
    
    [location start];
    
    return location;
}


#pragma mark - Handles

- (void)start {
    if ([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied) {
        if (nil == manager)
            manager                     = [[CLLocationManager alloc] init];
        
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)
            [manager requestWhenInUseAuthorization];
        
        manager.delegate            = self;
        manager.desiredAccuracy     = kCLLocationAccuracyNearestTenMeters;
        manager.distanceFilter      = 500; // meters
        
        [manager startUpdatingLocation];
        
        return;
    }
    
    LOG(@"not available");
    
    [self callback:LocationStatusNotAllowed location:kCLLocationCoordinate2DInvalid];
}


- (void)stop {
    if (manager) {
        [manager stopUpdatingLocation];
        
        manager         = nil;
    }
    
    if (timer) {
        [timer invalidate];
        
        timer           = nil;
    }
}


#pragma mark - Callbacks

- (void)onTimer:(NSTimer *)_timer {
    LOG(@"timeout");
    
    [self callback:LocationStatusError location:kCLLocationCoordinate2DInvalid];
}


- (void)callback:(LocationStatus)status location:(CLLocationCoordinate2D)location {
    IN_MAINTHREAD(^{
        if (self.callback)
            self.callback(status, location);
    });
    
    [self stop];
}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation * location       = [locations lastObject];
    NSDate * eventDate          = location.timestamp;
    NSTimeInterval howRecent    = [eventDate timeIntervalSinceNow];
    
    if (fabs(howRecent) < 15.0f) {
        LOG(@"got data");
        
        if (CLLocationCoordinate2DIsValid(location.coordinate))
            [self callback:LocationStatusOK location:location.coordinate];
        
        else
            [self callback:LocationStatusError location:kCLLocationCoordinate2DInvalid];
    }
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    LOG(@"error: %@", error);
    
    [self callback:LocationStatusError location:kCLLocationCoordinate2DInvalid];
}


@end
//
//  MainScreenViewController.m
//  MapTest
//
//  Created by Michael on 25/03/16.
//  Copyright © 2016 Michael. All rights reserved.
//




#import "MainScreenViewController.h"
#import "Common.h"
#import "KML.h"
#import "Location.h"
#import "KMLMatcher.h"
#import "KMLMatch.h"
#import "KMLCountry.h"
#import "LoaderView.h"
#import "MapView.h"




@interface MainScreenViewController () {
    CLLocationCoordinate2D myLocation;
}

@property (nonatomic, weak) IBOutlet UILabel * locationLabel;
@property (nonatomic, weak) IBOutlet MapView * mapView;
@property (nonatomic, strong) KMLMatch * match;

@end




@implementation MainScreenViewController


#pragma mark - Action

- (void)onRefresh:(UIBarButtonItem *)sender {
    NSMutableArray * actions = NSMutableArray.array;

    [actions addObject:[UIAlertAction actionWithTitle:NSLocalizedString(@"Rebuild Map", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [self updateDataForced:YES];
    }]];

    [actions addObject:[UIAlertAction actionWithTitle:NSLocalizedString(@"Update Location", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        self.locationLabel.text = NSLocalizedString(@"Getting your location...", nil);

        [self obtainLocation];
    }]];

    [actions addObject:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:nil]];

    [self presentSheetWithTitle:nil message:nil andActions:actions animated:YES];
}


#pragma mark - UI

- (void)updateView:(BOOL)clear {
    if (clear) {
        self.locationLabel.text = nil;
        self.mapView.country = nil;

        return;
    }

    switch (self.match.accuracy) {
        case KMLMatchAccuracyRough:
            self.locationLabel.text = FORMAT(@"%@\n%@", NSLocalizedString(@"You are probably in", nil), self.match.country.name);

            break;

        case KMLMatchAccuracyAccurate:
            self.locationLabel.text = FORMAT(@"%@\n%@", NSLocalizedString(@"You are in", nil), self.match.country.name);

            break;

        default:
            self.locationLabel.text = NSLocalizedString(@"Can't detect country", nil);

            break;
    }

    self.mapView.country = self.match.country;
    self.mapView.myLocation = myLocation;
}


#pragma mark - Data

- (void)matchLocation:(CLLocationCoordinate2D)location withStatus:(LocationStatus)status {
    [self loader:NO animated:YES];

    if (status != LocationStatusOK)
        [self presentAlertOKWithTitle:NSLocalizedString(@"Location Error", nil) message:NSLocalizedString(@"Can't get your location, I'm really really sorry.", nil) animated:YES];

    else
        self.match = [KMLMatcher matchCoordinates:location inCountries:KML.sharedKML.countries];

    myLocation = location;

    [self updateView:status != LocationStatusOK];
}


- (void)obtainLocation {
    [self setLoaderTitle:NSLocalizedString(@"Getting your location...", nil)];

    WEAK(self);

    [Location locationWithBlock:^(LocationStatus status, CLLocationCoordinate2D location) {
        [WEAK_self matchLocation:location withStatus:status];
    }];
}


- (void)updateDataForced:(BOOL)forced {
    [self loader:YES animated:forced];
    [self updateView:YES];

    [self setLoaderTitle:NSLocalizedString(@"Loading map...", nil)];

    [KML.sharedKML loadDataForced:forced callback:^(NSError * error) {
        if (error) {
            [self loader:NO animated:YES];
            [self presentAlertError:error animated:YES];
        }
        else
            [self obtainLocation];
    }];
}


#pragma mark - UIViewController Stuff

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = NSLocalizedString(@"Find your Country", nil);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(onRefresh:)];

    [self updateDataForced:NO];
}


@end

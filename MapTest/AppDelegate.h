//
//  AppDelegate.h
//  MapTest
//
//  Created by Michael on 25/03/16.
//  Copyright © 2016 Michael. All rights reserved.
//




#import <UIKit/UIKit.h>




/**
 * Main AppDelegate Object.
 */
@interface AppDelegate : UIResponder <UIApplicationDelegate>

/**
 * Shows/Hides fullscreen loader.
 */
- (void)loader:(BOOL)show animated:(BOOL)animated;

/**
 * Sets title for fullscreen loader.
 */
- (void)setLoaderTitle:(nullable NSString *)title;

@end
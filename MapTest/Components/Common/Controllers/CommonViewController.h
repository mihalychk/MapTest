//
//  CommonViewController.h
//  MapTest
//
//  Created by Michael on 26/03/16.
//  Copyright © 2016 Michael. All rights reserved.
//




#import <UIKit/UIKit.h>




/**
 * Base class for controllers with helper functions.
 */
@interface CommonViewController : UIViewController

/**
 * Displays action sheet with title, message and actions.
 */
- (void)presentSheetWithTitle:(nullable NSString *)title message:(nullable NSString *)message andActions:(nullable NSArray<UIAlertAction *> *)actions animated:(BOOL)animated;

/**
 * Displays dialog with title, message and actions.
 */
- (void)presentAlertWithTitle:(nullable NSString *)title message:(nullable NSString *)message andActions:(nullable NSArray<UIAlertAction *> *)actions animated:(BOOL)animated;

/**
 * Displays dialog with title, message and OK button.
 */
- (void)presentAlertOKWithTitle:(nullable NSString *)title message:(nullable NSString *)message animated:(BOOL)animated;

/**
 * Displays dialog with error message and OK button.
 */
- (void)presentAlertError:(nullable NSError *)error animated:(BOOL)animated;

/**
 * Displays confirmation dialog with message and Yes/Cancel buttons.
 */
- (void)presentConfirmationWithMessage:(nullable NSString *)message buttonTitle:(nullable NSString *)buttonTitle cancelHandler:(void(^__nullable)(UIAlertAction * _Nonnull action))cancelHandler yesHandler:(void(^__nullable)(UIAlertAction * _Nonnull action))yesHandler animated:(BOOL)animated;

/**
 * Shows/Hides fullscreen loader.
 */
- (void)loader:(BOOL)show animated:(BOOL)animated;

/**
 * Sets title for fullscreen loader.
 */
- (void)setLoaderTitle:(nullable NSString *)title;

@end
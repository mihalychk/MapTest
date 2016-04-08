//
//  LoaderView.h
//  MapTest
//
//  Created by Michael on 25/03/16.
//  Copyright © 2016 Michael. All rights reserved.
//




#import <UIKit/UIKit.h>




/**
 * Fullscreen loader view.
 */
@interface LoaderView : UIView

/**
 * Sets title label's text below loader spinner.
 */
@property (nonatomic, nullable, copy) NSString * title;

@end
//
//  LoaderView.h
//  MapTest
//
//  Created by Michael on 25/03/16.
//  Copyright © 2016 Michael. All rights reserved.
//




#import "LoaderView.h"




@interface LoaderView ()

@property (weak) IBOutlet UIActivityIndicatorView * activityView;
@property (weak) IBOutlet UILabel * titleLabel;

@end




@implementation LoaderView


#pragma mark - init & dealloc

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder]))
        [self subInit];

    return self;
}


- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame]))
        [self subInit];

    return self;
}


- (void)subInit {
    self.backgroundColor = [UIColor.whiteColor colorWithAlphaComponent:0.95f];
    self.titleLabel.text = nil;
}


#pragma mark - Getters & Setters

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}


- (NSString *)title {
    return self.titleLabel.text;
}


#pragma mark - UIView

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];

    [self.activityView startAnimating];
}


- (void)removeFromSuperview {
    [self.activityView stopAnimating];

    [super removeFromSuperview];
}


@end

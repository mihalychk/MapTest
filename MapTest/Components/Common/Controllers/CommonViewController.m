//
//  CommonViewController.m
//  MapTest
//
//  Created by Michael on 26/03/16.
//  Copyright © 2016 Michael. All rights reserved.
//




#import "CommonViewController.h"
#import "AppDelegate.h"




@interface CommonViewController ()

@end




@implementation CommonViewController


#pragma mark -

- (void)_presentPopupWithStyle:(UIAlertControllerStyle)style title:(NSString *)title message:(NSString *)message andActions:(NSArray<UIAlertAction *> *)actions animated:(BOOL)animated {
    UIAlertController * controller              = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    
    for (UIAlertAction * action in actions)
        [controller addAction:action];

    [controller setModalPresentationStyle:UIModalPresentationPopover];
    
    UIPopoverPresentationController * presenter = controller.popoverPresentationController;
    presenter.barButtonItem                     = self.navigationItem.rightBarButtonItem;
    
    [self presentViewController:controller animated:animated completion:nil];
}


#pragma mark Public Methods

- (void)presentSheetWithTitle:(nullable NSString *)title message:(nullable NSString *)message andActions:(nullable NSArray<UIAlertAction *> *)actions animated:(BOOL)animated {
    [self _presentPopupWithStyle:UIAlertControllerStyleActionSheet title:title message:message andActions:actions animated:animated];
}


- (void)presentAlertWithTitle:(nullable NSString *)title message:(nullable NSString *)message andActions:(nullable NSArray<UIAlertAction *> *)actions animated:(BOOL)animated {
    [self _presentPopupWithStyle:UIAlertControllerStyleAlert title:title message:message andActions:actions animated:animated];
}


- (void)presentAlertOKWithTitle:(nullable NSString *)title message:(nullable NSString *)message animated:(BOOL)animated {
    [self presentAlertWithTitle:title message:message andActions:@[[UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil) style:UIAlertActionStyleDefault handler:nil]] animated:animated];
}


- (void)presentAlertError:(nullable NSError *)error animated:(BOOL)animated {
    [self presentAlertOKWithTitle:error.localizedFailureReason message:error.localizedDescription animated:animated];
}


- (void)presentConfirmationWithMessage:(nullable NSString *)message buttonTitle:(nullable NSString *)buttonTitle cancelHandler:(void(^__nullable)(UIAlertAction * _Nonnull action))cancelHandler yesHandler:(void(^__nullable)(UIAlertAction * _Nonnull action))yesHandler animated:(BOOL)animated {
    NSMutableArray * actions        = [NSMutableArray array];
    
    [actions addObject:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:cancelHandler]];
    [actions addObject:[UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleDefault handler:yesHandler]];
    
    [self presentAlertWithTitle:NSLocalizedString(@"Confirmation", nil) message:message andActions:actions animated:animated];
}


- (void)loader:(BOOL)show animated:(BOOL)animated {
    [(AppDelegate *)[UIApplication sharedApplication].delegate loader:show animated:animated];
}


- (void)setLoaderTitle:(nullable NSString *)title {
    [(AppDelegate *)[UIApplication sharedApplication].delegate setLoaderTitle:title];
}


#pragma mark - UIViewController Stuff

- (void)viewDidLoad {
    [super viewDidLoad];

    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout     = UIRectEdgeNone;
}


@end
//
//  AppDelegate.m
//  MapTest
//
//  Created by Michael on 25/03/16.
//  Copyright © 2016 Michael. All rights reserved.
//




#import "AppDelegate.h"
#import "MainScreenViewController.h"
#import "LoaderView.h"




@interface AppDelegate ()

@property (nonatomic, strong) UIWindow * aWindow;
@property (nonatomic, strong) LoaderView * loaderView;

@end




@implementation AppDelegate


#pragma mark - Public Methods

- (void)loader:(BOOL)show animated:(BOOL)animated {
    if (show) {
        if (!self.loaderView)
            self.loaderView = [NSBundle.mainBundle loadNibNamed:@"LoaderView" owner:self options:nil].firstObject;

        if (animated)
            self.loaderView.alpha = 0.0f;

        [self.aWindow addSubview:self.loaderView];

        self.loaderView.frame = UIScreen.mainScreen.bounds;

        if (animated)
            [UIView animateWithDuration:0.25f animations:^{
                self.loaderView.alpha = 1.0f;
            }];

        else
            self.loaderView.alpha = 1.0f;
    }
    else {
        if (!self.loaderView)
            return;

        if (animated)
            [UIView animateWithDuration:0.125f animations:^{
                self.loaderView.alpha = 0.0f;
            } completion:^(BOOL finished) {
                [self.loaderView removeFromSuperview];
            }];

        else
            [self.loaderView removeFromSuperview];
    }
}


- (void)setLoaderTitle:(nullable NSString *)title {
    self.loaderView.title = title;
}


#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.aWindow = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.aWindow.backgroundColor = UIColor.whiteColor;
    self.aWindow.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[MainScreenViewController alloc] init]];

    [self.aWindow makeKeyAndVisible];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

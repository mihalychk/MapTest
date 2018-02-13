//
//  Storage.m
//  MapTest
//
//  Created by Michael on 26/03/16.
//  Copyright © 2016 Michael. All rights reserved.
//




#import "Storage.h"
#import "Common.h"




@implementation Storage


#pragma mark - Static Methods

+ (NSString *)cachePath {
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
}


+ (BOOL)saveObject:(id)object withKey:(NSString *)key {
    if (!object || !VALID_STRING_1(key))
        return NO;

    return [NSKeyedArchiver archiveRootObject:object toFile:FORMAT(@"%@/%@", Storage.cachePath, key)];
}


+ (id)loadObjectWithkey:(NSString *)key {
    if (!VALID_STRING_1(key))
        return nil;

    return [NSKeyedUnarchiver unarchiveObjectWithFile:FORMAT(@"%@/%@", Storage.cachePath, key)];
}


@end

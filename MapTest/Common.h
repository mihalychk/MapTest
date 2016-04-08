//
//  Common.h
//  MapTest
//
//  Created by Michael on 25/03/16.
//  Copyright © 2016 Michael. All rights reserved.
//

#ifndef Common_h
#define Common_h



#define WEAK(object)                        __weak __typeof__(object) WEAK_ ##object = object
#define STRONG(object)                      __strong typeof(object) STRONG_ ##object = object

#define RGBA(rVal, gVal, bVal, aVal)        ([UIColor colorWithRed:((CGFloat)rVal)/255.0f green:((CGFloat)gVal)/255.0f blue:((CGFloat)bVal)/255.0f alpha:(CGFloat)aVal])
#define RGB(rVal, gVal, bVal)               RGBA(rVal, gVal, bVal, 1.0f)
#define BA(aVal)                            RGBA(0, 0, 0, aVal)
#define CRGBA(rVal, gVal, bVal, aVal)       RGBA(rVal, gVal, bVal, aVal).CGColor
#define CRGB(rVal, gVal, bVal)              RGB(rVal, gVal, bVal).CGColor
#define СBA(aVal)                           BA(aVal).CGColor

#define FORMAT(...)                         ([NSString stringWithFormat:__VA_ARGS__])
#define URL(_string_)                       ([NSURL URLWithString:_string_])
#define URLFORMAT(...)                      URL(FORMAT(__VA_ARGS__))
#define LOG(...)                            NSLog(@"%@: %@", [self class], FORMAT(__VA_ARGS__))
#define WLOG(...)                           NSLog(@"%@: %@", [WEAK_self class], FORMAT(__VA_ARGS__))
#define SBOOL(boolValue)                    (boolValue ? @"YES" : @"NO")
#define SINT(_value_)                       FORMAT(@"%ld", (long)_value_)
#define SUINT(_value_)                      FORMAT(@"%lu", (unsigned long)_value_)
#define SFLOAT(_value_, _digitsCount_)      FORMAT(@"%."MACRO_VALUE_TO_STRING(_digitsCount_)@"f", _value_)

#define VALID(vobj, vclass)                 (vobj && [vobj isKindOfClass:[vclass class]])
#define VALID_DATE(vobj)                    VALID(vobj, NSDate)
#define VALID_DATA(vobj)                    VALID(vobj, NSData)
#define VALID_DICT(vobj)                    VALID(vobj, NSDictionary)
#define VALID_DICT_1(vobj)                  (VALID_DICT(vobj) && ((NSDictionary *)vobj).count > 0)
#define VALID_ARRAY(vobj)                   VALID(vobj, NSArray)
#define VALID_ARRAY_1(vobj)                 (VALID_ARRAY(vobj) && ((NSArray *)vobj).count > 0)
#define VALID_SET(vobj)                     VALID(vobj, NSSet)
#define VALID_SET_1(vobj)                   (VALID_SET(vobj) && ((NSSet *)vobj).count > 0)
#define VALID_NUMBER(vobj)                  VALID(vobj, NSNumber)
#define VALID_UINT_1(vobj)                  (VALID_NUMBER(vobj) && ((NSNumber *)vobj).unsignedIntegerValue > 0)
#define VALID_STRING(vobj)                  VALID(vobj, NSString)
#define VALID_STRING_1(vobj)                (VALID_STRING(vobj) && ((NSString *)vobj).length > 0)
#define VALID_URL(vobj)                     VALID(vobj, NSURL)
#define VALID_URL_1(vobj)                   (VALID_URL(vobj) && ((NSURL *)vobj).absoluteString.length > 0)

#define MACRO_VALUE_TO_STRING_(m)           #m
#define MACRO_VALUE_TO_STRING(m)            MACRO_VALUE_TO_STRING_(m)

#define DECODE(_fieldName_)                 self._fieldName_ = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(_fieldName_))]
#define DECODE_MUTABLE(_fieldName_)         self._fieldName_ = [[aDecoder decodeObjectForKey:NSStringFromSelector(@selector(_fieldName_))] mutableCopy]
#define DECODE_DOUBLE(_fieldName_)          self._fieldName_ = [aDecoder decodeDoubleForKey:NSStringFromSelector(@selector(_fieldName_))]
#define ENCODE(_fieldName_)                 [aCoder encodeObject:self._fieldName_ forKey:NSStringFromSelector(@selector(_fieldName_))]
#define ENCODE_DOUBLE(_fieldName_)          [aCoder encodeDouble:self._fieldName_ forKey:NSStringFromSelector(@selector(_fieldName_))]

#define IN_BACKGROUNG(_callback_)           dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), _callback_)
#define IN_MAINTHREAD(_callback_)           dispatch_async(dispatch_get_main_queue(), _callback_)



#endif /* Common_h */

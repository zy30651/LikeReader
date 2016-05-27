//
//  NSDictionary+Add.m
//  likeReader
//
//  Created by ZY on 16/5/27.
//  Copyright © 2016年 jack. All rights reserved.
//

#import "NSDictionary+Add.h"

@implementation NSDictionary (Add)

- (NSArray *)arrayValueForKey:(NSString *)key defaultValue:(NSArray *)defaultValue {
    id value = [self objectForKey:key];
    return (value && [value isKindOfClass:[NSArray class]]) ? value : defaultValue;
}

- (NSDictionary *)dictionaryValueForKey:(NSString *)key defaultValue:(NSDictionary *)defaultValue {
    id value = [self objectForKey:key];
    return (value && [value isKindOfClass:[NSDictionary class]]) ? value : defaultValue;
}

- (id)objectForKey:(NSString *)key defalutObj:(id)defaultObj {
    id obj = [self objectForKey:key];
    return obj ? obj : defaultObj;
}

- (id)objectForKey:(id)aKey ofClass:(Class)cls defaultObj:(id)defaultObj {
    id obj = [self objectForKey:aKey];
    return (obj && [obj isKindOfClass:cls]) ? obj : defaultObj;
}

@end

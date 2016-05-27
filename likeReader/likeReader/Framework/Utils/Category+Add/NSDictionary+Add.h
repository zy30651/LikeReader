//
//  NSDictionary+Add.h
//  likeReader
//
//  Created by ZY on 16/5/27.
//  Copyright © 2016年 jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Add)

- (NSArray *)arrayValueForKey:(NSString *)key defaultValue:(NSArray *)defaultValue;

- (NSDictionary *)dictionaryValueForKey:(NSString *)key defaultValue:(NSDictionary *)defaultValue;


- (id)objectForKey:(NSString *)key defalutObj:(id)defaultObj;

- (id)objectForKey:(id)aKey ofClass:(Class)cls defaultObj:(id)defaultObj;
@end

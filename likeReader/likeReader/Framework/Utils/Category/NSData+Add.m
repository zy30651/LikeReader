//
//  NSData+Add.m
//  Framework
//
//  Created by ZY on 16/4/13.
//  Copyright © 2016年 AB. All rights reserved.
//

#import "NSData+Add.h"

@implementation NSData (Add)

- (id)JSONParsedWithError:(NSError **)error{
    
    id obj = [NSJSONSerialization JSONObjectWithData:self
                                             options:NSJSONReadingAllowFragments | NSJSONReadingMutableLeaves | NSJSONReadingMutableContainers
                                               error:error];
    if ([obj isKindOfClass:[NSArray class]] || [obj isKindOfClass:[NSDictionary class]]) {
        return obj;
    }
    return  nil;
}

- (id)JSONParsed{
    return [self JSONParsedWithError:nil];
}

@end

//
//  NSObject+Add.m
//  TBRefresh
//
//  Created by ZY on 15/12/22.
//  Copyright © 2015年 TBRefresh. All rights reserved.
//
#import <objc/runtime.h>
#import "NSObject+Add.h"

@implementation NSObject (Add)

+(void)exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2
{
    method_exchangeImplementations(class_getInstanceMethod(self, method1), class_getInstanceMethod(self, method2));
}

+(void)exchangeClassMethod1:(SEL)method1 method2:(SEL)method2
{
    method_exchangeImplementations(class_getClassMethod(self, method1), class_getClassMethod(self, method2));
}

@end

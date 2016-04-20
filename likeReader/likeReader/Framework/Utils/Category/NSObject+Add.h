//
//  NSObject+Add.h
//  TBRefresh
//
//  Created by ZY on 15/12/22.
//  Copyright © 2015年 TBRefresh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Add)

+ (void)exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2;
+ (void)exchangeClassMethod1:(SEL)method1 method2:(SEL)method2;

@end

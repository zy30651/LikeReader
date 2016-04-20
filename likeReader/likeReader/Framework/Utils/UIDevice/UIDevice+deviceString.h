//
//  UIDevice+deviceString.h
//  TinyBean
//
//  Created by 张扬 on 15/6/9.
//  Copyright (c) 2015年 URSUS. All rights reserved.
//  通过设备信息返回具体设备型号,当推出新设备需随时补充

#import <UIKit/UIKit.h>

@interface UIDevice (deviceString)
+ (NSString*)deviceName;
@end

//
//  SvUDIDTools.h
//  SvUDID
//
//  Created by  maple on 8/18/13.
//  Copyright (c) 2013 maple. All rights reserved.
//  读取系统UUID，保存到keyChain中，只有还原手机内容和设置时才会被销毁
//  因原框架是基于非ARC的,所以需要在Build phases中设置该文件未非ARC模式
//  -fno-objc-arc
#import <Foundation/Foundation.h>

@interface SvUDIDTools : NSObject

+ (NSString*)UDID;

@end

//
//  TBCommon.h
//  JingHan
//
//  Created by ZY on 16/4/14.
//  Copyright © 2016年 AB. All rights reserved.
//

#ifndef TBCommon_h
#define TBCommon_h

static  NSString* KdefaultAddress = @"defaultAddress";
static  NSString* KdefaultClass = @"defaultClass";

static  NSString* kLogoutNotification = @"kLogoutNotification";

//WeakSelf
#define TBSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;

//使用十六进制颜色值
#define UIColorFromRGB_hex(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:1.0]


#endif /* TBCommon_h */

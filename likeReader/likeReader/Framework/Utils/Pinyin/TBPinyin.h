//
//  TBPinyin.h
//  Framework
//
//  Created by ZY on 16/4/13.
//  Copyright © 2016年 AB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBPinyin : NSObject
+ (TBPinyin *)pinyin;

- (NSString *)processSortKeyForString:(NSString *)str; // 沈汝龙 =>   “ShenRuLong”
- (NSString *)processString:(NSString *)str; // 沈汝龙 =>   “shenrulong,srl,s”
@end

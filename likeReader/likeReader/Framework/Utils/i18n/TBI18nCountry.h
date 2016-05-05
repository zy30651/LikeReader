//
//  TBI18nCountry.h
//  JingHan
//
//  Created by ZY on 16/4/22.
//  Copyright © 2016年 AB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBI18nCountry : NSObject

/** 所有国家的域名 */
+(NSArray*) allAlpha2s;

/** 所有国家的区号字典   <CN = "86">*/
+(NSDictionary*) alpha2ToCountryCodeDic;

/** 所有国家的区号字典   <CN = "中国">*/
+(NSDictionary*) alpha2ToCountryNameDic;

/** 通过域名aplha2得到区号 */
+(NSString*)countryCodeFor: (NSString*)alpha2;

/** 通过域名aplha2得到名字 */
+(NSString*)countryNameFor: (NSString*)alpha2;


@end

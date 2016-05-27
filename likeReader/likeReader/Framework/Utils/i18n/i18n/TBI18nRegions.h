//
//  TBI18nRegions.h
//  likeReader
//
//  Created by ZY on 16/5/27.
//  Copyright © 2016年 jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBI18nRegions : NSObject

+(NSArray*) allAlpha2s;
+(NSDictionary*) alpha2ToCountryCodeDic;
+(NSDictionary*) alpha2ToCountryNameDic;
+(NSString*)countryCodeFor: (NSString*)alpha2;
+(NSString*)countryNameFor: (NSString*)alpha2;

@end

//
//  TBI18nUserSettings.h
//  TinyBean
//
//  Created by Thomas T. Chan on 3/27/14.
//  Copyright (c) 2014 redbean. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBI18nUserSettings : NSObject

+(NSString*) preferredLang;
+(NSString*) defaultRegion;
+(NSString*) defaultCountryCode;

@end

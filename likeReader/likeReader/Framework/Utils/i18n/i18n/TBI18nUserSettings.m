//
//  TBI18nUserSettings.m
//  TinyBean
//
//  Created by Thomas T. Chan on 3/27/14.
//  Copyright (c) 2014 redbean. All rights reserved.
//

#import "TBI18nUserSettings.h"
#import "NBMetadataHelper.h"

@implementation TBI18nUserSettings

+(NSString*) preferredLang
{
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defs objectForKey:@"AppleLanguages"];
    NSString* preferredLang = [languages objectAtIndex:0];
    return preferredLang;
}

+(NSString*) defaultRegion
{
    NSString* alpha2 = [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
    NSString* identifier = [NSLocale localeIdentifierFromComponents:[NSDictionary dictionaryWithObject: alpha2 forKey: NSLocaleCountryCode]];
    NSString* region =  [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
    if (region)
        return region;
    return alpha2;
}



+(NSString*) defaultCountryCode
{
    NSString* alpha2 = [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
    NBMetadataHelper* helper = [[NBMetadataHelper alloc]init];
    NSString* countryCode = [helper countryCodeFromRegionCode:alpha2];
    return countryCode;
}


@end

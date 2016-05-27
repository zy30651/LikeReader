//
//  TBI18nRegions.m
//  likeReader
//
//  Created by ZY on 16/5/27.
//  Copyright © 2016年 jack. All rights reserved.
//

#import "TBI18nRegions.h"
#import "NBMetadataHelper.h"

@implementation TBI18nRegions

static NSMutableArray* alpha2s = nil;
static NSDictionary* alpha2ToCountryCodes = nil;
static NSMutableDictionary* alpha2ToCountryNames = nil;
static NSString* previousAlpha2 = nil;

+(void) initAlpha2Dictionaries
{
    NSArray *rawAlpha2s = [NSLocale ISOCountryCodes];
    alpha2s = [NSMutableArray arrayWithArray:rawAlpha2s];
    
    NSString* currentAlpha2 = [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
    previousAlpha2 = currentAlpha2;
    [alpha2s removeObject:currentAlpha2];
    [alpha2s insertObject:currentAlpha2 atIndex:0];
    
    NBMetadataHelper* helper = [[NBMetadataHelper alloc]init];

    NSMutableArray *countryCodes = [NSMutableArray arrayWithCapacity:[alpha2s count]];
    NSMutableArray *countryNames = [NSMutableArray arrayWithCapacity:[alpha2s count]];
    NSMutableIndexSet* toRemove = [NSMutableIndexSet new];
    for (NSString *alpha2 in alpha2s)
    {
        NSString* countryCode = [helper countryCodeFromRegionCode:alpha2];
        if (!countryCode)
        {
            [toRemove addIndex:[alpha2s indexOfObject:alpha2]];
            continue;
        }
        NSString *identifier = [NSLocale localeIdentifierFromComponents: [NSDictionary dictionaryWithObject: alpha2 forKey: NSLocaleCountryCode]];
        NSString *countryName = [[NSLocale currentLocale] displayNameForKey: NSLocaleIdentifier value: identifier];
        [countryCodes addObject: countryCode];
        [countryNames addObject: (countryName?countryName:alpha2)];
    }
    [alpha2s removeObjectsAtIndexes:toRemove];
    alpha2ToCountryCodes = [[NSDictionary alloc] initWithObjects:countryCodes forKeys:alpha2s];
    alpha2ToCountryNames = [[NSMutableDictionary alloc] initWithObjects:countryNames forKeys:alpha2s];
    
    //Re-sort alpha2s by country names
    NSDictionary* nameToAlpha2s = [[NSDictionary alloc] initWithObjects:alpha2s forKeys:countryNames];
    NSString* currentCountry = [NSString stringWithString:[countryNames objectAtIndex:0]];
    [countryNames removeObjectAtIndex:0];
    [countryNames sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString* s1 = (NSString*)obj1;
        NSString* s2 = (NSString*)obj2;
        return [s1 compare:s2];
    }];
    [countryNames insertObject:currentCountry atIndex:0];
    
    [alpha2s removeObjectsInRange:NSMakeRange(0, alpha2s.count)];
    for (NSString* countryName in countryNames)
    {
        [alpha2s addObject:[nameToAlpha2s valueForKey:countryName]];
    }
    
    
    for (NSString* alpha2 in alpha2s)
    {
        NSLog(@"%@ %@ %@", alpha2, [alpha2ToCountryCodes valueForKey:alpha2], [alpha2ToCountryNames valueForKey:alpha2]);
    }
}

+(NSArray*)allAlpha2s
{
    NSString* currentAlpha2 = [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
    if (!alpha2s || ![previousAlpha2 isEqualToString:currentAlpha2])
    {
        [TBI18nRegions initAlpha2Dictionaries];
    }
    return alpha2s;
}

+(NSDictionary*)alpha2ToCountryNameDic
{
    NSString* currentAlpha2 = [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
    if (!alpha2ToCountryNames || ![previousAlpha2 isEqualToString:currentAlpha2])
    {
        [TBI18nRegions initAlpha2Dictionaries];
    }
    return alpha2ToCountryNames;
}


+(NSDictionary*)alpha2ToCountryCodeDic
{
    NSString* currentAlpha2 = [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
    if (!alpha2ToCountryCodes || ![previousAlpha2 isEqualToString:currentAlpha2])
    {
        [TBI18nRegions initAlpha2Dictionaries];
    }
    return alpha2ToCountryCodes;
}

+(NSString*)countryCodeFor: (NSString*)alpha2
{
    return [[TBI18nRegions alpha2ToCountryCodeDic] valueForKey:alpha2];
}

+(NSString*)countryNameFor: (NSString*)alpha2
{
    return [[TBI18nRegions alpha2ToCountryNameDic] valueForKey:alpha2];
}
@end

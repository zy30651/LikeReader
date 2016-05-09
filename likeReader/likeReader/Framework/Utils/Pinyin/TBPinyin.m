//
//  TBPinyin.m
//  Framework
//
//  Created by ZY on 16/4/13.
//  Copyright © 2016年 AB. All rights reserved.
//
#import "TBPinyin.h"

@interface TBPinyin(){
    NSDictionary *_map;
}

@property (nonatomic, readonly) NSDictionary *map;

@end

static TBPinyin *instance = nil;

@implementation TBPinyin
+ (TBPinyin *)pinyin
{
    @synchronized(self)
    {
        if (instance == nil)
            instance = [[TBPinyin alloc] init]; 
    }
    return instance;
}


- (id)init
{
    if ((self = [super init])) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
        dispatch_async(queue, ^{
            [self map];
        });
    }
    return self;
}

- (NSDictionary *)map{
    if (!_map) {
        NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"TBPinyinMap" ofType:@"txt"]];
        _map = [data jsonValueDecoded];
    }
    return _map;
}
- (NSString *)processSortKeyForString:(NSString *)str{
    if (![str isKindOfClass:[NSString class]]||str.length == 0){
        return @"~";
    }
    while (!_map) {
        [NSThread sleepForTimeInterval:1.0];
    }
    
    NSString *regex = @"[A-Za-z]";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    NSMutableString *pinyinName   = [NSMutableString stringWithCapacity:20];
    for (int i = 0; i < [str length]; i++) {
        NSString *c = [str substringWithRange:NSMakeRange(i, 1)];
        NSString *aPinyin = [self.map objectForKey:c];
        if (aPinyin == nil){
            if ([predicate evaluateWithObject:c])
                aPinyin = c;
        }
        if (aPinyin) {
            [pinyinName appendString:[aPinyin firstCapitalLetterString]];
        }
    }
    return pinyinName;
}
- (NSString *)processString:(NSString *)str{
    if (![str isKindOfClass:[NSString class]]||str.length == 0){
        return @"~";
    }
    while (!_map) {
        [NSThread sleepForTimeInterval:1.0];
    }
    
    NSString *regex = @"[A-Za-z]";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    NSMutableString *pinyinName   = [NSMutableString stringWithCapacity:20];
    NSMutableString *pinyinSuoxie = [NSMutableString stringWithCapacity:20];
    NSMutableString *pinyinFirst = [NSMutableString stringWithCapacity:2];
    for (int i = 0; i < [str length]; i++) {
        NSString *c = [str substringWithRange:NSMakeRange(i, 1)];
        NSString *aPinyin = [self.map objectForKey:c];
        if (aPinyin == nil){
            if ([predicate evaluateWithObject:c])
                aPinyin = c;
        }
        if (aPinyin) {
            [pinyinSuoxie  appendString:[[aPinyin substringToIndex:1] lowercaseString]];
            [pinyinName appendString:[aPinyin lowercaseString]];
        }
        if (i==0) {
            if(aPinyin)
                [pinyinFirst appendString:[aPinyin substringToIndex:1]];
            else
                [pinyinFirst appendString:@"~"];
        }
    }
    return [NSString stringWithFormat:@"%@ %@ %@",pinyinName,pinyinSuoxie,pinyinFirst];
}
@end

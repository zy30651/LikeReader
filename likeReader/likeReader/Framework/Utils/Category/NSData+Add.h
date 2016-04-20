//
//  NSData+Add.h
//  Framework
//
//  Created by ZY on 16/4/13.
//  Copyright © 2016年 AB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Add)

/** 把Data数据转化为JSON数据，允许有错误 */
- (id)JSONParsedWithError:(NSError **)error;
/** 把Data数据转化为JSON数据 */
- (id)JSONParsed;


@end

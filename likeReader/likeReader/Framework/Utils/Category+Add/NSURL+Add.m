//
//  NSURL+Add.m
//  likeReader
//
//  Created by ZY on 16/5/18.
//  Copyright © 2016年 jack. All rights reserved.
//

#import "NSURL+Add.h"

@implementation NSURL (Add)

- (BOOL)addSkipBackupAttribute
{
    assert([[NSFileManager defaultManager] fileExistsAtPath: [self path]]);
    
    NSError *error = nil;
    BOOL success = [self setResourceValue: [NSNumber numberWithBool: YES]
                                   forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [self lastPathComponent], error);
    }
    return success;
}

@end

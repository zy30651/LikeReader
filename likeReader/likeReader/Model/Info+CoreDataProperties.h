//
//  Info+CoreDataProperties.h
//  likeReader
//
//  Created by ZY on 16/5/12.
//  Copyright © 2016年 jack. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Info.h"

NS_ASSUME_NONNULL_BEGIN

@interface Info (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *url;
@property (nullable, nonatomic, retain) NSString *text;

@end

NS_ASSUME_NONNULL_END

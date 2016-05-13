//
//  Record+CoreDataProperties.h
//  likeReader
//
//  Created by ZY on 16/5/12.
//  Copyright © 2016年 jack. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Record.h"

NS_ASSUME_NONNULL_BEGIN

@interface Record (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *autor;
@property (nullable, nonatomic, retain) NSString *url;
@property (nullable, nonatomic, retain) NSString *imgSrc;
@property (nullable, nonatomic, retain) NSString *sort;
@property (nullable, nonatomic, retain) NSString *path;
@property (nullable, nonatomic, retain) NSNumber *isShow;

@end

NS_ASSUME_NONNULL_END

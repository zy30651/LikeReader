//
//  Book+CoreDataProperties.h
//  likeReader
//
//  Created by ZY on 16/5/12.
//  Copyright © 2016年 jack. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Book.h"

NS_ASSUME_NONNULL_BEGIN

@interface Book (CoreDataProperties)

/** 作者 */
@property (nullable, nonatomic, retain) NSString *autor;
/** 小说简介 */
@property (nullable, nonatomic, retain) NSString *bookDesc;
/** 小说名字 */
@property (nullable, nonatomic, retain) NSString *name;
/** 最后一次更新时间 */
@property (nullable, nonatomic, retain) NSString *lastUpdateTime;
/** 小说封面图片Url */
@property (nullable, nonatomic, retain) NSString *imgSrc;
/** 小说Url */
@property (nullable, nonatomic, retain) NSString *url;

@end

NS_ASSUME_NONNULL_END

//
//  TBCalendarView.h
//  Framework
//
//  Created by ZY on 16/4/11.
//  Copyright © 2016年 AB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBCalendarView : UIView
/** 当前时间 */
@property (nonatomic, strong) NSDate *date;
/** 今天 */
@property (nonatomic, strong) NSDate *today;
/** Block点击事件 */
@property (nonatomic, copy) void(^calendarBlock) (NSInteger day,NSInteger month,NSInteger year);

@end

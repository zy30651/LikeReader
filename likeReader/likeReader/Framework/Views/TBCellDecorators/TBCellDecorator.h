//
//  TBCellDecorator.h
//  likeReader
//
//  Created by ZY on 16/5/6.
//  Copyright © 2016年 jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TBCellDecorator <NSObject>

@required
-(void) apply;
-(void) reset;

@optional
-(void) applyImmediate;

@end

@interface TBCellDecorator : NSObject

@property (nonatomic, weak) UITableViewCell* cell;

-(instancetype) initWithCell:(UITableViewCell*)cell;

@end
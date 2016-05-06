//
//  TBCell.h
//  likeReader
//
//  Created by ZY on 16/5/5.
//  Copyright © 2016年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBCellDecorator.h"

typedef enum
{
    cellFirstInSection  = 0,
    cellMiddleInSection = 1,
    cellLastInSection   = 2
} TBCellPosition;

@protocol TBCellDelegate <NSObject>

@required
/**
 * The cell identifier for reusable purpose, to be used
 * in TableView registerClass and deque.
 *
 * All subclasses must implement this method.
 */
+(NSString*) cellId;

@optional

/**
 * The default height of the cell. If a data driven height
 * method is not defined, the return value of this method
 * should be used in TableViewDataSource heightForCell
 */
+(CGFloat) defaultHeight;

/**
 * The height of the cell with the given content. The return
 * value of this method should be used in TableViewDataSource
 * heightForCell
 */
+(CGFloat) heightForContent:(id)content;

/**
 * The default left margin
 */
-(CGFloat) leftMargin;

/**
 * The default top margin
 */
-(CGFloat) topMargin;

/**
 * The default height (thickness) of the horizontal seperator
 * line between cells. default is 0.5
 */
-(CGFloat) seperatorLineHeight;

/**
 * The default color of the horizontal seperator line
 * between cells. Default is 0xdadada
 */
-(UIColor*) seperatorLineColor;

@end

extern NSString* const kTBCellDecoratorCheckBox;

@interface TBCell : UITableViewCell<TBCellDelegate>

@property (nonatomic, weak, readonly) UIView* viewSeperatorLine;

@property (nonatomic, assign) TBCellPosition position;
@property (nonatomic, assign) BOOL showSeperator;
@property (nonatomic, assign) BOOL showSeperatorForLastItem;
@property (nonatomic, copy) NSMutableDictionary* decorators;

-(CGFloat) heightForContent:(id)content;

-(id<TBCellDecorator>)decoratorByType:(NSString*)key;
-(void)setDecorator:(id<TBCellDecorator>)deco forType:(NSString*)key;

/**
 * Overiding point for initializing a cell in subclasses.
 */
-(void) initMe;

/**
 * Overiding point for laying out a cell in subclasses.
 *
 * This method is to be invoked by layoutSubviews. It is
 * advised to overide this method if necessary instead of
 * overiding the layoutSubviews directly.
 */
-(void) layoutMySubviews;

@end

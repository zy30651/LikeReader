//
//  TBTableViewController.h
//  JingHan
//
//  Created by ZY on 16/4/15.
//  Copyright © 2016年 AB. All rights reserved.
//

#import "TBViewController.h"
#import "TBCell.h"

@protocol TBTableViewControllerDelegate <TBViewControllerDelegate>

@required
-(void) registerCellClasses;

@optional
-(UIView*) emptyView;
-(void) handleLongPressAtIndexPath:(NSIndexPath*)indexPath;

@end
@interface TBTableViewController : TBViewController<TBTableViewControllerDelegate,UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>


@property (nonatomic, weak) UITableView* tableView;

@property (nonatomic, assign) UITableViewRowAnimation insertAnimation;
@property (nonatomic, assign) UITableViewRowAnimation deleteAnimation;
@property (nonatomic, assign) UITableViewRowAnimation updateAnimation;

@property (nonatomic, assign) BOOL editable;
@property (nonatomic, assign) BOOL enableLongPressRecognizer;
@property (nonatomic, assign) UITableViewStyle tableViewStyle;



-(void) initTableView;

-(void) performViewDidLoadSequence;
-(void) reloadView;

-(BOOL) viewEmpty;

-(CGPoint) emptyViewCenter;
-(void) reloadEmptyView;

-(void) initEditAnimations;

-(TBCellPosition)resolveCellPosition:(NSInteger)row
                           withCount:(NSInteger)count;

@end

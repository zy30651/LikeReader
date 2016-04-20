//
//  TBTableViewController.m
//  JingHan
//
//  Created by ZY on 16/4/15.
//  Copyright © 2016年 AB. All rights reserved.
//

#import "TBTableViewController.h"

@interface TBTableViewController ()
{
    UILongPressGestureRecognizer* _longPressGestureRecognizer;
}
@end

@implementation TBTableViewController


-(void) performViewDidLoadSequence
{
    [self initTableView];
    [self registerCellClasses];
    [self initEditAnimations];
    if (self.enableLongPressRecognizer)
    {
        UILongPressGestureRecognizer* longPressGestureReco = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(actionLongPress:)];
        longPressGestureReco.minimumPressDuration = 0.8;
        [self.tableView addGestureRecognizer:longPressGestureReco];
        _longPressGestureRecognizer = longPressGestureReco;
        _longPressGestureRecognizer.delegate = self;
    }
}

-(void) initTableView
{
    CGSize selfViewSize = self.view.size;
    CGFloat x = 0.0;
    CGFloat y = 0.0;
    CGFloat w = selfViewSize.width;
    CGFloat h = selfViewSize.height;
    UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectMake(x, y, w, h) style:self.tableViewStyle];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.bounces = NO;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

-(void) registerCellClasses
{
    // Subclasses to implement
}

-(void) reloadView
{
    // Subclasses to implement
}

-(void) initEditAnimations
{
    self.insertAnimation = UITableViewRowAnimationFade;
    self.updateAnimation = UITableViewRowAnimationFade;
    self.deleteAnimation = UITableViewRowAnimationFade;
}

#pragma mark - UILongPressGestureRecognizer
-(void) actionLongPress:(id)sender
{
    if (sender != _longPressGestureRecognizer)
    {
        return;
    }
    CGPoint pointPressed = [_longPressGestureRecognizer locationInView:self.tableView];
    NSIndexPath* indexPath = [self indexPathForPoint:pointPressed];
    [self handleLongPressAtIndexPath:indexPath];
}

-(NSIndexPath*) indexPathForPoint:(CGPoint)pointInView
{
    //    CGPoint contentOffset = self.tableView.contentOffset;
    //    CGFloat yInQuestion = contentOffset.y + pointInView.y;
    CGFloat yInQuestion = pointInView.y;
    CGFloat y = self.tableView.tableHeaderView.height;
    if (yInQuestion < y)
    {
        return nil;
    }
    NSInteger sectionCount = [self numberOfSectionsInTableView:self.tableView];
    NSInteger rowCount = 0;
    NSIndexPath* indexPath = nil;
    for (NSInteger section = 0; section < sectionCount; section++)
    {
        y += [self tableView:self.tableView heightForHeaderInSection:section];
        if (yInQuestion < y)
        {
            break;
        }
        rowCount = [self.tableView numberOfRowsInSection:section];
        for (NSInteger row = 0; row < rowCount; row++)
        {
            indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            y += [self tableView:self.tableView heightForRowAtIndexPath:indexPath];
            if (yInQuestion < y)
            {
                break;
            }
            indexPath = nil;
        }
        if (indexPath)
        {
            break;
        }
    }
    return indexPath;
}

-(void) handleLongPressAtIndexPath:(NSIndexPath*)indexPath
{
    // Subclass to implement
}

#pragma mark - empty view
-(BOOL) dataEmpty
{
    NSInteger dataCount = [self.controller.fetchedObjects count];
    return (0 == dataCount);
}

-(CGSize) emptyViewSize
{
    CGFloat w = [UIApplication sharedApplication].keyWindow.bounds.size.width;
    CGFloat h = self.view.height/2;//kHeightEmptyView;
    CGSize size = CGSizeMake(w, h);
    return size;
}
-(CGPoint) emptyViewCenter
{
    CGSize emptyViewSize = [self emptyViewSize];
    CGFloat x = self.tableView.width / 2;
    CGFloat top = (self.tableView.height - emptyViewSize.height)/4;
    CGFloat y = top + emptyViewSize.height/2;
    CGPoint point = CGPointMake(x, y);
    return point;
}

-(BOOL) viewEmpty
{
    if (!self.tableView)
    {
        return YES;
    }
    BOOL isEmpty = YES;
    NSUInteger nSec = [self numberOfSectionsInTableView:self.tableView];
    for (int i = 0; i < nSec; i++)
    {
        if ([self tableView:self.tableView numberOfRowsInSection:i] > 0)
        {
            isEmpty = NO;
            break;
        }
    }
    return isEmpty;
}


-(void) reloadEmptyView
{
    if (_viewForEmptyContent)
    {
        [_viewForEmptyContent removeFromSuperview];
    }
    if (![self dataEmpty] && ![self viewEmpty])
    {
//        self.tableView.footerHidden = NO;
    }
    else if (![self dataEmpty] && [self viewEmpty])
    {
        // Should be in a transient state while the tableView is being redrawn
        // with data from the controller
        // NOP
    }
    else if ([self dataEmpty] && ![self viewEmpty])
    {
        // Should be in a transient state while the tableView is being redrawn
        // - removing cells from the table
        // NOP
    }
    else // [self dataEmpty] && [self viewEmpty]
    {
        if (!_viewForEmptyContent)
        {
            _viewForEmptyContent = [self emptyView];
        }
        if (_viewForEmptyContent)
        {
            _viewForEmptyContent.center = [self emptyViewCenter];
            [self.tableView addSubview:_viewForEmptyContent];
//            self.tableView.footerHidden = YES;
        }
    }
}

#pragma mark - UITableViewDataSource implementation
-(NSInteger) tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"TBTableViewController subclasses must implement tableView:numberOfRowsInSection:");
    return 0;
}

-(UITableViewCell*) tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"TBTableViewController subclasses must implement tableView:cellForRowAtIndexPath:");
    return nil;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger numOfSections = [self.controller.sections count];
    return numOfSections;
}

-(NSArray*) sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSArray* sectionIndexTitles = self.controller.sectionIndexTitles;
    return sectionIndexTitles;
}

#pragma mark - UITableViewDelegate implementation
-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // If editable is set to YES, then the subclass must implement this method
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView
          editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Subclass must override this method to allow customized editing
    return UITableViewCellEditingStyleDelete;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Subclass must override this method to allow customized editing
    return @"删除";//[TBI18nStrings strForDelete];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Subclass must override this method if not every row is supposed to be editable
    return self.editable;
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Subclass must override this method if not every row is supposed to be editable
    return self.editable;
}
@end

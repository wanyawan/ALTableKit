//
//  ALTableSectionController.h
//  ALTableKitDemo
//
//  Created by Alex on 2018/12/5.
//  Copyright © 2018 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALTableContext.h"
#import "ALTableDisplayDelegate.h"
#import "ALTableScrollDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ALTableHeaderFooterViewSource <NSObject>

@property (nonatomic, strong, nullable, readwrite) NSNumber *sectionHeaderViewHeight;

@property (nonatomic, strong, nullable, readwrite) NSNumber *sectionFooterViewHeight;

- (CGFloat)heightForSectionHeaderView;

- (CGFloat)heightForSectionFooterView;

- (UIView *)sectionHeaderView;

- (UIView *)sectionFooterView;

@end

/**
 The base class for section controllers used in a section. This class is intended to be subclassed.
 ALTableSectionController 每一个section都要使用 需要继承这个类
 */
@interface ALTableSectionController : NSObject

/**
 The view controller housing the adapter that created this section controller.
 @note Use this view controller to push, pop, present, or do other custom transitions.
 ALTableAdapter 所属的viewcontroller
 */
@property (nonatomic, weak, nullable, readonly) UIViewController *viewController;

@property (nonatomic, weak, nullable, readonly) id<ALTableContext> tableContext;

/**
 ALTableSectionController cache cell height by indexpath. Default is yes;
 ALTableSectionController 用indexPath缓存cell高度 默认开启
 */
@property (nonatomic, assign) BOOL needCacheCellsHeight;

/**
 The UITableViewHeaderFooterView source for the section controller. Can be `nil`.
 @note You may wish to return `self` if your section controller implements this protocol.
 当前section UITableViewHeaderFooterView的数据源（一般为self 默认为nil）
 */
@property (nonatomic, weak, nullable) id <ALTableHeaderFooterViewSource> headerFooterViewSource;

/**
 An object that handles display events for the section controller. Can be `nil`.
 @note You may wish to return `self` if your section controller implements this protocol.
 当前section 处理展示事件的对象（一般为self 默认为nil）
 */
@property (nonatomic, weak, nullable) id <ALTableDisplayDelegate> displayDelegate;

/**
 An object that handles scroll events for the section controller. Can be `nil`.
 @note You may wish to return `self` if your section controller implements this protocol.
 当前section 处理滑动事件的对象（一般为self 默认为nil）
 */
@property (nonatomic, weak, nullable) id <ALTableScrollDelegate> scrollDelegate;

/**
 Returns the section within the table for this section controller.
 返回当前section controller 所在的section
 */
@property (nonatomic, assign, readonly) NSInteger section;

/**
 Returns `YES` if the section controller is the first section in the table, `NO` otherwise.
 如果是第一个section 返回`YES`
 */
@property (nonatomic, assign, readonly) BOOL isFirstSection;

/**
 Returns `YES` if the section controller is the last section in the table, `NO` otherwise.
 如果是最后一个section 返回`YES`
 */
@property (nonatomic, assign, readonly) BOOL isLastSection;

/**
 Updates the section controller to a new object.
 @param object The object mapped to this section controller.
 **Calling super is not required.**
 section controller 更新object（不需要调用super 方法)
 */
- (void)didUpdateToObject:(id)object;

/**
 Return the number of row in the section.
 返回当前section，rows的数量
 */
- (NSInteger)numberOfRows;

/**
 Returns the height for the row at index.
 返回 index cell的高度
 */
- (CGFloat)heightForRowAtIndex:(NSInteger)index;

/**
 Return a dequeued cell for a given index.
 @return A configured `UITableViewCell` subclass.
 **You must override this method without calling super.**
 返回 cell（必须重写这个方法）
 */
- (__kindof UITableViewCell *)cellForRowAtIndex:(NSInteger)index;

/**
 Tells the section controller that the cell at the specified index path was selected.
 **Calling super is not required.**
 选中第index个 cell 调用(不需要调用super 方法)
 */
- (void)didSelectRowAtIndex:(NSInteger)index;

/**
 Tells the section controller that the cell at the specified index path was deselected.
 **Calling super is not required.**
 取消选中第index个 cell 调用(不需要调用super 方法)
 */
- (void)didDeselectRowAtIndex:(NSInteger)index;

// TO DO
//- (void)didHighlightItemAtIndex:(NSInteger)index;
//
//- (void)didUnhighlightItemAtIndex:(NSInteger)index;
//
//- (BOOL)canMoveItemAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END

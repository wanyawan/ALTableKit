//
//  ALTableSectionProvider.h
//  ALTableKit
//
//  Created by Alex on 2018/12/21.
//  Copyright © 2018 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALTableContext.h"
#import "ALTableSectionController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ALTableSectionProvider : NSObject

/**
 The view controller housing the adapter that created this section provider.
 @note Use this view controller to push, pop, present, or do other custom transitions.
 ALTableSectionProvider 所属的viewcontroller
 */
@property (nonatomic, weak, nullable, readonly) UIViewController *viewController;

/**
 A context object for interacting with the tableview.
 Use this property for calculating height, dequeuing cells.
 拥有tableview上下文信息的对象 用于计算高度 重用cell
 */
@property (nonatomic, weak, nullable, readonly) id<ALTableContext> tableContext;

/**
 The section controller created this section provider.
 ALTableSectionProvider 所属的section controller
 */
@property (nonatomic, weak, nullable, readonly) ALTableSectionController *sectionController;

/**
 Updates the section provider to a new object.
 @param object The object mapped to this section provider.
 **Calling super is not required.**
 section provider 更新object（不需要调用super 方法)
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
 Tells the section provider that the cell at the specified index path was selected.
 **Calling super is not required.**
 选中第index个 cell 调用(不需要调用super 方法)
 */
- (void)didSelectRowAtIndex:(NSInteger)index;

/**
 Tells the section provider that the cell at the specified index path was deselected.
 **Calling super is not required.**
 取消选中第index个 cell 调用(不需要调用super 方法)
 */
- (void)didDeselectRowAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END

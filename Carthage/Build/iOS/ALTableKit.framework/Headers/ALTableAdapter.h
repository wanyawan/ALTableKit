//
//  ALTableAdapter.h
//  ALTableKit
//
//  Created by Alex on 2018/12/5.
//  Copyright © 2018 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ALTableKit/ALTableContext.h>
#import <ALTableKit/ALTableDataSource.h>
#import <ALTableKit/ALTableDelegate.h>
#import "ALTableAdapterUpdater.h"

NS_ASSUME_NONNULL_BEGIN

/**
 `ALTableAdapter` objects provide an abstraction for feeds of objects in a `UITableView` by breaking each object
 into individual sections, called "section controllers". These controllers (objects subclassing to
 `ALTableSectionController`) act as a data source and delegate for each section.

 Feed implementations must act as the data source for an `ALTableAdapter` in order to drive the objects and section
 controllers in a table view.
 ALTableAdapter 为UITableView 提供数据，把data source和delegate分发到每一个section controller
 */
@interface ALTableAdapter : NSObject

/**
 The view controller that houses the adapter.
 所属的view controller
 */
@property (nonatomic, nullable, weak) UIViewController *viewController;

/**
 The table view used with the adapter.
 ALTableAdapter 使用的tableview
 */
@property (nonatomic, nullable, weak) UITableView *tableView;

/**
 The object that acts as the data source for the adapter.
 为adapter 提供数据的对象
 */
@property (nonatomic, nullable, weak) id <ALTableDataSource> dataSource;

/**
 The object that receives display events for section controllers.
 接收ALTableAdapter展示事件的对象
 */
@property (nonatomic, nullable, weak) id <ALTableDelegate> delegate;

/**
 The object that receives `UITableViewDelegate` events.
 @note This object *will not* receive `UIScrollViewDelegate` events. Instead use scrollViewDelegate.
 接收UITableViewDelegate事件的对象（不能接收到UIScrollViewDelegate的事件）
 */
@property (nonatomic, nullable, weak) id <UITableViewDelegate> tableViewDelegate;

/**
 The object that receives `UIScrollViewDelegate` events.
 接收UIScrollViewDelegate事件的对象
 */
@property (nonatomic, nullable, weak) id <UIScrollViewDelegate> scrollViewDelegate;

/**
 Initializes a new `IGListAdapter` object.
 初始化IGListAdapter
 */
- (instancetype)initWithViewController:(UIViewController *)viewController NS_DESIGNATED_INITIALIZER;

/**
 Perform an immediate reload of the data in the data source, discarding the old objects.
 @param completion The block to execute when the reload completes.
 刷新tablev view 刷新完成会调用completion block
 */
- (void)reloadDataWithCompletion:(nullable ALTableUpdaterCompletion)completion;

/**
 Reload the table for only the specified objects.
 刷新已经存在的对象
 */
- (void)reloadObjects:(NSArray *)objects rowAnimation:(UITableViewRowAnimation)rowAnimation;

/**
 An unordered array of the currently visible section controllers.
 返回可见的section controllers
 */
- (NSArray<ALTableSectionController *> *)visibleSectionControllers;

/**
 Query the section controller at a given section index. Constant time lookup.
 返回section 位置的section controller
 */
- (nullable ALTableSectionController *)sectionControllerForSection:(NSInteger)section;

/**
 Query the section index of a section controller. Constant time lookup.
 @return The section index of the list if it exists, otherwise `NSNotFound`.
 返回section controller的位置 如果没找到返回 NSNotFound
 */
- (NSInteger)sectionForSectionController:(ALTableSectionController *)sectionController;

/**
 Fetch a section controller given an object. Can return nil.
 通过object 获取section controller 可以返回nil
 */
- (ALTableSectionController *)sectionControllerForObject:(id)object;

/**
 Returns the object corresponding to the specified section controller in the list. Constant time lookup.
 @return The object for the specified section controller, or `nil` if not found.
 在数据中查找 sectionController所属的object 没找到返回nil
 */
- (id)objectForSectionController:(ALTableSectionController *)sectionController;

/**
 Returns the object corresponding to a section in the list. Constant time lookup.
 @return The object for the specified section, or `nil` if the section does not exist.
 在数据中查找section 位置的object 没找到返回nil
 */
- (id)objectAtSection:(NSInteger)section;

/**
 Returns the section corresponding to the specified object in the list. Constant time lookup.
 @return The section index of `object` if found, otherwise `NSNotFound`.
 返回object 所在的位置 没找到返回 NSNotFound
 */
- (NSInteger)sectionForObject:(id)item;

/**
 Returns a copy of all the objects currently driving the adapter.
 @return An array of objects.
 返回adapter现在处理的对象的拷贝
 */
- (NSArray *)objects;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END

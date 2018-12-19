//
//  ALTableSectionMap.h
//  ALTableKitDemo
//
//  Created by Alex on 2018/12/5.
//  Copyright © 2018 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ALTableSectionController;

/**
 The ALTableSectionMap provides a way to map a table of objects to a collection of section controllers.
 ALTableSectionMap维护object、section controllers 和 section的关系
 */
@interface ALTableSectionMap : NSObject

@property (nonatomic, strong, readonly) NSArray *objects;

/**
 Update the map with objects and the section controller counterparts.
 更新所有的object 与对应的section controller
 */
- (void)updateWithObjects:(NSArray *)objects sectionControllers:(NSArray *)sectionControllers;

/**
 Update an object with a new instance.
 更新其中一个object
 */
- (void)updateObject:(id)object;

/**
 Remove all saved objects and section controllers.
 删除所有的object与section controllers
 */
- (void)reset;

- (nullable ALTableSectionController *)sectionControllerForObject:(id)object;

- (nullable ALTableSectionController *)sectionControllerForSection:(NSInteger)section;

- (NSInteger)sectionForSectionController:(id)sectionController;

- (NSInteger)sectionForObject:(id)object;

- (nullable id)objectForSection:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END

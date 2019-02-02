//
//  ALTableDataSource.h
//  ALTableKitDemo
//
//  Created by Alex on 2018/12/5.
//  Copyright © 2018 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ALTableKit/ALTableDiffable.h>

@class ALTableAdapter;
@class ALTableSectionController;

NS_ASSUME_NONNULL_BEGIN
/**
 This protocol represents the data model object.
  接收object在屏幕上展示相关的事件
 */
@protocol ALTableDataSource <NSObject>

- (NSArray<id <ALTableDiffable>> *)objectsForTableAdapter:(ALTableAdapter *)tableAdapter;

- (__kindof ALTableSectionController *)tableAdapter:(ALTableAdapter *)tableAdapter sectionControllerForObject:(id)object;

- (nullable UIView *)emptyViewForTableAdapter:(ALTableAdapter *)tableAdapter;

@end

NS_ASSUME_NONNULL_END

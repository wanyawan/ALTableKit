//
//  ALTableScrollDelegate.h
//  ALTableKitDemo
//
//  Created by Alex on 2018/12/7.
//  Copyright © 2018 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ALTableAdapter;
@class ALTableSectionController;

/**
 ALTableAdapter to receive display events for a section controller when it is on screen.
 ALTableAdapter 接收section controller在屏幕上展示相关的事件
 */
@protocol ALTableScrollDelegate <NSObject>

- (void)tableAdapter:(ALTableAdapter *)listAdapter didScrollSectionController:(ALTableSectionController *)sectionController;

- (void)tableAdapter:(ALTableAdapter *)listAdapter willBeginDraggingSectionController:(ALTableSectionController *)sectionController;

- (void)tableAdapter:(ALTableAdapter *)listAdapter didEndDraggingSectionController:(ALTableSectionController *)sectionController willDecelerate:(BOOL)decelerate;

- (void)tableAdapter:(ALTableAdapter *)listAdapter didEndDeceleratingSectionController:(ALTableSectionController *)sectionController;

@end

NS_ASSUME_NONNULL_END

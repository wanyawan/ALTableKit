//
//  ALTableDisplayDelegate.h
//  ALTableKitDemo
//
//  Created by Alex on 2018/12/6.
//  Copyright © 2018 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ALTableSectionController;
@class ALTableAdapter;

/**
 ALTableSectionController receive display events for a section controller when it is on screen.
 ALTableSectionController 接收section controller在屏幕上展示相关的事件
 */
@protocol ALTableDisplayDelegate <NSObject>

- (void)tableAdapter:(ALTableAdapter *)tableAdapter willDisplaySectionController:(ALTableSectionController *)sectionController;

- (void)tableAdapter:(ALTableAdapter *)tableAdapter didEndDisplayingSectionController:(ALTableSectionController *)sectionController;

- (void)tableAdapter:(ALTableAdapter *)tableAdapter willDisplaySectionController:(ALTableSectionController *)sectionController
                cell:(UITableViewCell *)cell
             atIndex:(NSUInteger)index;

- (void)tableAdapter:(ALTableAdapter *)tableAdapter didEndDisplayingSectionController:(ALTableSectionController *)sectionController
                cell:(UITableViewCell *)cell
             atIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END

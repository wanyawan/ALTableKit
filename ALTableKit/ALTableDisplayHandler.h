//
//  ALTableDisplayHandler.h
//  ALTableKitDemo
//
//  Created by Alex on 2018/12/6.
//  Copyright © 2018 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALTableSectionController;
@class ALTableAdapter;

NS_ASSUME_NONNULL_BEGIN

/**
 ALTableDisplayHandler to handle UITableViewCell or UITableViewHeaderFooterView display events.
 ALTableDisplayHandler 接收cell headerfooterview 在屏幕上展示相关的事件
 */
@interface ALTableDisplayHandler : NSObject

@property (nonatomic, strong, readonly) NSCountedSet<ALTableSectionController *> *visibleTableSections;

- (void)willDisplayCell:(UITableViewCell *)cell
        forTableAdapter:(ALTableAdapter *)tableAdapter
      sectionController:(ALTableSectionController *)sectionController
                 object:(id)object
              indexPath:(NSIndexPath *)indexPath;

- (void)didEndDisplayingCell:(UITableViewCell *)cell
             forTableAdapter:(ALTableAdapter *)tableAdapter
           sectionController:(ALTableSectionController *)sectionController
                   indexPath:(NSIndexPath *)indexPath;

- (void)willDisplayHeaderView:(__kindof UIView *)headerView
              forTableAdapter:(ALTableAdapter *)tableAdapter
            sectionController:(ALTableSectionController *)sectionController
                       object:(id)object
                    indexPath:(NSIndexPath *)indexPath;

- (void)didEndDisplayingHeaderView:(__kindof UIView *)headerView
                   forTableAdapter:(ALTableAdapter *)tableAdapter
                 sectionController:(ALTableSectionController *)sectionController
                         indexPath:(NSIndexPath *)indexPath;

- (void)willDisplayFooterView:(__kindof UIView *)footerView
              forTableAdapter:(ALTableAdapter *)tableAdapter
            sectionController:(ALTableSectionController *)sectionController
                       object:(id)object
                    indexPath:(NSIndexPath *)indexPath;

- (void)didEndDisplayingFooterView:(__kindof UIView *)footerView
                   forTableAdapter:(ALTableAdapter *)tableAdapter
                 sectionController:(ALTableSectionController *)sectionController
                         indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END

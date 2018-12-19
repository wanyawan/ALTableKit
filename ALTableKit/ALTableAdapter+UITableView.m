//
//  ALTableAdapter+UITableView.m
//  ALTableKitDemo
//
//  Created by Alex on 2018/12/5.
//  Copyright © 2018 Alex. All rights reserved.
//

#import "ALTableAdapter+UITableView.h"
#import "ALTableSectionMap.h"
#import "ALTableSectionController.h"
#import "ALTableAdapterInternal.h"
#import "ALTableDisplayHandler.h"
#import "ALTableAdapter+HeightCache.h"

@implementation ALTableAdapter (UITableView)

#pragma mark - Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionMap.objects.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ALTableSectionController * sectionController = [self sectionControllerForSection:section];
    const NSInteger numberOfItems = [sectionController numberOfRows];
    return numberOfItems;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = [self heightForRowAtIndexPath:indexPath];
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ALTableSectionController * sectionController = [self sectionControllerForSection:indexPath.section];
    UITableViewCell *cell = [sectionController cellForRowAtIndex:indexPath.item];
    [self mapView:cell toSectionController:sectionController];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:section];
    CGFloat height = [self heightForHeaderViewAtIndexPath:indexPath];
    return height;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ALTableSectionController * sectionController = [self sectionControllerForSection:section];
    if (sectionController.headerFooterViewSource) {
        return [sectionController.headerFooterViewSource sectionHeaderView];
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:section];
    CGFloat height = [self heightForFooterViewAtIndexPath:indexPath];
    return height;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    ALTableSectionController * sectionController = [self sectionControllerForSection:section];
    if (sectionController.headerFooterViewSource) {
        return [sectionController.headerFooterViewSource sectionFooterView];
    }
    return nil;
}

#pragma mark - Select Action

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    id <UITableViewDelegate> tableViewDelegate = self.tableViewDelegate;
    if ([tableViewDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [tableViewDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
    ALTableSectionController * sectionController = [self sectionControllerForSection:indexPath.section];
    [sectionController didSelectRowAtIndex:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    id <UITableViewDelegate> tableViewDelegate = self.tableViewDelegate;
    if ([tableViewDelegate respondsToSelector:@selector(tableView:didDeselectRowAtIndexPath:)]) {
        [tableViewDelegate tableView:tableView didDeselectRowAtIndexPath:indexPath];
    }
    ALTableSectionController * sectionController = [self sectionControllerForSection:indexPath.section];
    [sectionController didDeselectRowAtIndex:indexPath.row];
}

#pragma mark - Display

- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    id <UITableViewDelegate> tableViewDelegate = self.tableViewDelegate;
    if ([tableViewDelegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]) {
        [tableViewDelegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
    ALTableSectionController *sectionController = [self sectionControllerForView:cell];
    // if the section controller relationship was destroyed, reconnect it
    // this happens with iOS 10 UICollectionView display range changes
    if (sectionController == nil) {
        sectionController = [self sectionControllerForSection:indexPath.section];
        [self mapView:cell toSectionController:sectionController];
    }
    
    id object = [self.sectionMap objectForSection:indexPath.section];
    [self.displayHandler willDisplayCell:cell forTableAdapter:self sectionController:sectionController object:object indexPath:indexPath];
    
//    _isSendingWorkingRangeDisplayUpdates = YES;
//    [self.workingRangeHandler willDisplayItemAtIndexPath:indexPath forListAdapter:self];
//    _isSendingWorkingRangeDisplayUpdates = NO;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(nonnull UIView *)view forSection:(NSInteger)section {
    id <UITableViewDelegate> tableViewDelegate = self.tableViewDelegate;
    if ([tableViewDelegate respondsToSelector:@selector(tableView:willDisplayHeaderView:forSection:)]) {
        [tableViewDelegate tableView:tableView willDisplayHeaderView:view forSection:section];
    }
    ALTableSectionController *sectionController = [self sectionControllerForView:view];
    // if the section controller relationship was destroyed, reconnect it
    // this happens with iOS 10 UITableView display range changes
    if (sectionController == nil) {
        sectionController = [self.sectionMap sectionControllerForSection:section];
        [self mapView:view toSectionController:sectionController];
    }
    id object = [self.sectionMap objectForSection:section];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    [self.displayHandler willDisplayHeaderView:view forTableAdapter:self sectionController:sectionController object:object indexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(nonnull UIView *)view forSection:(NSInteger)section {
    id <UITableViewDelegate> tableViewDelegate = self.tableViewDelegate;
    if ([tableViewDelegate respondsToSelector:@selector(tableView:willDisplayFooterView:forSection:)]) {
        [tableViewDelegate tableView:tableView willDisplayFooterView:view forSection:section];
    }
    ALTableSectionController *sectionController = [self sectionControllerForView:view];
    // if the section controller relationship was destroyed, reconnect it
    // this happens with iOS 10 UITableView display range changes
    if (sectionController == nil) {
        sectionController = [self.sectionMap sectionControllerForSection:section];
        [self mapView:view toSectionController:sectionController];
    }
    id object = [self.sectionMap objectForSection:section];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    [self.displayHandler willDisplayFooterView:view forTableAdapter:self sectionController:sectionController object:object indexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    id <UITableViewDelegate> tableViewDelegate = self.tableViewDelegate;
    if ([tableViewDelegate respondsToSelector:@selector(tableView:didEndDisplayingCell:forRowAtIndexPath:)]) {
        [tableViewDelegate tableView:tableView didEndDisplayingCell:cell forRowAtIndexPath:indexPath];
    }
    ALTableSectionController *sectionController = [self sectionControllerForView:cell];
    [self.displayHandler didEndDisplayingCell:cell forTableAdapter:self sectionController:sectionController indexPath:indexPath];
    
//    [self.workingRangeHandler didEndDisplayingItemAtIndexPath:indexPath forListAdapter:self];
    // break the association between the cell and the section controller
    [self removeMapForView:cell];

}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(nonnull UIView *)view forSection:(NSInteger)section {
    id <UITableViewDelegate> tableViewDelegate = self.tableViewDelegate;
    if ([tableViewDelegate respondsToSelector:@selector(tableView:didEndDisplayingHeaderView:forSection:)]) {
        [tableViewDelegate tableView:tableView didEndDisplayingHeaderView:view forSection:section];
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    ALTableSectionController *sectionController = [self sectionControllerForView:view];
    [self.displayHandler didEndDisplayingHeaderView:view forTableAdapter:self sectionController:sectionController indexPath:indexPath];
    [self removeMapForView:view];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(nonnull UIView *)view forSection:(NSInteger)section {
    id <UITableViewDelegate> tableViewDelegate = self.tableViewDelegate;
    if ([tableViewDelegate respondsToSelector:@selector(tableView:didEndDisplayingFooterView:forSection:)]) {
        [tableViewDelegate tableView:tableView didEndDisplayingFooterView:view forSection:section];
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    ALTableSectionController *sectionController = [self sectionControllerForView:view];
    [self.displayHandler didEndDisplayingFooterView:view forTableAdapter:self sectionController:sectionController indexPath:indexPath];
    [self removeMapForView:view];
}

#pragma mark - ScrollviewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    id<UIScrollViewDelegate> scrollViewDelegate = self.scrollViewDelegate;
    if ([scrollViewDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [scrollViewDelegate scrollViewDidScroll:scrollView];
    }
    NSArray<ALTableSectionController *> *visibleSectionControllers = [self visibleSectionControllers];
    for (ALTableSectionController *sectionController in visibleSectionControllers) {
        id<ALTableScrollDelegate> scrollDelegate = [sectionController scrollDelegate];
        if ([scrollDelegate respondsToSelector:@selector(tableAdapter:didScrollSectionController:)]) {
            [scrollDelegate tableAdapter:self didScrollSectionController:sectionController];
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    id<UIScrollViewDelegate> scrollViewDelegate = self.scrollViewDelegate;
    if ([scrollViewDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [scrollViewDelegate scrollViewWillBeginDragging:scrollView];
    }
    NSArray<ALTableSectionController *> *visibleSectionControllers = [self visibleSectionControllers];
    for (ALTableSectionController *sectionController in visibleSectionControllers) {
        id<ALTableScrollDelegate> scrollDelegate = [sectionController scrollDelegate];
        if ([scrollDelegate respondsToSelector:@selector(tableAdapter:willBeginDraggingSectionController:)]) {
            [scrollDelegate tableAdapter:self willBeginDraggingSectionController:sectionController];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    id<UIScrollViewDelegate> scrollViewDelegate = self.scrollViewDelegate;
    if ([scrollViewDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [scrollViewDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
    NSArray<ALTableSectionController *> *visibleSectionControllers = [self visibleSectionControllers];
    for (ALTableSectionController *sectionController in visibleSectionControllers) {
        id<ALTableScrollDelegate> scrollDelegate = [sectionController scrollDelegate];
        if ([scrollDelegate respondsToSelector:@selector(tableAdapter:didEndDraggingSectionController:willDecelerate:)]) {
            [scrollDelegate tableAdapter:self didEndDraggingSectionController:sectionController willDecelerate:decelerate];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    id<UIScrollViewDelegate> scrollViewDelegate = self.scrollViewDelegate;
    if ([scrollViewDelegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [scrollViewDelegate scrollViewDidEndDecelerating:scrollView];
    }
    NSArray<ALTableSectionController *> *visibleSectionControllers = [self visibleSectionControllers];
    for (ALTableSectionController *sectionController in visibleSectionControllers) {
        id<ALTableScrollDelegate> scrollDelegate = [sectionController scrollDelegate];
        if ([scrollDelegate respondsToSelector:@selector(tableAdapter:didEndDeceleratingSectionController:)]) {
            [scrollDelegate tableAdapter:self didEndDeceleratingSectionController:sectionController];
        }
    }
}

#pragma mark - Edit

// to do

//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;

//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath;


@end

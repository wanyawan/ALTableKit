//
//  ALTableDisplayHandler.m
//  ALTableKitDemo
//
//  Created by Alex on 2018/12/6.
//  Copyright © 2018 Alex. All rights reserved.
//

#import <ALTableKit/ALTableAdapter.h>
#import <ALTableKit/ALTableSectionController.h>
#import <ALTableKit/ALTableAssert.h>
#import <ALTableKit/ALTableDelegate.h>
#import "ALTableDisplayHandler.h"

@interface ALTableDisplayHandler ()

@property (nonatomic, strong) NSMapTable *visibleViewObjectMap;

@end

@implementation ALTableDisplayHandler

- (instancetype)init {
    if (self = [super init]) {
        _visibleTableSections = [NSCountedSet new];
        _visibleViewObjectMap = [[NSMapTable alloc] initWithKeyOptions:NSMapTableStrongMemory valueOptions:NSMapTableStrongMemory capacity:0];
    }
    return self;
}

#pragma mark - Private API

- (id)_pluckObjectForView:(UIView *)view {
    NSMapTable *viewObjectMap = self.visibleViewObjectMap;
    id object = [viewObjectMap objectForKey:view];
    [viewObjectMap removeObjectForKey:view];
    return object;
}

- (void)_willDisplayReusableView:(UIView *)view
                 forTableAdapter:(ALTableAdapter *)tableAdapter
               sectionController:(ALTableSectionController *)sectionController
                          object:(id)object
                       indexPath:(NSIndexPath *)indexPath {
    ALParameterAssert(view != nil);
    ALParameterAssert(tableAdapter != nil);
    ALParameterAssert(indexPath != nil);
    
    if (object == nil || sectionController == nil) {
        return;
    }
    
    [self.visibleViewObjectMap setObject:object forKey:view];
    NSCountedSet *visibleListSections = self.visibleTableSections;
    if ([visibleListSections countForObject:sectionController] == 0) {
        [sectionController.displayDelegate tableAdapter:tableAdapter willDisplaySectionController:sectionController];
        [tableAdapter.delegate tableAdapter:tableAdapter willDisplayObject:object atIndex:indexPath.section];
    }
    [visibleListSections addObject:sectionController];
}

- (void)_didEndDisplayingReusableView:(UIView *)view
                      forTableAdapter:(ALTableAdapter *)tableAdapter
                    sectionController:(ALTableSectionController *)sectionController
                               object:(id)object
                            indexPath:(NSIndexPath *)indexPath {
    ALParameterAssert(view != nil);
    ALParameterAssert(tableAdapter != nil);
    ALParameterAssert(indexPath != nil);
    
    if (object == nil || sectionController == nil) {
        return;
    }
    
    const NSUInteger section = indexPath.section;
    
    NSCountedSet *visibleSections = self.visibleTableSections;
    [visibleSections removeObject:sectionController];
    
    if ([visibleSections countForObject:sectionController] == 0) {
        [sectionController.displayDelegate tableAdapter:tableAdapter didEndDisplayingSectionController:sectionController];
        [tableAdapter.delegate tableAdapter:tableAdapter didEndDisplayingObject:object atIndex:section];
    }
}

#pragma mark - Public API
- (void)willDisplayCell:(UITableViewCell *)cell
        forTableAdapter:(ALTableAdapter *)tableAdapter
      sectionController:(ALTableSectionController *)sectionController
                 object:(id)object
              indexPath:(NSIndexPath *)indexPath {
    [sectionController.displayDelegate tableAdapter:tableAdapter willDisplaySectionController:sectionController cell:cell atIndex:indexPath.row];
    [self _willDisplayReusableView:cell forTableAdapter:tableAdapter sectionController:sectionController object:object indexPath:indexPath];
}

- (void)didEndDisplayingCell:(UITableViewCell *)cell
             forTableAdapter:(ALTableAdapter *)tableAdapter
           sectionController:(ALTableSectionController *)sectionController
                   indexPath:(NSIndexPath *)indexPath {
    // if cell display events break, don't send cell events to the displayDelegate when the object has disappeared
    id object = [self _pluckObjectForView:cell];
    if (object == nil) {
        return;
    }
    [sectionController.displayDelegate tableAdapter:tableAdapter didEndDisplayingSectionController:sectionController cell:cell atIndex:indexPath.row];
    [self _didEndDisplayingReusableView:cell forTableAdapter:tableAdapter sectionController:sectionController object:object indexPath:indexPath];
}

- (void)willDisplayHeaderView:(__kindof UIView *)headerView
              forTableAdapter:(ALTableAdapter *)tableAdapter
            sectionController:(ALTableSectionController *)sectionController
                       object:(id)object
                    indexPath:(NSIndexPath *)indexPath {
    [self _willDisplayReusableView:headerView forTableAdapter:tableAdapter sectionController:sectionController object:object indexPath:indexPath];
}

- (void)didEndDisplayingHeaderView:(__kindof UIView *)headerView
                forTableAdapter:(ALTableAdapter *)tableAdapter
              sectionController:(ALTableSectionController *)sectionController
                      indexPath:(NSIndexPath *)indexPath {
    id object = [self _pluckObjectForView:headerView];
    [self _didEndDisplayingReusableView:headerView forTableAdapter:tableAdapter sectionController:sectionController object:object indexPath:indexPath];
}

- (void)willDisplayFooterView:(__kindof UIView *)footerView
              forTableAdapter:(ALTableAdapter *)tableAdapter
            sectionController:(ALTableSectionController *)sectionController
                       object:(id)object
                    indexPath:(NSIndexPath *)indexPath {
    [self _willDisplayReusableView:footerView forTableAdapter:tableAdapter sectionController:sectionController object:object indexPath:indexPath];
}

- (void)didEndDisplayingFooterView:(__kindof UIView *)footerView
                forTableAdapter:(ALTableAdapter *)tableAdapter
              sectionController:(ALTableSectionController *)sectionController
                      indexPath:(NSIndexPath *)indexPath {
    id object = [self _pluckObjectForView:footerView];
    [self _didEndDisplayingReusableView:footerView forTableAdapter:tableAdapter sectionController:sectionController object:object indexPath:indexPath];
}

@end

//
//  ALTableSectionController+PrivateMethods.m
//  ALTableKit
//
//  Created by Alex on 2018/12/21.
//  Copyright © 2018 Alex. All rights reserved.
//

#import "ALTableSectionController+PrivateMethods.h"
#import "ALTableSectionControllerInternal.h"

@implementation ALTableSectionController (PrivateMethods)

- (void)al_beforeUpdateToObject:(nullable id)object {
    if (self.cellHeightMap) {
        [self.cellHeightMap removeAllObjects];
    }
}

- (void)al_didUpdateToObject:(id)object {
    [self didUpdateToObject:object];
}

- (NSUInteger)al_numberOfRows {
    return [self numberOfRows];
}

- (CGFloat)al_heightForRowAtIndex:(NSUInteger)index {
    return [self heightForRowAtIndex:index];
}

- (UITableViewCell *)al_cellForRowAtIndex:(NSUInteger)index {
    return [self cellForRowAtIndex:index];
}

- (void)al_didSelectRowAtIndex:(NSUInteger)index {
    [self didSelectRowAtIndex:index];
}

- (void)al_didDeselectRowAtIndex:(NSUInteger)index {
    [self didDeselectRowAtIndex:index];
}

- (BOOL)al_canEditRowAtIndex:(NSUInteger)index {
    return [self canEditRowAtIndex:index];
}

- (UITableViewCellEditingStyle)al_editingStyleForRowAtIndex:(NSUInteger)index {
    return [self editingStyleForRowAtIndex:index];
}

- (nullable NSString *)al_titleForDeleteConfirmationButtonForRowAtIndex:(NSUInteger)index {
    return [self titleForDeleteConfirmationButtonForRowAtIndex:index];
}

- (void)al_commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndex:(NSUInteger)index {
    [self commitEditingStyle:editingStyle forRowAtIndex:index];
}

- (nullable NSArray<UITableViewRowAction *> *)al_editActionsForRowAtIndex:(NSUInteger)index NS_AVAILABLE_IOS(8_0) {
    return [self editActionsForRowAtIndex:index];
}

@end

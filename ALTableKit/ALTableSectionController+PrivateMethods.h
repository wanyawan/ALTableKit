//
//  ALTableSectionController+PrivateMethods.h
//  ALTableKit
//
//  Created by Alex on 2018/12/21.
//  Copyright © 2018 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALTableSectionController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ALTableSectionController (PrivateMethods)

- (void)al_beforeUpdateToObject:(nullable id)object;

- (void)al_didUpdateToObject:(id)object;

- (NSUInteger)al_numberOfRows;

- (CGFloat)al_heightForRowAtIndex:(NSUInteger)index;

- (__kindof UITableViewCell *)al_cellForRowAtIndex:(NSUInteger)index;

- (void)al_didSelectRowAtIndex:(NSUInteger)index;

- (void)al_didDeselectRowAtIndex:(NSUInteger)index;

- (BOOL)al_canEditRowAtIndex:(NSUInteger)index;

- (UITableViewCellEditingStyle)al_editingStyleForRowAtIndex:(NSUInteger)index;

- (nullable NSString *)al_titleForDeleteConfirmationButtonForRowAtIndex:(NSUInteger)index;

- (void)al_commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndex:(NSUInteger)index;

- (nullable NSArray<UITableViewRowAction *> *)al_editActionsForRowAtIndex:(NSUInteger)index NS_AVAILABLE_IOS(8_0);

@end

NS_ASSUME_NONNULL_END

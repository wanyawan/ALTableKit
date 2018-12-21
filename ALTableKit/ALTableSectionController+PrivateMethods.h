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

- (void)al_beforeUpdateToObject:(id)object;

- (void)al_didUpdateToObject:(id)object;

- (NSInteger)al_numberOfRows;

- (CGFloat)al_heightForRowAtIndex:(NSInteger)index;

- (__kindof UITableViewCell *)al_cellForRowAtIndex:(NSInteger)index;

- (void)al_didSelectRowAtIndex:(NSInteger)index;

- (void)al_didDeselectRowAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END

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

- (void)al_beforeUpdateToObject:(id)object {
    if (self.cellHeightMap) {
        [self.cellHeightMap removeAllObjects];
    }
}

- (void)al_didUpdateToObject:(id)object {
    [self didUpdateToObject:object];
}

- (NSInteger)al_numberOfRows {
    return [self numberOfRows];
}

- (CGFloat)al_heightForRowAtIndex:(NSInteger)index {
    return [self heightForRowAtIndex:index];
}

- (UITableViewCell *)al_cellForRowAtIndex:(NSInteger)index {
    return [self cellForRowAtIndex:index];
}

- (void)al_didSelectRowAtIndex:(NSInteger)index {
    [self didSelectRowAtIndex:index];
}

- (void)al_didDeselectRowAtIndex:(NSInteger)index {
    [self didDeselectRowAtIndex:index];
}


@end

//
//  ALTableSectionController.m
//  ALTableKitDemo
//
//  Created by Alex on 2018/12/5.
//  Copyright © 2018 Alex. All rights reserved.
//

#import "ALTableSectionController.h"
#import "ALTableSectionControllerInternal.h"
#import "ALTableAssert.h"

@implementation ALTableSectionController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.needCacheCellsHeight = YES;
    }
    return self;
}

- (void)setNeedCacheCellsHeight:(BOOL)needCacheCellsHeight {
    _needCacheCellsHeight = needCacheCellsHeight;
    if (needCacheCellsHeight) {
        if (!_cellHeightMap) {
            _cellHeightMap = [NSMapTable strongToStrongObjectsMapTable];
        }
    } else {
        _cellHeightMap = nil;
    }
}

#pragma mark -- Public Methods

- (void)didUpdateToObject:(id)object {}

- (NSInteger)numberOfRows {
    return 0;
}

- (CGFloat)heightForRowAtIndex:(NSInteger)index {
    return 0;
}

- (__kindof UITableViewCell *)cellForRowAtIndex:(NSInteger)index {
    ALFailAssert(@"Section controller %@ must override %s:", self, __PRETTY_FUNCTION__);
    return nil;
}

- (void)didSelectRowAtIndex:(NSInteger)index {}

- (void)didDeselectRowAtIndex:(NSInteger)index {}

#pragma mark -- Private Methods

//- (void)al_beforeUpdateToObject:(id)object {
//    if (_cellHeightMap) {
//        [_cellHeightMap removeAllObjects];
//    }
//}
//
//- (void)al_didUpdateToObject:(id)object {
//    [self didUpdateToObject:object];
//}
//
//- (NSInteger)al_numberOfRows {
//    return [self numberOfRows];
//}
//
//- (CGFloat)al_heightForRowAtIndex:(NSInteger)index {
//    return [self heightForRowAtIndex:index];
//}
//
//- (UITableViewCell *)al_cellForRowAtIndex:(NSInteger)index {
//    return [self al_cellForRowAtIndex:index];
//}
//
//- (void)al_didSelectRowAtIndex:(NSInteger)index {
//    [self didSelectRowAtIndex:index];
//}
//
//- (void)al_didDeselectRowAtIndex:(NSInteger)index {
//    [self al_didDeselectRowAtIndex:index];
//}


@end

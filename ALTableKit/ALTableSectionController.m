//
//  ALTableSectionController.m
//  ALTableKitDemo
//
//  Created by Alex on 2018/12/5.
//  Copyright © 2018 Alex. All rights reserved.
//

#import <ALTableKit/ALTableAssert.h>
#import "ALTableSectionControllerInternal.h"

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

@end

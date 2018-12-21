//
//  ALTableSectionProvider.m
//  ALTableKit
//
//  Created by Alex on 2018/12/21.
//  Copyright © 2018 Alex. All rights reserved.
//

#import "ALTableSectionProviderInternal.h"
#import "ALTableAssert.h"

@implementation ALTableSectionProvider

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

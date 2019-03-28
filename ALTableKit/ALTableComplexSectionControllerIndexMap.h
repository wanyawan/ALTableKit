//
//  ALTableComplexSectionControllerIndexMap.h
//  ALTableKit
//
//  Created by Alex on 2018/12/21.
//  Copyright © 2018 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ALTableSectionProvider;

/**
 'ALTableComplexSectionControllerIndexMap' maintains the relationship between cell absolute index, cell relative index and provier index.
 用于维护一个section中多个provider与cell的绝对位置、相对位置、provier的位置关系
 
 for example
 cell absolute index | 0  1  2 | 3  4  5 | 6  7 |
 cell relative index | 0  1  2 | 0  1  2 | 0  1 |
       provier index |    0    |    1    |  2   |
 */
@interface ALTableComplexSectionControllerIndexMap : NSObject

/**
 Update index map by section providers.
 通过section providers 更新位置信息
 */
- (void)updateIndexMapWithSectionProviders:(NSArray<ALTableSectionProvider *> *)sectionProviders;

/**
 Calculate the section provier index with cell absolute index.
 通过绝对位置计算在section provier的位置
 */
- (NSUInteger)sectionProviderAbsoluteIndexWithAbsoluteIndex:(NSUInteger)index;

/**
 Calculate the cell relative index with cell absolute index.
 通过绝对位置计算在section provier中的相对位置
 */
- (NSUInteger)sectionProviderRelativeIndexWithAbsoluteIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END

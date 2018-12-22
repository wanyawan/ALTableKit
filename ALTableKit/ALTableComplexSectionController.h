//
//  ALTableComplexSectionController.h
//  ALTableKit
//
//  Created by Alex on 2018/12/21.
//  Copyright © 2018 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ALTableKit/ALTableSectionController.h>

NS_ASSUME_NONNULL_BEGIN

@class ALTableSectionProvider;
/**
 'ALTableComplexSectionController' used in a section. This class is intended to be subclassed.
 'ALTableComplexSectionController' through multiple 'ALTableSectionProvider' to achieve functions.
 ALTableSectionController 每一个section都要使用 需要继承这个类 它通过多个ALTableSectionProvider实现功能
 */
@interface ALTableComplexSectionController : ALTableSectionController

/**
 - (void)didUpdateToObject:(id)object;
 - (NSInteger)numberOfRows;
 - (CGFloat)heightForRowAtIndex:(NSInteger)index;
 - (__kindof UITableViewCell *)cellForRowAtIndex:(NSInteger)index;
 - (void)didSelectRowAtIndex:(NSInteger)index;
 - (void)didDeselectRowAtIndex:(NSInteger)index;
 
 In this class, these methods are useless.
 Need to use ALTableSectionProvider to achieve the above functions.
 上面这些方法都没有用了 需要使用ALTableSectionProvider来完成上面的功能
 */
@property (nonatomic, strong, readonly) NSArray <ALTableSectionProvider *> *sectionProviders;

/**
 Create the section providers to a new object.
 通过object创建一些新的section provider
 */
- (NSArray <ALTableSectionProvider *> *)updateSectionProvidersWithObject:(id)object;

@end

NS_ASSUME_NONNULL_END

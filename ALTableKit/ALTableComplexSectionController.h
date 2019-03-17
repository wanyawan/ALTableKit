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
 Updates the section provider to a new object.
 @param object The object mapped to this section provider.
 **Calling super is not required.**
 section controller 更新object（不需要调用super 方法)
 */
- (void)didUpdateToObject:(id)object;

/**
 - (NSUInteger)numberOfRows;
 - (CGFloat)heightForRowAtIndex:(NSUInteger)index;
 - (__kindof UITableViewCell *)cellForRowAtIndex:(NSUInteger)index;
 - (void)didSelectRowAtIndex:(NSUInteger)index;
 - (void)didDeselectRowAtIndex:(NSUInteger)index;
 - (BOOL)canEditRowAtIndex:(NSUInteger)index;
 - (UITableViewCellEditingStyle)editingStyleForRowAtIndex:(NSUInteger)index;
 - (nullable NSString *)titleForDeleteConfirmationButtonForRowAtIndex:(NSUInteger)index;
 - (void)commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndex:(NSUInteger)index;
 - (nullable NSArray<UITableViewRowAction *> *)editActionsForRowAtIndex:(NSUInteger)index NS_AVAILABLE_IOS(8_0);
 In this class, these methods are useless.
 Need to use ALTableSectionProvider to achieve the above functions.
 **Calling super is not required.**
 上面这些方法都没有用了 需要使用ALTableSectionProvider来完成上面的功能
 */
- (NSArray <ALTableSectionProvider *> *)updateSectionProvidersWithObject:(id)object;

/**
 Return existing sectionProviders.
 通过object创建一些新的section provider
 */
@property (nonatomic, strong, readonly) NSArray <ALTableSectionProvider *> *sectionProviders;

@end

NS_ASSUME_NONNULL_END

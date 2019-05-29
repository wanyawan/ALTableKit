//
//  ALTableContext.h
//  ALTableKit
//
//  Created by Alex on 2018/12/5.
//  Copyright © 2018 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ALTableSectionController;

/**
 The tableview context provides limited access to the collection-related information that
 section controllers need for operations like calculating height, dequeuing cells.
 tableview 上下文信息 用于计算高度 重用cell
 */
@protocol ALTableContext <NSObject>

@property (nonatomic, readonly) CGSize containerSize;

- (__kindof UITableViewCell *)dequeueReusableCellOfClass:(Class)cellClass
                                     withReuseIdentifier:(nullable NSString *)reuseIdentifier
                                    forSectionController:(ALTableSectionController *)sectionController;

- (__kindof UITableViewCell *)dequeueReusableCellOfClass:(Class)cellClass
                                    forSectionController:(ALTableSectionController *)sectionController;

- (__kindof UITableViewCell *)dequeueReusableCellFromStoryboardWithIdentifier:(NSString *)identifier
                                                         forSectionController:(ALTableSectionController *)sectionController;


- (__kindof UITableViewCell *)dequeueReusableCellWithNibName:(NSString *)nibName
                                             reuseIdentifier:(nullable NSString *)reuseIdentifier
                                                      bundle:(nullable NSBundle *)bundle
                                        forSectionController:(ALTableSectionController *)sectionController;

- (__kindof UITableViewCell *)dequeueReusableCellWithNibName:(NSString *)nibName
                                                      bundle:(nullable NSBundle *)bundle
                                        forSectionController:(ALTableSectionController *)sectionController;

- (__kindof UITableViewHeaderFooterView *)dequeueReusableHeaderFooterViewOfClass:(Class)viewClass
                                                             withReuseIdentifier:(nullable NSString *)reuseIdentifier
                                                            forSectionController:(ALTableSectionController *)sectionController;

- (__kindof UITableViewHeaderFooterView *)dequeueReusableHeaderFooterViewOfClass:(Class)viewClass
                                                            forSectionController:(ALTableSectionController *)sectionController;

- (__kindof UITableViewHeaderFooterView *)dequeueReusableHeaderFooterViewWithNibName:(NSString *)nibName
                                                                     reuseIdentifier:(nullable NSString *)reuseIdentifier
                                                                              bundle:(nullable NSBundle *)bundle
                                                                forSectionController:(ALTableSectionController *)sectionController;

- (__kindof UITableViewHeaderFooterView *)dequeueReusableHeaderFooterViewWithNibName:(NSString *)nibName
                                                                              bundle:(nullable NSBundle *)bundle
                                                                forSectionController:(ALTableSectionController *)sectionController;


- (CGFloat)heightForCellWithClass:(Class)cellClass
                    configuration:(void(^)(__kindof UITableViewCell *cell))configuration;

- (CGFloat)heightForCellWithClass:(Class)cellClass
                  reuseIdentifier:(nullable NSString *)reuseIdentifier
                    configuration:(void(^)(__kindof UITableViewCell *cell))configuration;

- (CGFloat)heightForCellWithNibName:(NSString *)nibName
                             bundle:(nullable NSBundle *)bundle
                      configuration:(void(^)(__kindof UITableViewCell *cell))configuration;

- (CGFloat)heightForCellWithNibName:(NSString *)nibName
                    reuseIdentifier:(nullable NSString *)reuseIdentifier
                             bundle:(nullable NSBundle *)bundle
                      configuration:(void(^)(UITableViewCell *cell))configuration;

- (CGFloat)heightForHeaderFooterViewOfClass:(Class)viewClass
                              configuration:(void (^)(__kindof UITableViewHeaderFooterView *))configuration;


- (CGFloat)heightForHeaderFooterViewOfClass:(Class)viewClass
                        withReuseIdentifier:(nullable NSString *)reuseIdentifier
                              configuration:(void (^)(__kindof UITableViewHeaderFooterView *))configuration;

- (CGFloat)heightForHeaderFooterViewWithNibName:(NSString *)nibName
                                         bundle:(nullable NSBundle *)bundle
                                   onfiguration:(void (^)(__kindof UITableViewHeaderFooterView *))configuration;

- (CGFloat)heightForHeaderFooterViewWithNibName:(NSString *)nibName
                                reuseIdentifier:(nullable NSString *)reuseIdentifier
                                         bundle:(nullable NSBundle *)bundle
                                  configuration:(void (^)(__kindof UITableViewHeaderFooterView *))configuration;


- (void)setEditing:(BOOL)editing animated:(BOOL)animated;

// TO DO
// - insertSections ...

@end

NS_ASSUME_NONNULL_END

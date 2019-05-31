//
//  ALTableAdapter+ALTableContext.m
//  ALTableKitDemo
//
//  Created by Alex on 2018/12/6.
//  Copyright © 2018 Alex. All rights reserved.
//

#import "ALTableAdapter+ALTableContext.h"
#import "ALTableAdapterInternal.h"
#import <ALTableKit/ALTableSectionController.h>
#import <objc/runtime.h>

static inline NSString *ALTableReusableViewIdentifier(Class viewClass, NSString * _Nullable nibName, NSString * _Nullable kind, NSString * _Nullable givenReuseIdentifier) {
    return [NSString stringWithFormat:@"%@%@%@%@", kind ?: @"", nibName ?: @"",viewClass ? NSStringFromClass(viewClass):@"", givenReuseIdentifier ?: @""];
}

@implementation ALTableAdapter (ALTableContext)

- (CGSize)containerSize {
    return self.tableView.bounds.size;
}

- (__kindof UITableViewCell *)dequeueReusableCellOfClass:(Class)cellClass
                                     withReuseIdentifier:(NSString *)reuseIdentifier
                                    forSectionController:(ALTableSectionController *)sectionController {
    UITableView *tableView = self.tableView;
    NSString *identifier = ALTableReusableViewIdentifier(cellClass, nil, nil, reuseIdentifier);
    if (![self.registeredCellClasses containsObject:cellClass]) {
        [self.registeredCellClasses addObject:cellClass];
        [tableView registerClass:cellClass forCellReuseIdentifier:identifier];
    }
    return [tableView dequeueReusableCellWithIdentifier:identifier];
}

- (__kindof UITableViewCell *)dequeueReusableCellOfClass:(Class)cellClass
                                    forSectionController:(ALTableSectionController *)sectionController {
    return [self dequeueReusableCellOfClass:cellClass withReuseIdentifier:nil forSectionController:sectionController];
}

- (__kindof UITableViewCell *)dequeueReusableCellFromStoryboardWithIdentifier:(NSString *)identifier
                                                         forSectionController:(ALTableSectionController *)sectionController {
    UITableView *tableView = self.tableView;
    return [tableView dequeueReusableCellWithIdentifier:identifier];
}


- (__kindof UITableViewCell *)dequeueReusableCellWithNibName:(NSString *)nibName
                                             reuseIdentifier:(NSString *)reuseIdentifier
                                                      bundle:(nullable NSBundle *)bundle
                                        forSectionController:(ALTableSectionController *)sectionController {
    UITableView *tableView = self.tableView;
    NSString *identifier = ALTableReusableViewIdentifier(nil, nibName, nil, reuseIdentifier);
    if (![self.registeredNibNames containsObject:nibName]) {
        [self.registeredNibNames addObject:nibName];
        UINib *nib = [UINib nibWithNibName:nibName bundle:bundle];
        [tableView registerNib:nib forCellReuseIdentifier:identifier];
    }
    return [tableView dequeueReusableCellWithIdentifier:identifier];
}

- (__kindof UITableViewCell *)dequeueReusableCellWithNibName:(NSString *)nibName
                                                      bundle:(nullable NSBundle *)bundle
                                        forSectionController:(ALTableSectionController *)sectionController {
    return [self dequeueReusableCellWithNibName:nibName reuseIdentifier:nil bundle:bundle forSectionController:sectionController];
    
}

- (__kindof UITableViewHeaderFooterView *)dequeueReusableHeaderFooterViewOfClass:(Class)viewClass
                                                             withReuseIdentifier:(NSString *)reuseIdentifier
                                                            forSectionController:(ALTableSectionController *)sectionController {
    UITableView *tableView = self.tableView;
    NSString *identifier = ALTableReusableViewIdentifier(viewClass, nil, nil, reuseIdentifier);
    
    if (![self.registeredHeaderFooterViewIdentifiers containsObject:identifier]) {
        [self.registeredHeaderFooterViewIdentifiers addObject:identifier];
        [tableView registerClass:viewClass forHeaderFooterViewReuseIdentifier:identifier];
    }
    return [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
}

- (__kindof UITableViewHeaderFooterView *)dequeueReusableHeaderFooterViewOfClass:(Class)viewClass
                                                            forSectionController:(ALTableSectionController *)sectionController {
    return [self dequeueReusableHeaderFooterViewOfClass:viewClass withReuseIdentifier:nil forSectionController:sectionController];
}

- (__kindof UITableViewHeaderFooterView *)dequeueReusableHeaderFooterViewWithNibName:(NSString *)nibName
                                                                     reuseIdentifier:(NSString *)reuseIdentifier
                                                                              bundle:(nullable NSBundle *)bundle
                                                                forSectionController:(ALTableSectionController *)sectionController {
    UITableView *tableView = self.tableView;
    NSString *identifier = ALTableReusableViewIdentifier(nil, nibName, nil, reuseIdentifier);
    
    if (![self.registeredHeaderFooterViewNibNames containsObject:identifier]) {
        [self.registeredHeaderFooterViewNibNames addObject:identifier];
        UINib *nib = [UINib nibWithNibName:nibName bundle:bundle];
        [tableView registerNib:nib forHeaderFooterViewReuseIdentifier:identifier];
    }
    return [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
}

- (__kindof UITableViewHeaderFooterView *)dequeueReusableHeaderFooterViewWithNibName:(NSString *)nibName
                                                                              bundle:(nullable NSBundle *)bundle
                                                                forSectionController:(ALTableSectionController *)sectionController {
    return [self dequeueReusableHeaderFooterViewWithNibName:nibName reuseIdentifier:nil bundle:bundle forSectionController:sectionController];
}

#pragma --mark calculate height

- (CGFloat)heightForCellWithClass:(Class)cellClass
                    configuration:(void(^)(__kindof UITableViewCell *cell))configuration {
    return [self heightForCellWithClass:cellClass reuseIdentifier:nil configuration:configuration];
}

- (CGFloat)heightForCellWithClass:(Class)cellClass
                  reuseIdentifier:(nullable NSString *)reuseIdentifier
                    configuration:(void(^)(__kindof UITableViewCell *cell))configuration {
    UITableView *tableView = self.tableView;
    NSString *identifier = ALTableReusableViewIdentifier(cellClass, nil, nil, reuseIdentifier);
    if (![self.registeredCellClasses containsObject:cellClass]) {
        [self.registeredCellClasses addObject:cellClass];
        [tableView registerClass:cellClass forCellReuseIdentifier:identifier];
    }
    UITableViewCell *templeteCell = [self al_templateCellForReuseIdentifier:identifier];
    [templeteCell prepareForReuse];
    if (configuration) {
        configuration(templeteCell);
    }
    return [self al_systemFittingHeightForConfiguratedCell:templeteCell];
}

- (CGFloat)heightForCellWithNibName:(NSString *)nibName
                             bundle:(nullable NSBundle *)bundle
                      configuration:(void(^)(__kindof UITableViewCell *cell))configuration {
    return [self heightForCellWithNibName:nibName reuseIdentifier:nil bundle:bundle configuration:configuration];
}

- (CGFloat)heightForCellWithNibName:(NSString *)nibName
                    reuseIdentifier:(nullable NSString *)reuseIdentifier
                             bundle:(nullable NSBundle *)bundle
                      configuration:(void(^)(__kindof UITableViewCell *cell))configuration {
    UITableView *tableView = self.tableView;
    NSString *identifier = ALTableReusableViewIdentifier(nil, nibName, nil, reuseIdentifier);
    if (![self.registeredNibNames containsObject:nibName]) {
        [self.registeredNibNames addObject:nibName];
        UINib *nib = [UINib nibWithNibName:nibName bundle:bundle];
        [tableView registerNib:nib forCellReuseIdentifier:identifier];
    }
    UITableViewCell *templeteCell = [self al_templateCellForReuseIdentifier:identifier];
    [templeteCell prepareForReuse];
    if (configuration) {
        configuration(templeteCell);
    }
    return [self al_systemFittingHeightForConfiguratedCell:templeteCell];
}

- (CGFloat)heightForHeaderFooterViewOfClass:(Class)viewClass
                              configuration:(void (^)(__kindof UITableViewHeaderFooterView *))configuration {
    return [self heightForHeaderFooterViewOfClass:viewClass withReuseIdentifier:nil configuration:configuration];
}


- (CGFloat)heightForHeaderFooterViewOfClass:(Class)viewClass
                        withReuseIdentifier:(nullable NSString *)reuseIdentifier
                              configuration:(void (^)(__kindof UITableViewHeaderFooterView *))configuration {
    UITableView *tableView = self.tableView;
    NSString *identifier = ALTableReusableViewIdentifier(viewClass, nil, nil, reuseIdentifier);
    if (![self.registeredHeaderFooterViewIdentifiers containsObject:identifier]) {
        [self.registeredHeaderFooterViewIdentifiers addObject:identifier];
        [tableView registerClass:viewClass forHeaderFooterViewReuseIdentifier:identifier];
    }
    UITableViewHeaderFooterView *templateHeaderFooterView = [self al_templateHeaderFooterViewForReuseIdentifier:identifier];
    [templateHeaderFooterView prepareForReuse];
    if (configuration) {
        configuration(templateHeaderFooterView);
    }
    return [self al_systemFittingHeightForConfiguratedHeaderFooterView:templateHeaderFooterView];
}

- (CGFloat)heightForHeaderFooterViewWithNibName:(NSString *)nibName
                                         bundle:(nullable NSBundle *)bundle
                                   onfiguration:(void (^)(__kindof UITableViewHeaderFooterView *))configuration {
    return [self heightForHeaderFooterViewWithNibName:nibName reuseIdentifier:nil bundle:bundle configuration:configuration];
}

- (CGFloat)heightForHeaderFooterViewWithNibName:(NSString *)nibName
                                reuseIdentifier:(nullable NSString *)reuseIdentifier
                                         bundle:(nullable NSBundle *)bundle
                                  configuration:(void (^)(__kindof UITableViewHeaderFooterView *))configuration {
    UITableView *tableView = self.tableView;
    NSString *identifier = ALTableReusableViewIdentifier(nil, nibName, nil, reuseIdentifier);
    if (![self.registeredHeaderFooterViewNibNames containsObject:identifier]) {
        [self.registeredHeaderFooterViewNibNames addObject:identifier];
        UINib *nib = [UINib nibWithNibName:nibName bundle:bundle];
        [tableView registerNib:nib forHeaderFooterViewReuseIdentifier:identifier];
    }
    UITableViewHeaderFooterView *templateHeaderFooterView = [self al_templateHeaderFooterViewForReuseIdentifier:identifier];
    if (configuration) {
        configuration(templateHeaderFooterView);
    }
    return [self al_systemFittingHeightForConfiguratedHeaderFooterView:templateHeaderFooterView];
}

#pragma --mark edit
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [self.tableView setEditing:editing animated:animated];
}

#pragma --mark private method

- (__kindof UITableViewCell *)al_templateCellForReuseIdentifier:(NSString *)identifier {
    NSMutableDictionary<NSString *, UITableViewCell *> *templateCellsByIdentifiers = objc_getAssociatedObject(self, _cmd);
    if (!templateCellsByIdentifiers) {
        templateCellsByIdentifiers = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, templateCellsByIdentifiers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    UITableViewCell *templateCell = templateCellsByIdentifiers[identifier];
    if (!templateCell) {
        templateCell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
        templateCell.contentView.translatesAutoresizingMaskIntoConstraints = NO;
        templateCellsByIdentifiers[identifier] = templateCell;
    }
    return templateCell;
}

- (CGFloat)al_systemFittingHeightForConfiguratedCell:(UITableViewCell *)cell {
    CGFloat contentViewWidth = CGRectGetWidth(self.tableView.frame);
    
    CGRect cellBounds = cell.bounds;
    cellBounds.size.width = contentViewWidth;
    cell.bounds = cellBounds;
    
    CGFloat rightSystemViewsWidth = 0.0;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITableViewIndex")]) {
            rightSystemViewsWidth = CGRectGetWidth(view.frame);
            break;
        }
    }
    
    // If a cell has accessory view or system accessory type, its content view's width is smaller
    // than cell's by some fixed values.
    if (cell.accessoryView) {
        rightSystemViewsWidth += 16 + CGRectGetWidth(cell.accessoryView.frame);
    } else {
        static const CGFloat systemAccessoryWidths[] = {
            [UITableViewCellAccessoryNone] = 0,
            [UITableViewCellAccessoryDisclosureIndicator] = 34,
            [UITableViewCellAccessoryDetailDisclosureButton] = 68,
            [UITableViewCellAccessoryCheckmark] = 40,
            [UITableViewCellAccessoryDetailButton] = 48
        };
        rightSystemViewsWidth += systemAccessoryWidths[cell.accessoryType];
    }
    
    if ([UIScreen mainScreen].scale >= 3 && [UIScreen mainScreen].bounds.size.width >= 414) {
        rightSystemViewsWidth += 4;
    }
    
    contentViewWidth -= rightSystemViewsWidth;
    
    // If not using auto layout, you have to override "-sizeThatFits:" to provide a fitting size by yourself.
    // This is the same height calculation passes used in iOS8 self-sizing cell's implementation.
    //
    // 1. Try "- systemLayoutSizeFittingSize:" first. (skip this step if 'fd_enforceFrameLayout' set to YES.)
    // 2. Warning once if step 1 still returns 0 when using AutoLayout
    // 3. Try "- sizeThatFits:" if step 1 returns 0
    // 4. Use a valid height or default row height (44) if not exist one
    
    CGFloat fittingHeight = 0;
    
    if (contentViewWidth > 0) {
        // Add a hard width constraint to make dynamic content views (like labels) expand vertically instead
        // of growing horizontally, in a flow-layout manner.
        NSLayoutConstraint *widthFenceConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:contentViewWidth];
        
        // [bug fix] after iOS 10.3, Auto Layout engine will add an additional 0 width constraint onto cell's content view, to avoid that, we add constraints to content view's left, right, top and bottom.
        static BOOL isSystemVersionEqualOrGreaterThen10_2 = NO;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            isSystemVersionEqualOrGreaterThen10_2 = [UIDevice.currentDevice.systemVersion compare:@"10.2" options:NSNumericSearch] != NSOrderedAscending;
        });
        
        NSArray<NSLayoutConstraint *> *edgeConstraints;
        if (isSystemVersionEqualOrGreaterThen10_2) {
            // To avoid confilicts, make width constraint softer than required (1000)
            widthFenceConstraint.priority = UILayoutPriorityRequired - 1;
            
            // Build edge constraints
            NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
            NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
            NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
            NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
            edgeConstraints = @[leftConstraint, rightConstraint, topConstraint, bottomConstraint];
            [cell addConstraints:edgeConstraints];
        }
        
        [cell.contentView addConstraint:widthFenceConstraint];
        
        // Auto layout engine does its math
        fittingHeight = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        
        // Clean-ups
        [cell.contentView removeConstraint:widthFenceConstraint];
        if (isSystemVersionEqualOrGreaterThen10_2) {
            [cell removeConstraints:edgeConstraints];
        }
        
    }
    
    if (fittingHeight == 0) {
#if DEBUG
        // Warn if using AutoLayout but get zero height.
        if (cell.contentView.constraints.count > 0) {
            if (!objc_getAssociatedObject(self, _cmd)) {
                NSLog(@"[FDTemplateLayoutCell] Warning once only: Cannot get a proper cell height (now 0) from '- systemFittingSize:'(AutoLayout). You should check how constraints are built in cell, making it into 'self-sizing' cell.");
                objc_setAssociatedObject(self, _cmd, @YES, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        }
#endif
        // Try '- sizeThatFits:' for frame layout.
        // Note: fitting height should not include separator view.
        fittingHeight = [cell sizeThatFits:CGSizeMake(contentViewWidth, 0)].height;
        
    }
    
    // Still zero height after all above.
    if (fittingHeight == 0) {
        // Use default row height.
        fittingHeight = 44;
    }
    
    // Add 1px extra space for separator line if needed, simulating default UITableViewCell.
    if (self.tableView.separatorStyle != UITableViewCellSeparatorStyleNone) {
        fittingHeight += 1.0 / [UIScreen mainScreen].scale;
    }
    
    return fittingHeight;
}

- (__kindof UITableViewHeaderFooterView *)al_templateHeaderFooterViewForReuseIdentifier:(NSString *)identifier {
    NSMutableDictionary<NSString *, UITableViewHeaderFooterView *> *templateHeaderFooterViews = objc_getAssociatedObject(self, _cmd);
    if (!templateHeaderFooterViews) {
        templateHeaderFooterViews = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, templateHeaderFooterViews, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    UITableViewHeaderFooterView *templateHeaderFooterView = templateHeaderFooterViews[identifier];
    if (!templateHeaderFooterView) {
        templateHeaderFooterView = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
        templateHeaderFooterView.contentView.translatesAutoresizingMaskIntoConstraints = NO;
        templateHeaderFooterViews[identifier] = templateHeaderFooterView;
    }
    return templateHeaderFooterView;
}

- (CGFloat)al_systemFittingHeightForConfiguratedHeaderFooterView:(UITableViewHeaderFooterView *)templateHeaderFooterView {
    NSLayoutConstraint *widthFenceConstraint = [NSLayoutConstraint constraintWithItem:templateHeaderFooterView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:CGRectGetWidth(self.tableView.frame)];
    [templateHeaderFooterView addConstraint:widthFenceConstraint];
    CGFloat fittingHeight = [templateHeaderFooterView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    [templateHeaderFooterView removeConstraint:widthFenceConstraint];
    if (fittingHeight == 0) {
        fittingHeight = [templateHeaderFooterView sizeThatFits:CGSizeMake(CGRectGetWidth(self.tableView.frame), 0)].height;
    }
    return fittingHeight;
}

@end

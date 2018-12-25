//
//  ALTableAdapter+ALTableContext.m
//  ALTableKitDemo
//
//  Created by Alex on 2018/12/6.
//  Copyright © 2018 Alex. All rights reserved.
//

#import "ALTableAdapter+ALTableContext.h"
#import "ALTableAdapterInternal.h"

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

@end

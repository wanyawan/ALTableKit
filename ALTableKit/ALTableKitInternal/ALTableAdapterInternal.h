//
//  ALTableAdapterInternal.h
//  ALTableKitDemo
//
//  Created by Alex on 2018/12/5.
//  Copyright © 2018 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALTableAdapter.h"

NS_ASSUME_NONNULL_BEGIN

@class ALTableSectionMap;
@class ALTableAdapterProxy;
@class ALTableDisplayHandler;

@interface ALTableAdapter ()

@property (nonatomic, strong, readonly) ALTableSectionMap *sectionMap;
@property (nonatomic, strong, readonly) ALTableAdapterUpdater *updater;
@property (nonatomic, strong, readonly) ALTableDisplayHandler *displayHandler;
@property (nonatomic, strong, nullable) ALTableAdapterProxy *delegateProxy;

@property (nonatomic, strong, readonly) NSMutableSet<Class> *registeredCellClasses;
@property (nonatomic, strong, readonly) NSMutableSet<NSString *> *registeredNibNames;
@property (nonatomic, strong, readonly) NSMutableSet<NSString *> *registeredHeaderFooterViewIdentifiers;
@property (nonatomic, strong, readonly) NSMutableSet<NSString *> *registeredHeaderFooterViewNibNames;

- (void)mapView:(UIView *)view toSectionController:(ALTableSectionController *)sectionController;

- (nullable ALTableSectionController *)sectionControllerForView:(UIView *)view;

- (void)removeMapForView:(UIView *)view;


@end

NS_ASSUME_NONNULL_END


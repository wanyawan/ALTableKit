//
//  ALTableSectionControllerInternal.h
//  ALTableKitDemo
//
//  Created by Alex on 2018/12/5.
//  Copyright © 2018 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALTableSectionController.h"
#import "ALTablePrivateContext.h"

NS_ASSUME_NONNULL_BEGIN

@interface ALTableSectionController ()

@property (nonatomic, weak, nullable, readwrite) UIViewController *viewController;

@property (nonatomic, weak, nullable, readwrite) id<ALTablePrivateContext> tableContext;

@property (nonatomic, strong, nullable, readwrite) NSMapTable <NSNumber *,NSNumber *> *cellHeightMap;

@property (nonatomic, assign, readwrite) NSUInteger section;

@property (nonatomic, assign, readwrite) BOOL isFirstSection;

@property (nonatomic, assign, readwrite) BOOL isLastSection;

@end

NS_ASSUME_NONNULL_END

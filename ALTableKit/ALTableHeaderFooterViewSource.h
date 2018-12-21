//
//  ALTableHeaderFooterViewSource.h
//  ALTableKit
//
//  Created by Alex on 2018/12/22.
//  Copyright © 2018 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ALTableHeaderFooterViewSource <NSObject>

@property (nonatomic, strong, nullable, readwrite) NSNumber *sectionHeaderViewHeight;

@property (nonatomic, strong, nullable, readwrite) NSNumber *sectionFooterViewHeight;

- (CGFloat)heightForSectionHeaderView;

- (CGFloat)heightForSectionFooterView;

- (UIView *)sectionHeaderView;

- (UIView *)sectionFooterView;

@end

NS_ASSUME_NONNULL_END

//
//  ALTableHeaderFooterViewSource.h
//  ALTableKit
//
//  Created by Alex on 2018/12/22.
//  Copyright © 2018 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ALTableHeaderFooterViewSource <NSObject>

- (CGFloat)heightForSectionHeaderView;

- (CGFloat)heightForSectionFooterView;

- (UIView *)sectionHeaderView;

- (UIView *)sectionFooterView;

@end

NS_ASSUME_NONNULL_END

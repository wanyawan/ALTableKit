//
//  ALTableAdapter+HeightCache.m
//  xcf-iphone
//
//  Created by Alex on 2018/12/5.
//  Copyright © 2018 Alex. All rights reserved.
//

#import "ALTableAdapter+HeightCache.h"
#import "ALTableAdapterInternal.h"
#import "ALTableSectionControllerInternal.h"
#import "ALTableSectionController+PrivateMethods.h"

@implementation ALTableAdapter (HeightCache)

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ALTableSectionController *section = [self sectionControllerForSection:indexPath.section];
    NSNumber *height = [section.cellHeightMap objectForKey:@(indexPath.row)];
    if (height) {
        return height.floatValue;
    } else {
        CGFloat cellHeight = [section al_heightForRowAtIndex:indexPath.row];
        [section.cellHeightMap setObject:[NSNumber numberWithFloat:cellHeight] forKey:@(indexPath.row)];
        return cellHeight;
    }
}

- (CGFloat)heightForHeaderViewAtIndexPath:(NSIndexPath *)indexPath {
    ALTableSectionController *section = [self sectionControllerForSection:indexPath.section];
    if (section.headerFooterViewSource) {
        if (section.headerFooterViewSource.sectionHeaderViewHeight) {
            return section.headerFooterViewSource.sectionHeaderViewHeight.floatValue;
        }else {
            CGFloat headerViewHeight = [section.headerFooterViewSource heightForSectionHeaderView];
            section.headerFooterViewSource.sectionHeaderViewHeight = [NSNumber numberWithFloat:headerViewHeight];
            return headerViewHeight;
        }
    }
    return CGFLOAT_MIN;
}

- (CGFloat)heightForFooterViewAtIndexPath:(NSIndexPath *)indexPath {
    ALTableSectionController *section = [self sectionControllerForSection:indexPath.section];
    if (section.headerFooterViewSource) {
        if (section.headerFooterViewSource.sectionFooterViewHeight) {
            return section.headerFooterViewSource.sectionFooterViewHeight.floatValue;
        }else {
            CGFloat footerViewHeight = [section.headerFooterViewSource heightForSectionFooterView];
            section.headerFooterViewSource.sectionFooterViewHeight = [NSNumber numberWithFloat:footerViewHeight];
            return footerViewHeight;
        }
    }
    return CGFLOAT_MIN;
}


@end

//
//  DemoSectionController.m
//  ALTableKitDemo
//
//  Created by Alex on 2018/12/29.
//  Copyright © 2018 Alex. All rights reserved.
//

#import "DemoSectionController.h"
#import "SimpleModel.h"
#import "DemoTableViewCell.h"
#import "DemoTableViewCellWithXib.h"

@implementation DemoSectionController
{
    SimpleModel *_model;
}

- (void)didUpdateToObject:(id)object {
    _model = object;
}

- (NSInteger)numberOfRows {
    return 2;
}

- (CGFloat)heightForRowAtIndex:(NSInteger)index {
    return 50;
}

- (UITableViewCell *)cellForRowAtIndex:(NSInteger)index {
    if (index == 0) {
        DemoTableViewCell *cell = [self.tableContext dequeueReusableCellOfClass:[DemoTableViewCell class]
                                                           forSectionController:self];
        cell.textLabel.text = [NSString stringWithFormat:@"cell section %zd index %zd (class)", self.section, index];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        DemoTableViewCellWithXib *cell = [self.tableContext dequeueReusableCellWithNibName:NSStringFromClass([DemoTableViewCellWithXib class])
                                                                                    bundle:nil
                                                                      forSectionController:self];
        cell.textLabel.text = [NSString stringWithFormat:@"cell section %zd index %zd (xib)", self.section, index];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)didSelectRowAtIndex:(NSInteger)index {
    
}

@end

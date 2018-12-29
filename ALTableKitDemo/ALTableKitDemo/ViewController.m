//
//  ViewController.m
//  ALTableKitDemo
//
//  Created by Alex on 2018/12/22.
//  Copyright © 2018 Alex. All rights reserved.
//

#import "ViewController.h"
#import "SimpleModel.h"
#import "ComplexModel.h"
#import <ALTableKit/ALTableKit.h>
#import <Masonry/Masonry.h>
#import "DemoSectionController.h"
#import "DemoComplexSectionController.h"

@interface ViewController () <ALTableDataSource>

@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) ALTableAdapter *adapter;
@property (nonatomic, strong) NSArray *data;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];
    [_table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.adapter.tableView = _table;
    [self getTestData];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)getTestData {
/**
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
|   cell 0(class) |             | section 0 row 0 |                    |
 - - - - - - - - -   section 0   - - - - - - - - -     SimpleModel     |
|   cell 1(xib)   |             | section 0 row 1 |                    |
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
|      cell 2     |  provier 0  | section 1 row 0 |                    |
 - - - - - - - - - - - - - - - - - - - - - - - - -     ComplexModel    |
|   cell (hidden) |  provier 1  |     section 1   | Second cell Hidden |
 - - - - - - - - - - - - - - - - - - - - - - - - -                     |
|      cell 3     |  provier 2  | section 1 row 1 |                    |
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
|      cell 4     |  provier 0  | section 0 row 0 |                    |
 - - - - - - - - - - - - - - - - - - - - - - - - -     ComplexModel    |
|      cell 5     |  provier 1  | section 0 row 1 |  Second cell show  |
 - - - - - - - - - - - - - - - - - - - - - - - - -                     |
|      cell 6     |  provier 2  | section 0 row 2 |                    |
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Test Model
*/
    SimpleModel *first = [SimpleModel new];
    ComplexModel *second = [ComplexModel new];
    second.showSectionRow = NO;
    ComplexModel *third = [ComplexModel new];
    third.showSectionRow = YES;
    _data = @[first, second, third];
    [self.adapter reloadDataWithCompletion:nil];
}

#pragma mark -- Getters & Setters

- (ALTableAdapter *)adapter {
    if (!_adapter) {
        _adapter = [[ALTableAdapter alloc]initWithViewController:self];
        _adapter.dataSource = self;
    }
    return _adapter;
}

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [UIView new];
        _backgroundView.frame = self.view.bounds;
        UILabel *label = [UILabel new];
        label.frame = _backgroundView.frame;
        label.font = [UIFont systemFontOfSize:15];
        label.text = @"no data";
        label.textAlignment = NSTextAlignmentCenter;
        [_backgroundView addSubview:label];
    }
    return _backgroundView;
}

#pragma mark -- DataSource

- (NSArray<id <ALTableDiffable>> *)objectsForTableAdapter:(ALTableAdapter *)tableAdapter {
    return _data;
}

- (__kindof ALTableSectionController *)tableAdapter:(ALTableAdapter *)tableAdapter sectionControllerForObject:(id)object {
    //
    if ([object isKindOfClass:[SimpleModel class]]) {
        return [DemoSectionController new];
    }else {
        return [DemoComplexSectionController new];
    }
}

- (nullable UIView *)emptyViewForTableAdapter:(ALTableAdapter *)tableAdapter {
    return self.backgroundView;
}

@end

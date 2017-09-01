//
//  NAPaperViewController.m
//  NAVi
//
//  Created by dxc on 15-3-4.
//  Copyright (c) 2015年 dxc. All rights reserved.
//

#import "NAPaperViewController.h"
#import "NAPaperTableViewCell.h"

@interface NAPaperViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tView;

@end

@implementation NAPaperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
}

#pragma mark - utility -
#pragma mark

- (void)initViews
{
    [super initViews];
    self.title = NSLocalizedString(@"Paper List", nil);
    self.navigationItem.leftBarButtonItem = self.backBtnItem;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tView];
}

- (void)updateViews
{
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    CGFloat navHeight = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    self.tView.frame = CGRectMake(0, navHeight, width, height - navHeight);

}

#pragma mark - layout -
#pragma mark

- (UITableView *)tView
{
    if (!_tView) {
        _tView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tView.delegate = self;
        _tView.dataSource = self;
        _tView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tView;
}

#pragma mark - tableView delegate -
#pragma mark

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    NAPaperTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[NAPaperTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.leftView.tag = indexPath.row * 2 + 1;
    cell.rightView.tag = indexPath.row * 2 + 2;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


@end

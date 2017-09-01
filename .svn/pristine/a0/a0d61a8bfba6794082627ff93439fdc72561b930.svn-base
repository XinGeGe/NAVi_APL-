//
//  NAHomeViewController.m
//  NAVi
//
//  Created by xiaoyu.zhang on 15/10/23.
//  Copyright © 2015年 dxc. All rights reserved.
//

#import "NAHomeViewController.h"

@interface NAHomeViewController ()

@end

@implementation NAHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/**
 * view更新
 *
 */
- (void)updateViews
{
    if (isPhone) {
        // 第１面を表示
        NSInteger tempPageIndex = 0;
        if (self.pageArray.count > 0) {
            //tempPageIndex = [self currentIndexInPages:self.currentPageIndex curPagerIndexNo:curPaperIndexNo];
            tempPageIndex = self.pageArray.count - 1 - self.currentPageIndex;
            
        }
        self.mainScrollView.currentItemIndex = tempPageIndex;
        // NSLog(@"tempPageIndex==%d",tempPageIndex);
        [self.mainScrollView scrollToItemAtIndex:tempPageIndex duration:0.3];
    }
    
    CGFloat screenWidth = self.view.frame.size.width;
    CGFloat screenHeight = self.view.frame.size.height;
    
    CGFloat barHeight = self.homeToolBar.frame.size.height;
    CGFloat progressHeight = PROGRESS_HEIGHT;
    self.searchBarItem.customView.frame=CGRectMake(self.searchBarItem.customView.frame.origin.x, self.searchBarItem.customView.frame.origin.y, self.navigationController.navigationBar.frame.size.height-4, self.navigationController.navigationBar.frame.size.height-4);
    self.refreshBarItem.customView.frame=CGRectMake(self.refreshBarItem.customView.frame.origin.x, self.refreshBarItem.customView.frame.origin.y, self.navigationController.navigationBar.frame.size.height-4, self.navigationController.navigationBar.frame.size.height-4);
    self.navigationItem.titleView.frame=CGRectMake(self.navigationItem.titleView.frame.origin.x, self.navigationItem.titleView.frame.origin.y, self.navigationController.navigationBar.frame.size.height, self.navigationController.navigationBar.frame.size.height);
    
    self.toolBar.frame=CGRectMake(0, screenHeight - barHeight, self.view.frame.size.width, barHeight);
    self.homeToolBar.frame = CGRectMake(0, screenHeight - barHeight, self.view.frame.size.width, barHeight);
    self.mainScrollView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    //        NASubImageScrollView *subView=(NASubImageScrollView *)self.mainScrollView.currentItemView;
    //        [subView updateFrame:self.mainScrollView.frame];
    //subView.frame=CGRectMake(subView.frame.origin.x, subView.frame.origin.y, screenWidth, screenWidth*subView.frame.size.height/subView.frame.size.width);
    // download barを設定
    self.progressViewBar.frame = CGRectMake(0, screenHeight - barHeight - progressHeight, screenWidth, progressHeight);
    [self.progressViewBar updateViews];
    [self.progressViewBar setStatus:NSLocalizedString(@"imageloading", nil)];
    
    // パージ一覧
    self.popoverBackground.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    
    self.mylogoview.frame=self.view.bounds;
    if ([self isLandscape]) {
        self.mylogoview.image=[UIImage imageNamed:@"nextep_logo_blue_1024_768.png"];
    }else{
        self.mylogoview.image=[UIImage imageNamed:@"nextep_logo_blue.png"];
    }
    self.MyPopview.frame=CGRectMake(2, screenHeight-160, 50, 100);
}

/**
 * main画面を表示
 *
 */
-(void)showMainView{
    // 画面にmainScrollViewを追加
    [self.view addSubview:self.mainScrollView];
    [self.view sendSubviewToBack:self.mainScrollView];
    
    NSLog(@"mainScrollView show") ;
    NSInteger tempPageIndex = 0;
    
    if ([self isLandscape]) {
        // 2紙面を表示
        NSArray *pages = [self padLandscapeCount];
        if (pages.count > 0) {
            tempPageIndex = pages.count - 1;
        }
    }else{
        // 1紙面を表示
        if (self.pageArray.count > 0) {
            tempPageIndex = self.pageArray.count - 1;
            
        }
    }
    
    // 第１面を表示
    self.mainScrollView.currentItemIndex = tempPageIndex;
    [self.mainScrollView scrollToItemAtIndex: tempPageIndex duration:0];
    
    // 後処理
    [super swipeViewCurrentItemIndexDidChange:self.mainScrollView];
    [super swipeViewDidEndDecelerating:self.mainScrollView];
    
    if (self.pageArray.count == 1) {
        self.mainScrollView.wrapEnabled = NO;
        self.mainScrollView.scrollEnabled = NO;
    }
    
    if ( [NASaveData getISFastNews]==1) {
        UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        ;
        UIButton  *menubtn = [UIButton buttonWithType:UIButtonTypeCustom];
        menubtn.frame = CGRectMake(0, 0, 60, 49);
        [menubtn setImage:[UIImage imageNamed:@"menu_menu_on"] forState:UIControlStateNormal];
        [menubtn addTarget:self action:@selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];
        menubtn.backgroundColor = [UIColor clearColor];
        UIBarButtonItem *menubar= [[UIBarButtonItem alloc] initWithCustomView:menubtn];
        
        UIButton  *pagebtn = [UIButton buttonWithType:UIButtonTypeCustom];
        pagebtn.frame = CGRectMake(0, 0, 60, 49);
        [pagebtn setImage:[UIImage imageNamed:@"menu_paper_on"] forState:UIControlStateNormal];
        pagebtn.backgroundColor = [UIColor clearColor];
        
        UIBarButtonItem *pagebar= [[UIBarButtonItem alloc] initWithCustomView:pagebtn];
        [pagebar setTintColor:[UIColor whiteColor]];
        
        UIButton  *sokuhobtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sokuhobtn.frame = CGRectMake(0, 0, 60, 49);
        [sokuhobtn setImage:[UIImage imageNamed:@"menu_sokuho_off"] forState:UIControlStateNormal];
        [sokuhobtn addTarget:self action:@selector(sokuhoClick:) forControlEvents:UIControlEventTouchUpInside];
        sokuhobtn.backgroundColor = [UIColor clearColor];
        UIBarButtonItem *sokuhobar=[[UIBarButtonItem alloc] initWithCustomView:sokuhobtn];
        
        UIButton  *settingbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        settingbtn.frame = CGRectMake(0, 0, 60, 49);
        [settingbtn setImage:[UIImage imageNamed:@"menu_setting_off"] forState:UIControlStateNormal];
        [settingbtn addTarget:self action:@selector(showSetting:) forControlEvents:UIControlEventTouchUpInside];
        settingbtn.backgroundColor = [UIColor clearColor];
        UIBarButtonItem *settingbar= [[UIBarButtonItem alloc] initWithCustomView:settingbtn];
        
        self.toolBar.items=[NSArray arrayWithObjects:menubar,spaceButtonItem,pagebar,spaceButtonItem,sokuhobar,spaceButtonItem,settingbar,nil];
        if (![self.view.subviews containsObject:self.toolBar]) {
            [self.view addSubview:self.toolBar];
        }
    }else{
        if (![self.view.subviews containsObject:self.homeToolBar]) {
            [self.view addSubview:self.homeToolBar];
        }
    }
    
    [self updateViews];
    [self updateToolbar];
    [ProgressHUD dismiss];
    [self.mylogoview removeFromSuperview];
    if ([self.forwardPage isEqualToString:@"sukuho"]) {
        self.forwardPage=@"";
        if ([NASaveData getFirstDownload]==1) {
            [super toSokuhoViewController];
        }
    }
}

@end

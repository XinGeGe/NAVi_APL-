//
//  NAHomeViewController.m
//  NAVi
//
//  Created by xiaoyu.zhang on 15/10/22.
//  Copyright © 2015年 dxc. All rights reserved.
//

#import "NAHomeViewController.h"

@interface NAHomeViewController ()

@end

@implementation NAHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationItem.title = @"公明新闻";
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = self.searchBarItem;
    self.navigationItem.rightBarButtonItem = self.webBarItem;
    UIImageView *titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"rangai_daiji"]];
    self.navigationItem.titleView = titleView;
    if ([self isLandscape]) {
        self.riliView.hidden = YES;
        
        [self setHorToolBar];
    }else{
        self.toolBarStyle = 0;
        self.riliView.hidden = NO;
        [self resetHomeToolBar];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
//    
//    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
//}
//
//- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
//    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
//}

/**
 * view更新
 *
 */
- (void)updateViews
{
    CGFloat screenWidth = self.view.frame.size.width;
    CGFloat screenHeight = self.view.frame.size.height;
    
    CGFloat barHeight = self.homeToolBar.frame.size.height;
    CGFloat progressHeight = PROGRESS_HEIGHT;
    self.searchBarItem.customView.frame=CGRectMake(self.searchBarItem.customView.frame.origin.x, self.searchBarItem.customView.frame.origin.y, (self.navigationController.navigationBar.frame.size.height-4)/2 +5, (self.navigationController.navigationBar.frame.size.height-4)/2 + 5);
    self.webBarItem.customView.frame=CGRectMake(self.webBarItem.customView.frame.origin.x, self.webBarItem.customView.frame.origin.y, (self.navigationController.navigationBar.frame.size.height-4)/2 + 5, (self.navigationController.navigationBar.frame.size.height-4)/2 + 5);
    self.navigationItem.titleView.frame=CGRectMake(self.navigationItem.titleView.frame.origin.x, self.navigationItem.titleView.frame.origin.y, self.navigationController.navigationBar.frame.size.height, self.navigationController.navigationBar.frame.size.height);
    if (isPhone) {
        self.toolBar.frame=CGRectMake(0, screenHeight - 44, self.view.frame.size.width, 44);
        self.progressViewBar.frame = CGRectMake(0, screenHeight - 44 - progressHeight, screenWidth, progressHeight);
    }else{
        self.toolBar.frame=CGRectMake(0, screenHeight - 49, self.view.frame.size.width, 49);
        self.progressViewBar.frame = CGRectMake(0, screenHeight - 49 - progressHeight, screenWidth, progressHeight);
    }
    //self.toolBar.frame=CGRectMake(0, screenHeight - barHeight, self.view.frame.size.width, barHeight);
    self.homeToolBar.frame = CGRectMake(0, screenHeight - barHeight, self.view.frame.size.width, barHeight);
    //self.mainScrollView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    
    // download barを設定
    //self.progressViewBar.frame = CGRectMake(0, screenHeight - barHeight - progressHeight, screenWidth, progressHeight);
    [self.progressViewBar updateViews];
    [self.progressViewBar setStatus:NSLocalizedString(@"imageloading", nil)];
    
    // パージ一覧
    self.popoverBackground.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    if ([Util screenSize].width>[Util screenSize].height) {
        //横屏
        if(isPad){
            self.mainScrollView.frame = CGRectMake(0, 0, [Util screenSize].width, [Util screenSize].height-64-49);
            self.mylogoview.image=[UIImage imageNamed:@"nextep_logo_blue_1024_768.png"];
        }else{
            self.mainScrollView.frame = CGRectMake(0, 0, [Util screenSize].width, [Util screenSize].height-34-44);
            self.mylogoview.image=[UIImage imageNamed:@"nextep_logo_blue_667.png"];
        }
    }else{
        //竖屏
        if(isPad){
            self.mainScrollView.frame = CGRectMake(0, 40, [Util screenSize].width, [Util screenSize].height-64-49-40);
            self.mylogoview.image=[UIImage imageNamed:@"nextep_logo_blue_1024_768.png"];
        }else{
            self.mainScrollView.frame = CGRectMake(0, -30, [Util screenSize].width, [Util screenSize].height-10);
            self.mylogoview.image=[UIImage imageNamed:@"nextep_logo_blue_667.png"];
        }
    }

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
        self.riliView.hidden = YES;
        [self setHorToolBar];
    }else{
        // 1紙面を表示
        if (self.pageArray.count > 0) {
            tempPageIndex = self.pageArray.count - 1;
            
        }
        [self resetRiliview];
        self.riliView.hidden = NO;
        self.toolBarStyle = 0;
        [self resetHomeToolBar];
    }
    
//    if (self.pageArray.count==0) {
//        [ProgressHUD dismiss];
//    }
    
    AFTER(0.5, ^{
        // 第１面を表示
        self.mainScrollView.currentItemIndex = tempPageIndex;
        [self.mainScrollView scrollToItemAtIndex: tempPageIndex duration:0.1];
        
        // 後処理
        [self swipeViewCurrentItemIndexDidChange:self.mainScrollView];
        [self swipeViewDidEndDecelerating:self.mainScrollView];
    });
    if ([self isLogin]) {
        if (self.pageArray.count == 1) {
            self.mainScrollView.wrapEnabled = NO;
            self.mainScrollView.scrollEnabled = NO;
        }
    }else{
        self.mainScrollView.wrapEnabled = NO;
        self.mainScrollView.scrollEnabled = NO;
    }
    
    
    [self updateViews];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if ([self isLogin]) {
        [button setBackgroundImage:[UIImage imageNamed:@"06_blue"]
                          forState:UIControlStateNormal];
    }else{
        [button setBackgroundImage:[UIImage imageNamed:@"06_glay"]
                          forState:UIControlStateNormal];
    }
    [button addTarget:self action:@selector(searchBarItemAction:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 25, 25);
    self.searchBarItem= [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = self.searchBarItem;

    
    
    [NAHomeDataShare sharedInstance].homePageArray=self.pageArray;
    if (isNotelistChange) {
        [[NSNotificationCenter defaultCenter]postNotificationName:NOTYGETHOMEPAGE object:self.pageArray];
        isNotelistChange=NO;
    }

}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

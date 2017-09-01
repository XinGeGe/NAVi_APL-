//
//  NANewSettingViewController.m
//  NAVi
//
//  Created by Liyuanmeng on 2017/7/20.
//  Copyright © 2017年 dxc. All rights reserved.
//

#import "NANewSettingViewController.h"
#import "TOWebViewController.h"
#import "FontUtil.h"
#import "NAHomeViewController.h"
@interface NANewSettingViewController ()
{
    UIScrollView *settingScrollview;
    UILabel *userIdDetail;
    StepSlider *fontSlider;
    UISwitch *pushSwitch;
    UILabel *pushOn;
    UILabel *pushOff;
    UILabel *setLabel;
    UILabel *userId;
    UILabel *textChange;
    UIImageView *fontSmall;
    UIImageView *fontBig;
    UILabel *fontLabel;
    UILabel *pushLabel;
    UIButton *deleteBtn;
    UIButton *logOutBtn;
    UILabel *informationChangeLabel;
    UILabel *versionLabel;
    UIButton *useBtn;
    UIImageView *useImageview;
    UILabel *useLabel;
    NSArray *downloadinforarray;
    UIView *userIdLineVIew;
    UIView *fontLineView;
    UIView *pushLineView;
    UIView *deleteAllLineView;
    UIView *logOutLineView;
    NSString *userClass;
    
}
@end

@implementation NANewSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:137.0/255.0 green:137.0/255.0 blue:137.0/255.0 alpha:1];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:137.0/255.0 green:137.0/255.0 blue:137.0/255.0 alpha:1];
    self.navigationItem.leftBarButtonItem = self.backBarItem;
    userClass = [NASaveData getDataUserClass];
    [self configControls];
    BACK((^{
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setObject:[NSNumber numberWithBool:[NASaveData isSaveUserInfo]] forKey:@"autologin"];
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
        [dic1 setObject:[NSNumber numberWithBool:[NASaveData isAlldownload]] forKey:@"alldownload"];
        if ([NASaveData getISFastNews]==1) {
            downloadinforarray=[NSArray arrayWithObjects:dic,dic1,@"", nil];
        }else{
            downloadinforarray=[NSArray arrayWithObjects:dic,dic1, nil];
        }
        
        NSMutableDictionary *downloadDic=[[NSMutableDictionary alloc]init];
        [downloadDic setObject:downloadinforarray forKey:@"download"];
        
                
    }));

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(Expansion_rate:)
                                                 name:@"Expansion_rate" object:nil];
}
/**
 * searchBarItem初期化（検索ボタン）
 *
 */
- (UIBarButtonItem *)backBarItem
{
    if (!_backBarItem) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:@"19_white"]
                          forState:UIControlStateNormal];
        [button addTarget:self action:@selector(backBarItemAction:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, 0, 78/2, 36/2);        
        _backBarItem= [[UIBarButtonItem alloc] initWithCustomView:button];
        
    }
    return _backBarItem;
}
- (void)backBarItemAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
/**
 * 画面回転の前処理
 *
 */
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self configControls];
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self.presentingViewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

/**
 * 画面回転の後処理
 *
 */
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self configControls];

    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self.presentingViewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}
- (void)configControls {
    [self createControls];
    [self setPositions];
    [self setControlProperties];
}
- (BOOL)isLandscape
{
    return ([Util screenSize].width>[Util screenSize].height);
}

- (void)createControls {
    if ([self isLandscape]) {
        settingScrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [Util screenSize].width, [Util screenSize].height-64-14)];
    }else{
        settingScrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [Util screenSize].width, [Util screenSize].height-44-64)];
    }
    
    settingScrollview.backgroundColor = [UIColor colorWithRed:137.0/255.0 green:137.0/255.0 blue:137.0/255.0 alpha:1];
    if (isPhone) {
        if ([self isLandscape]) {
            settingScrollview.contentSize = CGSizeMake([Util screenSize].width, ([Util screenSize].height-14-64)*2);
        }
    }
    [self.view addSubview:settingScrollview];
    
    setLabel = [[UILabel alloc]init];
    userId = [[UILabel alloc]init];
    userIdDetail = [[UILabel alloc]init];
    textChange = [[UILabel alloc]init];
    fontSmall = [[UIImageView alloc]init];
    fontBig = [[UIImageView alloc]init];
    fontSlider = [[StepSlider alloc]init];
    fontLabel = [[UILabel alloc]init];
    pushLabel = [[UILabel alloc]init];
    pushSwitch = [[UISwitch alloc]init];
    deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if ([userClass isEqualToString:@"10"] || [userClass isEqualToString:@"11"]) {
        logOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        logOutLineView = [[UIView alloc]init];
    }
    
    informationChangeLabel = [[UILabel alloc]init];
    versionLabel = [[UILabel alloc]init];
    useBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    useImageview = [[UIImageView alloc]init];
    useLabel = [[UILabel alloc]init];
    userIdLineVIew = [[UIView alloc]init];
    fontLineView = [[UIView alloc]init];
    pushLineView = [[UIView alloc]init];
    deleteAllLineView = [[UIView alloc]init];
    pushOn = [[UILabel alloc]init];
    pushOff = [[UILabel alloc]init];
}
- (void)setPositions {
    [settingScrollview addSubview:setLabel];
    [setLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(settingScrollview.mas_top);
        make.width.mas_equalTo([Util screenSize].width);
        if (isPhone) {
            make.height.mas_equalTo(40);
        }else{
            make.height.mas_equalTo(60);
        }
        
    }];
    
    [settingScrollview addSubview:userId];
    [userId mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.top.equalTo(setLabel.mas_bottom).offset(5);
        make.right.equalTo(self.view.mas_right);
        if (isPhone) {
            make.height.mas_equalTo(30);
        }else{
            make.height.mas_equalTo(50);
        }
    }];
    
    [settingScrollview addSubview:userIdDetail];
    [userIdDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(30);
        make.top.equalTo(userId.mas_bottom).offset(5);
        make.right.equalTo(self.view.mas_right);
        if (isPhone) {
            make.height.mas_equalTo(30);
        }else{
            make.height.mas_equalTo(50);
        }

    }];
    
    [settingScrollview addSubview:userIdLineVIew];
    [userIdLineVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(userIdDetail.mas_bottom).offset(5);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(0.5);
    }];
    
    
    [settingScrollview addSubview:textChange];
    [textChange mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.top.equalTo(userIdLineVIew.mas_bottom).offset(5);
        make.right.equalTo(self.view.mas_right);
        if (isPhone) {
            make.height.mas_equalTo(30);
        }else{
            make.height.mas_equalTo(50);
        }
    }];
    
    [settingScrollview addSubview:fontSmall];
    [fontSmall mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(30);
        make.top.equalTo(textChange.mas_bottom).offset(15);
        if (isPhone) {
            make.height.mas_equalTo(15);
            make.width.mas_equalTo(15);
        }else{
            make.height.mas_equalTo(25);
            make.width.mas_equalTo(25);
        }
        
    }];
    
    [settingScrollview addSubview:fontBig];
    [fontBig mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-30);
        make.top.equalTo(textChange.mas_bottom).offset(5);
        if (isPhone) {
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
        }else{
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(40);
        }
        
    }];
    
    [settingScrollview addSubview:fontSlider];
    [fontSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(fontSmall.mas_right).offset(5);
        make.right.equalTo(fontBig.mas_left).offset(-5);
        make.top.equalTo(textChange.mas_bottom).offset(10);
        if (isPhone) {
            make.height.mas_equalTo(20);
        }else{
            make.height.mas_equalTo(30);
        }
        
    }];
    
    [settingScrollview addSubview:fontLabel];
    [fontLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(30);
        make.right.equalTo(self.view.mas_right).offset(-30);
        make.top.equalTo(fontBig.mas_bottom);
        if (isPhone) {
            make.height.mas_equalTo(40);
        }else{
            make.height.mas_equalTo(60);
        }
    }];
    
    [settingScrollview addSubview:fontLineView];
    [fontLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(fontLabel.mas_bottom).offset(5);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(0.5);
    }];
    
    
    [settingScrollview addSubview:pushLabel];
    [pushLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.top.equalTo(fontLineView.mas_bottom).offset(5);
        if (isPhone) {
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(100);
        }else{
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(100);
        }
        
    }];
    
    [settingScrollview addSubview:pushOn];
    [pushOn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.top.equalTo(fontLabel.mas_bottom).offset(10);
        if (isPhone) {
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(40);
        }else{
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(50);
        }
    }];
    
    
    [settingScrollview addSubview:pushSwitch];
    [pushSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(pushOn.mas_left).offset(-10);
        if (isPhone) {
            make.top.equalTo(fontLabel.mas_bottom).offset(10);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(40);
        }else{
            make.top.equalTo(fontLabel.mas_bottom).offset(15);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(50);
        }
    }];
    
    [settingScrollview addSubview:pushOff];
    [pushOff mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(pushSwitch.mas_left).offset(-5);
        make.top.equalTo(fontLabel.mas_bottom).offset(10);
        if (isPhone) {
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(40);
        }else{
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(50);
        }
    }];
    
    
    
    [settingScrollview addSubview:pushLineView];
    [pushLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(pushLabel.mas_bottom).offset(5);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(0.5);
    }];
    

    [settingScrollview addSubview:deleteBtn];
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.top.equalTo(pushLineView.mas_bottom).offset(10);
        make.right.equalTo(self.view.mas_right);
        if (isPhone) {
            make.height.mas_equalTo(30);
        }else{
            make.height.mas_equalTo(50);
        }
        
    }];
    
    [settingScrollview addSubview:deleteAllLineView];
    [deleteAllLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(deleteBtn.mas_bottom).offset(5);
        make.height.mas_equalTo(0.5);
    }];
    
    
    if ([userClass isEqualToString:@"10"] || [userClass isEqualToString:@"11"]) {
        [settingScrollview addSubview:logOutBtn];
        [logOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(20);
            make.top.equalTo(deleteAllLineView.mas_bottom).offset(10);
            make.right.equalTo(self.view.mas_right);
            if (isPhone) {
                make.height.mas_equalTo(30);
            }else{
                make.height.mas_equalTo(50);
            }
        }];
        
        [settingScrollview addSubview:logOutLineView];
        [logOutLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(logOutBtn.mas_bottom).offset(5);
            make.height.mas_equalTo(0.5);
        }];
        [settingScrollview addSubview:informationChangeLabel];
        [informationChangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(35);
            make.right.equalTo(self.view.mas_right).offset(-35);
            make.top.equalTo(logOutLineView.mas_bottom).offset(5);
            make.right.equalTo(self.view.mas_right);
            if (isPhone) {
                make.height.mas_equalTo(40);
            }else{
                make.height.mas_equalTo(60);
            }
        }];
    }else{
        [settingScrollview addSubview:informationChangeLabel];
        [informationChangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(35);
            make.right.equalTo(self.view.mas_right).offset(-35);
            make.top.equalTo(deleteAllLineView.mas_bottom).offset(5);
            make.right.equalTo(self.view.mas_right);
            if (isPhone) {
                make.height.mas_equalTo(40);
            }else{
                make.height.mas_equalTo(60);
            }
        }];
    }
    
    
    
    
    [settingScrollview addSubview:versionLabel];
    [versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right).offset(-30);
        make.top.equalTo(informationChangeLabel.mas_bottom).offset(10);
        if (isPhone) {
            make.height.mas_equalTo(20);
        }else{
            make.height.mas_equalTo(40);
        }
    }];
    
    [self.view addSubview:useBtn];
    [useBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
    
    [useBtn addSubview:useImageview];
    [useImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(useBtn.mas_left).offset(20);
        make.top.equalTo(useBtn.mas_top).offset(8);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
    }];
    
    [useBtn addSubview:useLabel];
    [useLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(useImageview.mas_right).offset(5);
        make.top.equalTo(useBtn.mas_top).offset(8);
        make.height.mas_equalTo(30);
    }];
    
}
- (void)setControlProperties {
   
    
    setLabel.backgroundColor = [UIColor colorWithRed:62.0/255.0 green:58.0/255.0 blue:57.0/255.0 alpha:1];;
    setLabel.text = @"設定";
    setLabel.textColor = [UIColor whiteColor];
    setLabel.textAlignment = NSTextAlignmentCenter;
    if (isPhone) {
        setLabel.font = [FontUtil systemFontOfSize:15];

    }else{
        setLabel.font = [FontUtil systemFontOfSize:20];

    }
    
    userId.textColor = [UIColor whiteColor];
    userId.text = @"ユーザーID";
    if (isPhone) {
        userId.font = [FontUtil systemFontOfSize:15];
        
    }else{
        userId.font = [FontUtil systemFontOfSize:20];
        
    }
    userId.textAlignment = NSTextAlignmentLeft;
    
    userIdDetail.textColor = [UIColor whiteColor];
    userIdDetail.text = [NASaveData getLoginUserId];
    if (isPhone) {
        userIdDetail.font = [FontUtil systemFontOfSize:15];
        
    }else{
        userIdDetail.font = [FontUtil systemFontOfSize:20];
        
    }
    userIdDetail.textAlignment = NSTextAlignmentLeft;
    
    textChange.textColor = [UIColor whiteColor];
    textChange.text = @"文字のサイズ";
    if (isPhone) {
        textChange.font = [FontUtil systemFontOfSize:15];
        
    }else{
        textChange.font = [FontUtil systemFontOfSize:20];
        
    }
    textChange.textAlignment = NSTextAlignmentLeft;
    
    fontSmall.image = [UIImage imageNamed:@"btn_font_1_off"];
    fontBig.image = [UIImage imageNamed:@"btn_font_3_off"];

    if (isPhone) {
        fontSlider.sliderCircleImage = [UIImage imageNamed:@"slider2"];
    }else{
       fontSlider.sliderCircleImage = [UIImage imageNamed:@"slider"];
    }
    [fontSlider setTintColor:[UIColor colorWithRed:158/255.0 green:156/255.0 blue:156/255.0 alpha:1]];
    [fontSlider addTarget:self action:@selector(fontSliderValuedChange:) forControlEvents:UIControlEventTouchUpInside];
    [fontSlider addTarget:self action:@selector(fontSliderValuedChange:) forControlEvents:UIControlEventValueChanged];
    fontSlider.index = [NASaveData getExpansion_rateNum];
    
    fontLabel.text = @"アプリ内の文字サイズを変更することができます。";
    fontLabel.textColor = [UIColor whiteColor];
    fontLabel.numberOfLines = 2;
    if (isPhone) {
        fontLabel.font = [FontUtil systemFontOfSize:15];
        
    }else{
        fontLabel.font = [FontUtil systemFontOfSize:20];
        
    }
    fontLabel.textAlignment = NSTextAlignmentLeft;
    
    pushLabel.text = @"通知";
    pushLabel.textColor = [UIColor whiteColor];
    if (isPhone) {
        pushLabel.font = [FontUtil systemFontOfSize:15];
        
    }else{
        pushLabel.font = [FontUtil systemFontOfSize:20];
        
    }
    pushLabel.textAlignment = NSTextAlignmentLeft;
    
    [pushSwitch setThumbTintColor:[UIColor blackColor]];
    [pushSwitch setOnTintColor:[UIColor colorWithRed:89/255.0 green:157/255.0 blue:222/255.0 alpha:1]];
    [pushSwitch addTarget:self action:@selector(buttonPushChanged:) forControlEvents:UIControlEventValueChanged];
    
    deleteBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    if (isPhone) {
        deleteBtn.titleLabel.font = [FontUtil systemFontOfSize:15];
        
    }else{
        deleteBtn.titleLabel.font = [FontUtil systemFontOfSize:20];
        
    }
    [deleteBtn setTitle:@"キャッシュ削除" forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteAll) forControlEvents:UIControlEventTouchUpInside];
    
    
    if ([userClass isEqualToString:@"10"] || [userClass isEqualToString:@"11"]) {
        logOutBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        if (isPhone) {
            logOutBtn.titleLabel.font = [FontUtil systemFontOfSize:15];
            
        }else{
            logOutBtn.titleLabel.font = [FontUtil systemFontOfSize:20];
            
        }
        [logOutBtn setTitle:@"ログオフ" forState:UIControlStateNormal];
        [logOutBtn addTarget:self action:@selector(logOut) forControlEvents:UIControlEventTouchUpInside];
    }
    
    informationChangeLabel.text = @"登録情報の変更は公明版サ一ビスをご覧ください";
    informationChangeLabel.textColor = [UIColor whiteColor];
    informationChangeLabel.numberOfLines = 2;
    if (isPhone) {
        informationChangeLabel.font = [FontUtil systemFontOfSize:15];
        
    }else{
        informationChangeLabel.font = [FontUtil systemFontOfSize:20];
        
    }

    informationChangeLabel.textAlignment = NSTextAlignmentLeft;
    
    versionLabel.text = @"バージョン   0.0.1";
    versionLabel.textColor = [UIColor whiteColor];
    if (isPhone) {
        versionLabel.font = [FontUtil systemFontOfSize:15];
        
    }else{
        versionLabel.font = [FontUtil systemFontOfSize:20];
        
    }
    versionLabel.textAlignment = NSTextAlignmentRight;
    
    useBtn.backgroundColor = [UIColor blackColor];
    [useBtn addTarget:self action:@selector(useDetail) forControlEvents:UIControlEventTouchUpInside];
    
    useImageview.image = [UIImage imageNamed:@"22_white"];
    
    useLabel.text = @"アプリの使い方";
    useLabel.textColor = [UIColor whiteColor];
    if (isPhone) {
        useLabel.font = [FontUtil systemFontOfSize:18];
        
    }else{
        useLabel.font = [FontUtil systemFontOfSize:23];
        
    }
    useLabel.textAlignment = NSTextAlignmentLeft;
    userIdLineVIew.backgroundColor = [UIColor colorWithRed:148/255.0 green:148/255.0 blue:145/255.0 alpha:1];
    fontLineView.backgroundColor = [UIColor colorWithRed:148/255.0 green:148/255.0 blue:145/255.0 alpha:1];
    pushLineView.backgroundColor = [UIColor colorWithRed:148/255.0 green:148/255.0 blue:145/255.0 alpha:1];
    deleteAllLineView.backgroundColor = [UIColor colorWithRed:148/255.0 green:148/255.0 blue:145/255.0 alpha:1];
    logOutLineView.backgroundColor = [UIColor colorWithRed:148/255.0 green:148/255.0 blue:145/255.0 alpha:1];
    
    
    pushOn.textColor = [UIColor whiteColor];
    pushOn.text = @"ON";
    pushOn.textAlignment = NSTextAlignmentCenter;
    if (isPhone) {
        pushOn.font = [FontUtil systemFontOfSize:15];
        
    }else{
        pushOn.font = [FontUtil systemFontOfSize:20];
        
    }
    
    pushOff.textColor = [UIColor whiteColor];
    pushOff.text = @"OFF";
    if (isPhone) {
        pushOff.font = [FontUtil systemFontOfSize:15];
        
    }else{
        pushOff.font = [FontUtil systemFontOfSize:20];
        
    }
    pushOff.textAlignment = NSTextAlignmentCenter;
    
    pushOn.hidden = YES;

}
//使用方法
- (void)useDetail{
    NSURL *url =[NSURL URLWithString:[NASaveData getWebUrl]];
    TOWebViewController *webViewController = [[TOWebViewController alloc] initWithURL:url];
    webViewController.showActionButton=NO;
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:webViewController] animated:YES completion:nil];
}
//キャッシュ削除
- (void)deleteAll{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"全てのデータを削除しますか？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"はい" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
        
        [[NAFileManager sharedInstance] deleteSearchResult];
        [[NAFileManager sharedInstance] deleteDetailInfo];
        [[NASQLHelper sharedInstance]clearFeedTable];
//        [NASaveData saveIsVisitorModel:YES];
//        [NASaveData clearLoginInfo];
        [self clearCookie];
        [[[iToast makeText:NSLocalizedString(@"delete done", nil)]
          setGravity:iToastGravityBottom] show];
        NAHomeViewController *home = [[NAHomeViewController alloc] init];
        home.forwardPage=@"topPage";
        NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:home];
        [self presentViewController:nav animated:NO completion:^{
            
            
        }];

    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"いいえ" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}
//ログアウト
- (void)logOut{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"ID／パスワードをクリアしますか？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"はい" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
        
        userIdDetail.text = @"OOOOOOOOOO";
        [self clearCookie];
        [NASaveData saveIsVisitorModel:YES];
        [NASaveData clearLoginInfo];
        
        NAHomeViewController *home = [[NAHomeViewController alloc] init];
        home.forwardPage=@"topPage";
        home.topPageDoc= _topPageDoc;
        home.regionDic = _regionDic;
        home.clipDataSource = _clipDataSource;
        home.homePageArray = _pageArray;
        home.dayNumber = 0;
        //            home.noteNumber = _noteNumber;
        //             home.NoteArray = _NoteArray;
        NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:home];
        [self presentViewController:nav animated:NO completion:^{
            
            
        }];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"いいえ" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];

}

-(void)clearCookie{
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        [storage deleteCookie:cookie];
    }
}
//通知ON/OFF
- (void)buttonPushChanged:(UISwitch *)btn{
    if (btn.isOn) {
        pushOn.hidden = NO;
        pushOff.hidden = YES;
    }else{
        pushOn.hidden = YES;
        pushOff.hidden = NO;
    }
}
//文字のサイズ
- (void)fontSliderValuedChange:(StepSlider *)sender {
    
    int val = [NSString stringWithFormat:@"%lu",(unsigned long)sender.index].intValue;
    
    if ( val == 0) {
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:@"0",@"myselectnum",@"小",@"myname", @"pagetate",@"showtype",nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Expansion_rate" object:nil userInfo:dic];
    }else if (val == 1){
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:@"1",@"myselectnum",@"中",@"myname", @"pagetate",@"showtype",nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Expansion_rate" object:nil userInfo:dic];
    }else if (val == 2){
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:@"2",@"myselectnum",@"大",@"myname", @"pagetate",@"showtype",nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Expansion_rate" object:nil userInfo:dic];
    }else if (val == 3){
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:@"3",@"myselectnum",@"大",@"myname", @"pagetate",@"showtype",nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Expansion_rate" object:nil userInfo:dic];
    }
    else if (val == 4){
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:@"4",@"myselectnum",@"大",@"myname", @"pagetate",@"showtype",nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Expansion_rate" object:nil userInfo:dic];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    isSelectpage=[NASaveData getFirstDownload]==0?YES:NO;
    
    BACK(^{
        [self getTheSetting];
        
    });
    
    
    
}
#pragma mark - API -
#pragma mark
- (void)saveTheSetting{
    
    NSDictionary *autodic=[downloadinforarray objectAtIndex:0];
    NSNumber *autonum=[autodic objectForKey:@"autologin"];
    [NASaveData saveUserInfo:autonum];
    
    NSDictionary *alldownloaddic=[downloadinforarray objectAtIndex:1];
    NSNumber *alldownloadnum=[alldownloaddic objectForKey:@"alldownload"];
    [NASaveData saveAlldownload:alldownloadnum];
    
    if (isSelectpage) {
        
        [NASaveData saveFirstDownload:[NSNumber numberWithInteger:0]];
    }else{
        
        [NASaveData saveFirstDownload:[NSNumber numberWithInteger:1]];
    }
    
}
- (void)getTheSetting{
    NSDictionary *autodic=[downloadinforarray objectAtIndex:0];
    [autodic setValue:[NSNumber numberWithBool:[NASaveData isSaveUserInfo]] forKey:@"autologin"];
    
    NSDictionary *alldownloaddic=[downloadinforarray objectAtIndex:1];
    [alldownloaddic setValue:[NSNumber numberWithBool:[NASaveData isAlldownload]] forKey:@"alldownload"];
    
}
-(void)Expansion_rate:(NSNotification *)noty{
    NSDictionary *dic=[noty userInfo];
    //    NSMutableDictionary *dic1=[controlarray objectAtIndex:0];
    //    [dic1 setObject:controlarray forKey:@"Expansion_rate"];
    NSString *value=[dic objectForKey:@"myselectnum"];
    NSString *showtype=[dic objectForKey:@"showtype"];
    if ([showtype isEqualToString:TYPE_PAGETATE]) {
        [NASaveData saveExpansion_rateNum:value.intValue];
        NSDictionary *changedic=[NAFileManager ChangePlistTodic];
        [NASaveData saveExpansion_rate:[changedic objectForKey:[NSString stringWithFormat:@"%@%d",NAPapersize,value.intValue]]];
    }else if([showtype isEqualToString:TYPE_SPANNUM]){
        [NASaveData saveSpanIndex:value.intValue];
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

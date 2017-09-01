//
//  NANewChooseClipViewController.m
//  NAVi
//
//  Created by Liyuanmeng on 2017/7/24.
//  Copyright © 2017年 dxc. All rights reserved.
//

#import "NANewChooseClipViewController.h"
#import "ChooseClipCollectionViewCell.h"
#import "FontUtil.h"
#import "TTGTextTagCollectionView.h"
@interface NANewChooseClipViewController () <TTGTextTagCollectionViewDelegate>
{
    UIImageView *chooseImageView;
    UILabel *chooseLabel;
    UIView *horLineView;
    TTGTextTagCollectionView *textTagCollectionView1;
    NSArray *clipArray;//all arr
    NSArray*SelectArray;//use arr
    NSInteger heighNumber;
    UIButton *saveBtn;
    UIButton *cancelBtn;
    UIView *lineView;
    NSMutableArray *selectedArr;//select arr

}
@end

@implementation NANewChooseClipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:245/255.0 alpha:1];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = self.backBarItem;
    [self getTagClipAPI];
    clipArray = [[NSArray alloc]init];
    SelectArray = [[NSArray alloc]init];
    selectedArr = [[NSMutableArray alloc]init];
}
//详细页面使用的tag
- (void)getTag{
    NSDictionary *param = @{
                            @"Userid"     :  [NASaveData getLoginUserId],
                            @"IndexNo"       :  _indexNo,
                            @"UseFlg"     :  @"1",
                            };
    [[NANetworkClient sharedClient] postTagFavoritesSearch:param completionBlock:^(id favorites, NSError *error) {
        SHXMLParser *parser = [[SHXMLParser alloc] init];
        NSDictionary *dic = [parser parseData:favorites];
        NAClipBaseClass *clipBaseClass = [NAClipBaseClass modelObjectWithDictionary:dic];
        
        NSArray *arr = clipBaseClass.response.doc;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (arr.count > 0) {
                SelectArray = arr;
            }
            [ProgressHUD dismiss];
            [self configControls];
        });
    }];
}
//详细页面所有的tag
- (void)getTagClipAPI
{
    NSDictionary *param = @{
                            @"Userid"     :  [NASaveData getLoginUserId],
                            @"Rows"       :  @"999",
                            @"UseDevice"  :  NAUserDevice,
                            @"K002"       :  @"4",
                            @"Mode"       :  @"1",
                            @"Fl"         :  [NSString clipListFl],
                            @"UseFlg"     :  @"0",
                            };
    [[NANetworkClient sharedClient] postTagFavoritesSearch:param completionBlock:^(id favorites, NSError *error) {
        if (!error) {
            SHXMLParser *parser = [[SHXMLParser alloc] init];
            NSDictionary *dic = [parser parseData:favorites];
            NAClipBaseClass *clipBaseClass = [NAClipBaseClass modelObjectWithDictionary:dic];
            NSArray *array = clipBaseClass.response.doc;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self getTag];
                [ProgressHUD dismiss];
                if (array.count == 0) {
                    [[[iToast makeText:@"NOTagList"]
                      setGravity:iToastGravityBottom] show];
                }else{
                    clipArray = array;
                    
                }
            });
        }else{
            ITOAST_BOTTOM(error.localizedDescription);
        }
    }];
}
- (void)configControls {
    [self createControls];
    [self setPositions];
    [self setControlProperties];
}
- (void)createControls {
    chooseImageView = [[UIImageView alloc]init];
    chooseLabel = [[UILabel alloc]init];
    horLineView = [[UIView alloc]init];

    lineView = [[UIView alloc]init];
    textTagCollectionView1 =[[TTGTextTagCollectionView alloc]init];
    saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
}
- (void)setPositions {
    [self.view addSubview:chooseImageView];
    [chooseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(30);
        make.top.equalTo(self.view.mas_top).offset(2);
        make.width.height.mas_equalTo(30);
    }];
    
    [self.view addSubview:chooseLabel];
    [chooseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(chooseImageView.mas_right).offset(5);
        make.top.equalTo(self.view.mas_top).offset(8);
        make.height.mas_equalTo(20);
    }];
    
    [self.view addSubview:horLineView];
    [horLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(chooseImageView.mas_bottom).offset(4);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(0.5);
    }];
    
    
    
    [self.view addSubview:textTagCollectionView1];
    [textTagCollectionView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(horLineView.mas_bottom).offset(5);
        make.left.equalTo(self.view.mas_left).offset(30);
        make.right.equalTo(self.view.mas_right).offset(-30);
        make.height.mas_equalTo(200);
    }];
    
    
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(textTagCollectionView1.mas_bottom).offset(10);
        make.width.mas_equalTo(0.5);
        make.height.mas_equalTo(20);
    }];
    
    if (isPhone) {
        [self.view addSubview:saveBtn];
        [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(lineView.mas_left).offset( -10);
            make.top.equalTo(textTagCollectionView1.mas_bottom).offset(10);
            make.width.mas_equalTo(116/3*2);
            make.height.mas_equalTo(34/3*2);
        }];
        
        [self.view addSubview:cancelBtn];
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lineView.mas_right).offset(10);
            make.top.equalTo(textTagCollectionView1.mas_bottom).offset(10);
            make.width.mas_equalTo(116/3*2);
            make.height.mas_equalTo(34/3*2);
        }];
    }else{
        [self.view addSubview:saveBtn];
        [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(lineView.mas_left).offset( -10);
            make.top.equalTo(textTagCollectionView1.mas_bottom).offset(10);
            make.width.mas_equalTo(116);
            make.height.mas_equalTo(34);
        }];
        
        [self.view addSubview:cancelBtn];
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lineView.mas_right).offset(10);
            make.top.equalTo(textTagCollectionView1.mas_bottom).offset(10);
            make.width.mas_equalTo(116);
            make.height.mas_equalTo(34);
        }];
    }

    

}
- (void)setControlProperties {
    chooseImageView.image = [UIImage imageNamed:@"10_blue"];
    
    chooseLabel.text = @"ラベル選択";
    if (isPhone) {
       chooseLabel.font = [FontUtil systemFontOfSize:13];
    }else{
       chooseLabel.font = [FontUtil systemFontOfSize:15];
    }
    
    horLineView.backgroundColor = [UIColor whiteColor];
    
    textTagCollectionView1.delegate = self;
    textTagCollectionView1.showsVerticalScrollIndicator = NO;
    TTGTextTagConfig *config = textTagCollectionView1.defaultConfig;
    config = textTagCollectionView1.defaultConfig;
    
    config.tagTextFont = [UIFont systemFontOfSize:15.0f];
    
    config.tagExtraSpace = CGSizeMake(12, 12);
    
    config.tagTextColor = [UIColor blackColor];
    config.tagSelectedTextColor = [UIColor whiteColor];
    
    config.tagBackgroundColor = [UIColor whiteColor];
    config.tagSelectedBackgroundColor = [UIColor colorWithRed:234/255.0 green:115/255.0 blue:160/255.0 alpha:1];
    
    config.tagCornerRadius = 10.0f;
    config.tagSelectedCornerRadius = 10.0f;
    
    config.tagBorderWidth = 1.0;
    
    config.tagBorderColor = [UIColor colorWithRed:103.0/255.0 green:165.0/255.0 blue:224.0/255.0 alpha:1];
    config.tagSelectedBorderColor = [UIColor colorWithRed:234/255.0 green:115/255.0 blue:160/255.0 alpha:1];
    
    config.tagShadowColor = [UIColor blackColor];
    config.tagShadowOffset = CGSizeMake(0, 1);
    config.tagShadowOpacity = 0.3f;
    config.tagShadowRadius = 2;
    
    textTagCollectionView1.horizontalSpacing = 8;
    textTagCollectionView1.verticalSpacing = 8;
    

    
    [textTagCollectionView1 addTags:clipArray];
    for (int i =0; i<clipArray.count; i++) {
        NAClipDoc *doc1 = [clipArray objectAtIndex:i];
        for (int j =0; j< SelectArray.count; j++) {
            NAClipDoc *doc2 = [SelectArray objectAtIndex:j];
            if ([doc1.tagid isEqualToString:doc2.tagid]) {
                [textTagCollectionView1 setTagAtIndex:i selected:YES];
            }
        }
    }
    
    [saveBtn setImage:[UIImage imageNamed:@"27_clip_save"] forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveClip) forControlEvents:UIControlEventTouchUpInside];
    
    [cancelBtn setImage:[UIImage imageNamed:@"26_btn_clip_cancel"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelClip) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark - TTGTextTagCollectionViewDelegate

- (void)textTagCollectionView:(TTGTextTagCollectionView *)textTagCollectionView didTapTag:(NSString *)tagText atIndex:(NSUInteger)index selected:(BOOL)selected {
    //selectedArr =  textTagCollectionView1.allSelectedTags;
    [selectedArr removeAllObjects];
    NSArray *arr = textTagCollectionView1.allSelectedTags;
    for (int i =0; i<clipArray.count; i++) {
        NAClipDoc *doc1 = [clipArray objectAtIndex:i];
        for (int j =0; j< arr.count; j++) {
            NSString *doc2 = [[arr objectAtIndex:j] objectForKey:doc1.tagid];
            if ([doc2 isEqualToString:doc1.tagName]) {
                [selectedArr addObject:doc1.tagid];
            }
        }
    }
    NSLog(@"Tap tag: %@, at: %ld, selected: %d",tagText, (long) index, selected);
}

- (void)textTagCollectionView:(TTGTextTagCollectionView *)textTagCollectionView updateContentSize:(CGSize)contentSize {
    NSLog(@"text tag collection: %@ new content size: %@", textTagCollectionView, NSStringFromCGSize(contentSize));
}
- (void)saveClip{
    if (selectedArr.count != 0) {
        NSString *tagId;
        for (int i =0; i < selectedArr.count; i++) {
            if (i == 0) {
                tagId = [selectedArr objectAtIndex:0];
            }else{
                tagId = [NSString stringWithFormat:@"%@,%@",tagId,[selectedArr objectAtIndex:i]];
            }
        }
        NSDictionary *param = @{
                                @"Userid"     :  [NASaveData getLoginUserId],
                                @"IndexNo"           : _indexNo,
                                @"TagId"         :  tagId,//TODO   TagId
                                };
        [[NANetworkClient sharedClient] changeClipInfo:param completionBlock:^(id favorites, NSError *error) {
            if (!error) {
                SHXMLParser *parser = [[SHXMLParser alloc] init];
                NSDictionary *dic = [parser parseData:favorites];
                NAClipBaseClass *clipBaseClass = [NAClipBaseClass modelObjectWithDictionary:dic];
                NSString *statues = clipBaseClass.response.status;
                if (statues.integerValue == 0) {
                    ITOAST_BOTTOM(@"changeClipInfo success");
                    [self dismissViewControllerAnimated:YES completion:^{
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadMemo" object:nil];
                    }];
                }else{
                    ITOAST_BOTTOM(@"changeClipInfo error");
                }
                
            }
        }];
    }
    

}
- (void)cancelClip{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (UIBarButtonItem *)backBarItem
{
    if (!_backBarItem) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:@"20_glay"]
                          forState:UIControlStateNormal];
        [button addTarget:self action:@selector(backBarItemAction) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, 0, 25, 25);
        _backBarItem= [[UIBarButtonItem alloc] initWithCustomView:button];
        
    }
    return _backBarItem;
}

- (void)backBarItemAction{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
/**
 * 画面回転の前処理
 *
 */
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self getTagClipAPI];
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self.presentingViewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

/**
 * 画面回転の後処理
 *
 */
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self getTagClipAPI];
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self.presentingViewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
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

@end

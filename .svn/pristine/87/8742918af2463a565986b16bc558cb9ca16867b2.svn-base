//
//  NAAddClipViewController.m
//  NAVi
//
//  Created by Liyuanmeng on 2017/7/28.
//  Copyright © 2017年 dxc. All rights reserved.
//

#import "NAAddClipViewController.h"

#import <UIKit/UIKit.h>
#import "NAEditClipTableViewCell.h"
#import "FontUtil.h"
@interface NAAddClipViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate, UITextFieldDelegate,UIScrollViewDelegate>
{
    UIScrollView *addClipScroll;
    UIView *scrollContentView;
    UIImageView *editImageView;
    UILabel *editLabel;
    UIView *horLineView;
    UILabel *editDetailLabel;
    UITableView *clipTableView;
    NSMutableArray *clipArr;
    UITextView *addClipTextView;
    UIButton *addClipBtn;
    UIButton *logInBtn;
    UIButton *cancelBtn;
    UIView *lineView;
    
    UIView *lastAddClipTextView;
    
    NSInteger addCount; // 追加新的个数
    NSMutableArray *arrChangedTag; // 存放改变tag的数组
    NSMutableArray *arrAddTagName; // 添加tagName数组
    
    CGFloat oldOffSetY;
//    UIPanGestureRecognizer *panGesture;
    
}
@end

@implementation NAAddClipViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:245/255.0 alpha:1];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = self.backBarItem;
    [self configControls];
}
- (void)configControls {
    [self createControls];
//    [self setPositions];
    [self setControlProperties];
    [self getTagClipAPI:YES];
    [self setAction];
}
- (void)createControls {
    addClipScroll = [[UIScrollView alloc] init];
    scrollContentView = [[UIView alloc] init];
    editImageView = [[UIImageView alloc]init];
    editLabel = [[UILabel alloc]init];
    horLineView = [[UIView alloc]init];
    editDetailLabel = [[UILabel alloc]init];
    clipTableView = [[UITableView alloc]init];
    clipTableView.separatorStyle = UITableViewCellEditingStyleNone;
    addClipTextView = [[UITextView alloc]init];
    addClipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lineView = [[UIView alloc]init];
    arrChangedTag = [[NSMutableArray alloc] init];
    arrAddTagName = [[NSMutableArray alloc] init];
    
//    panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
}
- (BOOL)isLandscape
{
    return ([Util screenSize].width>[Util screenSize].height);
}
- (void)setPositions {
    
    [self.view addSubview:addClipScroll];
    [addClipScroll mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.right.top.bottom.equalTo(self.view);
    }];
    
    [addClipScroll addSubview:scrollContentView];
    [scrollContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(addClipScroll);
        make.width.equalTo(addClipScroll);
    }];
    
    [scrollContentView addSubview:editImageView];
    [editImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollContentView.mas_left).offset(10);
        make.top.equalTo(scrollContentView.mas_top).offset(2);
        make.width.height.mas_equalTo(30);
    }];
    
    [scrollContentView addSubview:editLabel];
    [editLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(editImageView.mas_right).offset(5);
        make.top.equalTo(scrollContentView.mas_top).offset(8);
        make.height.mas_equalTo(20);
    }];
    
    [scrollContentView addSubview:horLineView];
    [horLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(editImageView.mas_bottom).offset(2);
        make.left.equalTo(scrollContentView.mas_left);
        make.right.equalTo(scrollContentView.mas_right);
        make.height.mas_equalTo(0.5);
    }];
    
    [scrollContentView addSubview:editDetailLabel];
    if ([self isLandscape]) {
        [editDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(horLineView.mas_bottom).offset(5);
            make.left.equalTo(scrollContentView.mas_left).offset(10);
            make.right.equalTo(scrollContentView.mas_right).offset(-10);
            make.height.mas_equalTo(30);
        }];
    }else{
        [editDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(horLineView.mas_bottom).offset(5);
            make.left.equalTo(scrollContentView.mas_left).offset(10);
            make.right.equalTo(scrollContentView.mas_right).offset(-10);
            make.height.mas_equalTo(60);
        }];
    }
    

    [addClipScroll addSubview:clipTableView];
    [clipTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(editDetailLabel.mas_bottom).offset(5);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right);
        if (clipArr.count > 0) {
            make.height.mas_equalTo(clipArr.count*40);
        } else {
            make.height.mas_equalTo(1);
        }
    }];
    
    [scrollContentView addSubview:addClipBtn];
    if (isPhone) {
        [addClipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (clipArr.count > 0) {
                make.top.equalTo(clipTableView.mas_bottom).offset(40 * addCount + 10);
            } else {
                make.top.equalTo(clipTableView.mas_bottom).offset(10);
            }
            make.right.equalTo(scrollContentView.mas_right).offset(-10);
            make.width.mas_equalTo(175.5/3*2);
            make.height.mas_equalTo(34/3*2);
        }];
    }else{
        [addClipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (clipArr.count > 0) {
                make.top.equalTo(clipTableView.mas_bottom).offset(10);
            } else {
                make.top.equalTo(editDetailLabel.mas_bottom).offset(10);
            }
            make.right.equalTo(scrollContentView.mas_right).offset(-10);
            make.width.mas_equalTo(175.5);
            make.height.mas_equalTo(34);
        }];
    }
    
    
    [scrollContentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addClipBtn.mas_bottom).offset(20);
        make.centerX.equalTo(scrollContentView.mas_centerX);
        make.width.mas_equalTo(0.5);
        make.height.mas_equalTo(20);
    }];
    
    if (isPhone) {
        [scrollContentView addSubview:logInBtn];
        [logInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(addClipBtn.mas_bottom).offset(10);
            make.right.equalTo(lineView.mas_left).offset(-10);
            make.width.mas_equalTo(116/3*2);
            make.height.mas_equalTo(34/3*2);
        }];
        
        [scrollContentView addSubview:cancelBtn];
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(addClipBtn.mas_bottom).offset(10);
            make.left.equalTo(lineView.mas_right).offset(10);
            make.width.mas_equalTo(116/3*2);
            make.height.mas_equalTo(34/3*2);
        }];
    }else{
        [scrollContentView addSubview:logInBtn];
        [logInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(addClipBtn.mas_bottom).offset(10);
            make.right.equalTo(lineView.mas_left).offset(-10);
            make.width.mas_equalTo(116);
            make.height.mas_equalTo(34);
        }];
        
        [scrollContentView addSubview:cancelBtn];
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(addClipBtn.mas_bottom).offset(10);
            make.left.equalTo(lineView.mas_right).offset(10);
            make.width.mas_equalTo(116);
            make.height.mas_equalTo(34);
        }];
    }
    
    [scrollContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(cancelBtn.mas_bottom).offset(20);
    }];
    
}
- (void)setControlProperties {
    
//    addClipScroll.delegate = self;
    
    editImageView.image = [UIImage imageNamed:@"10_blue"];
    
    editLabel.text = @"ラベル編集";
    
    horLineView.backgroundColor = [UIColor whiteColor];
    
    editDetailLabel.text = @"ラベルの名称変更や新規追加、削除ができます。（最大10個まで登録することができます。）";
    editDetailLabel.numberOfLines = 3;
    
    
    clipTableView.delegate = self;
    clipTableView.dataSource = self;
    clipTableView.scrollEnabled = NO;
    clipTableView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:245/255.0 alpha:1];
    [clipTableView reloadData];
    
    [addClipBtn setImage:[UIImage imageNamed:@"26_btn_clip_add"] forState:UIControlStateNormal];
    
    [logInBtn setImage:[UIImage imageNamed:@"26_btn_clip_login"] forState:UIControlStateNormal];
    
    [cancelBtn setImage:[UIImage imageNamed:@"26_btn_clip_cancel"] forState:UIControlStateNormal];
    
    
    if (isPhone) {
        editLabel.font = [FontUtil systemFontOfSize:12];
        editDetailLabel.font = [FontUtil systemFontOfSize:12];
    }else{
        editLabel.font = [FontUtil systemFontOfSize:15];
        editDetailLabel.font = [FontUtil systemFontOfSize:15];
    }
}

- (void)setAction {
    
    [addClipBtn addTarget:self action:@selector(addClipView:) forControlEvents:UIControlEventTouchUpInside];
    
    [[logInBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        __block BOOL isChangeError = false;
        __block BOOL isAddError = false;
        __block BOOL hasEmpty = false;
        __block BOOL tooLongName = false;
        [self.view endEditing:YES];
        if (arrChangedTag.count > 0) {
            
            for (NAClipDoc *doc in arrChangedTag) {
                if ([doc.tagName isEqualToString:@""]) {
                    hasEmpty = YES;
                }
                if (doc.tagName.length > 20) {
                    tooLongName = YES;
                }
            }
            if (!hasEmpty && !tooLongName) {
                for (int i = 0; i < arrChangedTag.count; i++) {
                    NAClipDoc *doc = arrChangedTag[i];
                    
                    
                    NSDictionary *param = @{
                                            @"Userid"     :  [NASaveData getLoginUserId],
                                            @"TagId"         :  doc.tagid,
                                            @"TagName"         :  doc.tagName,
                                            };
                    [[NANetworkClient sharedClient] renameTag:param completionBlock:^(id favorites, NSError *error) {
                        if (!error) {
                            isChangeError = false;
                        } else {
                            isChangeError = true;
                        }
                    }];
                }
            }
        }
        
        if (arrAddTagName.count > 0) {
            for (int n = 0; n < arrAddTagName.count; n++) {
                NAClipDoc *docAdd = arrAddTagName[n];
                if ([docAdd.tagName isEqualToString:@""]) {
                    [arrAddTagName removeObject:docAdd];
                }
                if (docAdd.tagName.length > 20) {
                    tooLongName = YES;
                }
            }
            
            if (!tooLongName) {
                // 创建队列组，可以使多个网络请求异步执行，执行完之后再进行操作
                dispatch_group_t group = dispatch_group_create();
                //创建全局队列
                dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
                
                dispatch_group_async(group, queue, ^{
                    // 循环上传数据
                    for (int j = 0; j < arrAddTagName.count; j++) {
                        //创建dispatch_semaphore_t对象
                        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
                        
                        NAClipDoc *docAdd = arrAddTagName[j];
                        if (![docAdd.tagName isEqualToString:@""]) {
                            NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
                            NSTimeInterval a=[dat timeIntervalSince1970]*1000;
                            NSString *timeString = [NSString stringWithFormat:@"%f", a];
                            
                            NSDictionary *param = @{
                                                    @"Userid"     :  [NASaveData getLoginUserId],
                                                    @"TagName"         :  docAdd.tagName,
                                                    @"timestamp"   : timeString,
                                                    @"UseDevice"  :  NAUserDevice,
                                                    };
                            
                            [[NANetworkClient sharedClient] saveTag:param completionBlock:^(id favorites, NSError *error) {
                                dispatch_semaphore_signal(semaphore);
                                if (!error) {
                                    
                                    isAddError = false;
                                } else {
                                    isAddError = true;
                                }
                            }];
                            
                            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
                        }
                    }
                });
                // 当所有队列执行完成之后
                dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                });
            }
            
        }
        
        
        if (arrChangedTag.count > 0 || arrAddTagName.count > 0) {
            if (hasEmpty) {
                ITOAST_BOTTOM(@"空のラベルが存在");
            } else if (tooLongName) {
                ITOAST_BOTTOM(@"太长のラベルが存在");
            } else {
                if (!isChangeError && !isAddError) {
                    ITOAST_BOTTOM(@"save tag success");
                }
                AFTER(2.0, ^{
                    [self dismissViewControllerAnimated:YES completion:^{
                        
                    }];
                });
            }
            
        } else {
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }

    }];
    
    [[cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.view endEditing:YES];
        if (arrAddTagName.count > 0 || arrChangedTag.count > 0) {
           ITOAST_BOTTOM(@"未保存のラベルが存在");
        } else {
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
       
    }];
    
    UITapGestureRecognizer *oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollTap:)];
    [addClipScroll addGestureRecognizer:oneTap];
}

- (void)getTagClipAPI:(BOOL)isSetPositions
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
            clipArr = [[NSMutableArray alloc] init];
            clipArr = [[NSMutableArray alloc] initWithArray:array];
//            if ((clipArr.count) < 9) {
//                [addClipScroll addGestureRecognizer:panGesture];
//            }
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [ProgressHUD dismiss];
                
                if (isSetPositions) {
                    [self setPositions];
                }
                [clipTableView reloadData];
            
                [clipTableView mas_updateConstraints:^(MASConstraintMaker *make) {
                    if (clipArr.count > 0) {
                        make.height.mas_equalTo(clipArr.count*40 - 10);
                    } else {
                        make.height.mas_equalTo(1);
                    }
                }];
                if (array.count == 0) {
                    [[[iToast makeText:NSLocalizedString(@"NO Note", nil)]
                      setGravity:iToastGravityBottom] show];
                }
            });
        }else{
            ITOAST_BOTTOM(error.localizedDescription);
            //[self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

#pragma mark ----------------------TableView Delegate----------------------------

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return clipArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NAEditClipTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if ( cell== nil) {
        cell = [[NAEditClipTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    NAClipDoc *dicClip = clipArr[indexPath.row];
    cell.clipTextField.text = dicClip.tagName;
    cell.tagId = dicClip.tagid;
    cell.clipTextField.delegate = self;
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:) name:UITextFieldTextDidChangeNotification object:cell.clipTextField];
    
    [[cell.clipTextField rac_signalForControlEvents:UIControlEventEditingDidBegin] subscribeNext:^(id x) {
        if (isPhone) {
            if ([Util screenSize].width > [Util screenSize].height) {
                addClipScroll.contentOffset = CGPointMake(0, ((indexPath.row) * 40) + 80);
            } else {
                if (indexPath.row > 1) {
                    addClipScroll.contentOffset = CGPointMake(0, ((indexPath.row - 1) * 40));
                } else {
                    addClipScroll.contentOffset = CGPointMake(0, 0);
                }
            }
        } else {
            if ([Util screenSize].width > [Util screenSize].height) {
                if (indexPath.row > 2) {
                    addClipScroll.contentOffset = CGPointMake(0, (indexPath.row - 2) * 40);
                } else {
                    addClipScroll.contentOffset = CGPointMake(0, 0);
                }
            }
            
            
        }
        
    }];
    
    // 结束编辑
    [[cell.clipTextField rac_signalForControlEvents:UIControlEventEditingDidEnd] subscribeNext:^(id x) {
        
        NSLog(@"%@%@", cell.tagId, cell.clipTextField.text);
        for (int i = 0; i < clipArr.count; i++) {
            NAClipDoc *doc = clipArr[i];
            if ([doc.tagid isEqualToString:cell.tagId]) {
                if (arrChangedTag.count > 0) {
                    for (int j = 0; j < arrChangedTag.count; j++) {
                        NAClipDoc *hasDoc = arrChangedTag[j];
                        if ([hasDoc.tagid isEqualToString:cell.tagId]) {
                            [arrChangedTag removeObject:hasDoc];
                        }
                    }
                }
                if (![doc.tagName isEqualToString:cell.clipTextField.text]) {
                    NAClipDoc *docChange = [[NAClipDoc alloc] init];
                    docChange.tagid = cell.tagId;
                    docChange.tagName = cell.clipTextField.text;
                    [arrChangedTag addObject:docChange];
                }
            }
        }
    }];
    
    [[cell.deleteClipBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [Util showAlert:@"このラベルを削除しますか" okTitle:@"確定" cancelTitle:@"キャンセル" okAction:^(UIAlertAction * _Nonnull action) {
            NSDictionary *param = @{
                                    @"Userid"     :  [NASaveData getLoginUserId],
                                    @"TagId"         :  cell.tagId,
                                    };
            [[NANetworkClient sharedClient] deleteTag:param completionBlock:^(id favorites, NSError *error) {
                if (!error) {
                    for (int i = 0; i < clipArr.count; i++) {
                        NAClipDoc *doc = clipArr[i];
                        if ([doc.tagid isEqualToString:cell.tagId]) {
                            [self getTagClipAPI:NO];
                        }
                    }
                    
                    for (int j = 0; j < arrChangedTag.count; j++) {
                        NAClipDoc *doc = arrChangedTag[j];
                        if ([doc.tagid isEqualToString:cell.tagId]) {
                            [arrChangedTag removeObject:doc];
                        }
                    }
                    
                    [clipTableView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(editDetailLabel.mas_bottom).offset(5);
                        make.left.equalTo(self.view.mas_left).offset(10);
                        make.right.equalTo(self.view.mas_right);
                        if (clipArr.count > 0) {
                            make.height.mas_equalTo(clipArr.count*40 - 5);
                        } else {
                            make.height.mas_equalTo(1);
                        }
                    }];
                    
                    [addClipBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                        if (clipArr.count > 0) {
                            make.top.equalTo(clipTableView.mas_bottom).offset(40 * addCount + 5);
                        } else {
                            make.top.equalTo(clipTableView.mas_bottom).offset(0);
                        }
                    }];
                    //重新定义ScrollView的尺寸
                    CGRect viewFrame = addClipScroll.frame;
                    viewFrame.origin.y = 0;
                    addClipScroll.frame = viewFrame;
                    ITOAST_BOTTOM(@"tag deleted");
                    NSInteger selectTag = [NASaveData getClipSelectedBtnTag];
                    if (cell.tagId.integerValue == selectTag) {
                        [[NSNotificationCenter defaultCenter] postNotificationName:NOTYReloadClip object:nil];
                    }
//                    if ((addCount + clipArr.count) < 9) {
//                        [addClipScroll addGestureRecognizer:panGesture];
//                    }
                }else{
                    ITOAST_BOTTOM(error.localizedDescription);
                }
            }];
        } cancelAction:^(UIAlertAction * _Nonnull action) {
            
        } controller:self];
        
    }];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView.text.length < 1){
        textView.text = @"新規ラベルを入力してください";
        textView.textColor = [UIColor grayColor];
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@"新規ラベルを入力してください"]){
        textView.text=@"";
        textView.textColor=[UIColor blackColor];
    }
}

#pragma mark ----------------追加ClipTag------------------------
- (void)addClipView:(UIButton *)btn {
    if ((addCount + clipArr.count) >= 10) {
        [[[iToast makeText:NSLocalizedString(@"最大10個まで登録することができます。", nil)]
          setGravity:iToastGravityBottom] show];
    } else {
        addCount = addCount + 1;
        
        [self.view endEditing:YES];
        
        UIView *textViewBg = [[UIView alloc] init];
        UITextField *newClipTextView = [[UITextField alloc] init];
        
        textViewBg.backgroundColor = [UIColor whiteColor];
        textViewBg.layer.cornerRadius = 5;
        textViewBg.layer.masksToBounds = YES;
        textViewBg.layer.borderWidth=1;
        textViewBg.layer.borderColor=[UIColor whiteColor].CGColor;
        
        newClipTextView.tag = addCount;
        newClipTextView.backgroundColor = [UIColor whiteColor];
        newClipTextView.layer.cornerRadius = 5;
        newClipTextView.delegate = self;
        
        newClipTextView.placeholder = @"新規ラベルを入力してください";
        newClipTextView.font = [UIFont systemFontOfSize:13];
        
        [scrollContentView addSubview:textViewBg];
        [textViewBg addSubview:newClipTextView];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:) name:UITextFieldTextDidChangeNotification object:newClipTextView];
        
        [textViewBg mas_makeConstraints:^(MASConstraintMaker *make) {
            if (lastAddClipTextView) {
                make.top.equalTo(lastAddClipTextView.mas_bottom).offset(10);
            } else {
                make.top.equalTo(clipTableView.mas_bottom).offset(10);
            }
            make.left.equalTo(scrollContentView.mas_left).offset(10);
            make.right.mas_equalTo(-30);
            make.height.mas_equalTo(30);
        }];
        
        [newClipTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(5);
            make.right.top.bottom.mas_equalTo(0);
        }];
        
        if (isPhone) {
            [addClipBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                if (clipArr.count > 0) {
                    make.top.equalTo(clipTableView.mas_bottom).offset(40 * addCount + 5);
                } else {
                    make.top.equalTo(clipTableView.mas_bottom).offset(40 * addCount + 10);
                }
            }];
        }else{
            [addClipBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                if (clipArr.count > 0) {
                    make.top.equalTo(clipTableView.mas_bottom).offset(40 * addCount + 5);
                } else {
                    make.top.equalTo(clipTableView.mas_bottom).offset(40 * addCount + 10);
                }
            }];
        }

        
        [scrollContentView mas_updateConstraints:^(MASConstraintMaker *make) {
            // 让scrollview的contentSize随着内容的增多而变化
            make.bottom.mas_equalTo(cancelBtn.mas_bottom).offset(20);
        }];
        
        // 将要编辑键盘弹出
        [[newClipTextView rac_signalForControlEvents:UIControlEventEditingDidBegin] subscribeNext:^(id x) {
            NSInteger textFileCount = clipArr.count + newClipTextView.tag;

            if (isPhone) {
                if ([Util screenSize].width > [Util screenSize].height) {
                    addClipScroll.contentOffset = CGPointMake(0, ((textFileCount) * 40) + 20);
                } else {
                    if (clipArr.count + newClipTextView.tag > 2) {
                        addClipScroll.contentOffset = CGPointMake(0, ((textFileCount - 2) * 40));
                    } else {
                        addClipScroll.contentOffset = CGPointMake(0, 0);
                    }
                }
            } else {
                if ([Util screenSize].width > [Util screenSize].height) {
                    if (textFileCount > 3) {
                        addClipScroll.contentOffset = CGPointMake(0, (textFileCount - 3) * 40 + 20);
                    } else {
                        addClipScroll.contentOffset = CGPointMake(0, 0);
                    }
                }
            }
            
            
        }];
        
        
        [[newClipTextView rac_signalForControlEvents:UIControlEventEditingDidEnd] subscribeNext:^(id x) {
            NAClipDoc *docNew = [[NAClipDoc alloc] init];
            
            docNew.tagid = [NSString stringWithFormat:@"%ld", (long)newClipTextView.tag];
            docNew.tagName = newClipTextView.text;
            
            if (arrAddTagName.count > 0) {
                for (int i = 0; i < arrAddTagName.count; i++) {
                    NAClipDoc *docOld = arrAddTagName[i];
                    
                    if (docOld.tagid.integerValue == newClipTextView.tag) {
                        [arrAddTagName removeObject:docOld];
                        [arrAddTagName addObject:docNew];
                    } else {
                        [arrAddTagName addObject:docNew];
                    }
                }
            } else {
                [arrAddTagName addObject:docNew];
            }
        }];
        
        lastAddClipTextView = textViewBg;
    }
//    if ((addCount + clipArr.count) > 8) {
//        [addClipScroll removeGestureRecognizer:panGesture];
//    }
    
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


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    CGRect viewFrame = addClipScroll.frame;
    viewFrame.origin.y = 0;
    addClipScroll.frame = viewFrame;
    
    addClipScroll.contentOffset = CGPointMake(0, 0);

    [textField resignFirstResponder];
    
    textField.text = [self filterCharactor:textField.text withRegex:@"[^a-zA-Z0-9\u4e00-\u9fa5\u0800-\u4e00]"];
    
    if (textField.text.length >= 20) {
        textField.text = [textField.text substringToIndex:20];
        
    }
    return NO;
}

- (void) keyboardWillHide:(NSNotification *)notify {
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        CGRect viewFrame = addClipScroll.frame;
        viewFrame.origin.y = 0;
        addClipScroll.frame = viewFrame;
        
        addClipScroll.contentOffset = CGPointMake(0, 0);
    }];
}

- (void)scrollTap:(UITapGestureRecognizer *)sender {
    addClipScroll.contentOffset = CGPointMake(0, 0);
    [self.view endEditing:YES];
}

- (void)backBarItemAction{
    [self.view endEditing:YES];
    if (arrAddTagName.count > 0 || arrChangedTag.count > 0) {
        ITOAST_BOTTOM(@"未保存のラベルが存在");
    } else {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"%f", offsetY);
    if (offsetY < -20) {
        [self.view endEditing:YES];
        if (arrAddTagName.count > 0 || arrChangedTag.count > 0) {
            ITOAST_BOTTOM(@"未保存のラベルが存在");
        } else {
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
    }
}

// 拖动手势
-(void)panGesture:(UIPanGestureRecognizer *)sender
{
    CGPoint movePoint = [sender translationInView:addClipScroll];
    CGFloat newOffSetY = movePoint.y;
    
    if (oldOffSetY != 0) {
        if (newOffSetY - oldOffSetY > 10) {
            [self.view endEditing:YES];
            NSLog(@"下拉下拉下拉差%f", newOffSetY - oldOffSetY);
            if (arrAddTagName.count > 0 || arrChangedTag.count > 0) {
                ITOAST_BOTTOM(@"未保存のラベルが存在");
            } else {
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
            }
        }
    }
    //做你想做的事儿
    oldOffSetY = movePoint.y;
}

- (void)textFiledEditChanged:(NSNotification *)notification {
    NSLog(@"%@", notification.object);
    UITextField *textField = notification.object;
    UITextRange *selectedRange = textField.markedTextRange;
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    
    if (!position) {
        //
        textField.text = [self filterCharactor:textField.text withRegex:@"[^a-zA-Z0-9\u4e00-\u9fa5\u0800-\u4e00]"];
        
        if (textField.text.length >= 20) {
            textField.text = [textField.text substringToIndex:20];
        }
    } else {
    }
}

- (NSString *)filterCharactor:(NSString *)string withRegex:(NSString *)regexStr{
    NSString *searchText = string;
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *result = [regex stringByReplacingMatchesInString:searchText options:NSMatchingReportCompletion range:NSMakeRange(0, searchText.length) withTemplate:@""];
    return result;
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

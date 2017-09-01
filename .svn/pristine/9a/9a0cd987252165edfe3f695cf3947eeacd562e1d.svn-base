
#import "NASettingViewController.h"
#import "NAHomeViewController.h"
#import "FontUtil.h"
@interface NASettingViewController () <UITableViewDataSource, UITableViewDelegate>{
    NSArray *titlearray;
    
    NSArray *downloadinforarray;
    NSArray *controlarray;
    NSArray *resetarray;
    NSArray *infarray;
    
    NSMutableArray *zongarray;
    
    NSInteger fontNum;
    NSInteger spanIndex;
    
}

@property (nonatomic, strong) UITableView *tView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIButton *logoutBtn;
@property (nonatomic, strong) UILabel *notyfiylab;
@property (nonatomic, strong) UILabel *detailnotyfiylab;
//@property (nonatomic, strong) UILabel *datelab;
@property (nonatomic, strong) UILabel *notycontentlab;
@property (nonatomic, strong) UIView *notyview;
@property (nonatomic, strong) UILabel *logininfolab;
@property (nonatomic, strong) UILabel *linelab;
@property (nonatomic, strong) UITextField *usernameTF;
@property (nonatomic, strong) UITextField *passwordTF;
@property (nonatomic, strong) UIWebView *mywebview;

@end

@implementation NASettingViewController

@synthesize isfromWhere;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
        
        NSMutableDictionary *dic2=[[NSMutableDictionary alloc]init];
        [dic2 setObject: [NSArray arrayWithObjects:@"Small Font",@"Middle Font",@"Big Font" , nil] forKey:@"Expansion_rate"];
        NSMutableDictionary *dic3=[[NSMutableDictionary alloc]init];
        [dic3 setObject:[NSArray arrayWithObjects:@"2",@"3",@"4",nil] forKey:@"spannum" ];
        controlarray=[NSArray arrayWithObjects:dic2,dic3, nil];
        NSMutableDictionary *controldic=[[NSMutableDictionary alloc]init];
        [controldic setObject: controlarray forKey:@"control"];
        
        NSMutableDictionary *resetdic=[[NSMutableDictionary alloc]init];
        resetarray=[NSArray arrayWithObjects:@"IDclear",@"delsearchrec",@"deldata", nil];
        [resetdic setObject:resetarray forKey:@"reset"];
        
        infarray=[NSArray arrayWithObjects:@"verinf", nil];
        NSMutableDictionary *infodic=[[NSMutableDictionary alloc]init];
        [infodic setObject:infarray forKey:@"info"];
         if ([self.isfromWhere isEqualToString:@"topPage"]) {
             titlearray=[NSArray arrayWithObjects:@"downloadinfor",@"control",@"reset",@"inf", nil];
         }else{
             titlearray=[NSArray arrayWithObjects:@"downloadinfor",@"control",@"inf", nil];
         }
        //[NASaveData saveAlldownload:[NSNumber numberWithBool:YES]];
        zongarray=[[NSMutableArray alloc]init];
        MAIN(^{
            [zongarray addObject:downloadDic];
            [zongarray addObject:controldic];
            if ([self.isfromWhere isEqualToString:@"topPage"]) {
                
                [zongarray addObject:resetdic];
            }
            
            [zongarray addObject:infodic];
            
            [self.tView reloadData];
        });
        
        
    }));
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(Expansion_rate:)
                                                 name:@"Expansion_rate" object:nil];
    
    
    
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.usernameTF.text=[NASaveData getLoginUserId];
    self.passwordTF.text=[NASaveData getLoginPassWord];
    isSelectpage=[NASaveData getFirstDownload]==0?YES:NO;
    
    BACK(^{
        [self getTheSetting];
        [self saveMyHtml];
    });
    
    fontNum=[NASaveData getExpansion_rateNum];
    spanIndex=[NASaveData getSpanIndex];

    [self.tView reloadData];
    
}
-(void)saveMyHtml{
    NSString *urlString = [NASaveData getInformationUrl];
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [[NAFileManager sharedInstance]saveLoginhtml:data];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [TAGManagerUtil pushOpenScreenEvent:ENSetupView ScreenName:NSLocalizedString(@"settingpage", nil)];
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
    
    [self.tView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self updateViews];
}

/**
 * 画面回転の前処理
 *
 */
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self.tView reloadData];
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self.presentingViewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

/**
 * 画面回転の後処理
 *
 */
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self.presentingViewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

#pragma mark - utility -
#pragma mark

- (void)initViews
{
    [super initViews];
    
    BACK(^{
        if ([NASaveData isFirst])
        {
            NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"init" ofType:@"plist"];
            NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
            NSLog(@"%@", data);
            [NASaveData firstInit:data];
        }
    });
    
    if ([self.isfromWhere isEqualToString:@"topPage"]) {
        self.title = @"アプリ設定";
    }else{
        self.title = @"表示設定";
    }
    [self.view addSubview:self.tView];
    [self.tView setTableHeaderView:_headerView];
    [self.footerView addSubview:self.logoutBtn];
    [self.footerView addSubview:self.linelab];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    
    
}

- (void)updateViews
{
    [super updateViews];
    CGFloat screenWidth = self.view.frame.size.width;
    CGFloat screenHeight = self.view.frame.size.height;
    CGFloat navHeight = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    self.tView.frame = CGRectMake(0, navHeight, screenWidth, screenHeight - navHeight-60);
    self.footerView.frame = CGRectMake(0, screenHeight-60, screenWidth, 60);
    if (![NASaveData getIsVisitorModel]&&[self.isfromWhere isEqualToString:@"topPage"]) {
        self.headerView.frame = CGRectMake(0, 0, screenWidth, 250);
    }else{
        self.headerView.frame = CGRectMake(0, 0, screenWidth, 142);
    }
    self.logoutBtn.center = CGPointMake(screenWidth / 2, 30);
    self.linelab.frame=CGRectMake(0, 0, screenWidth, 0.5);
    //self.notyfiylab.frame=CGRectMake(5, 60, 80, 40);
    //[_headerView addSubview:_notyfiylab];
    [self.view addSubview:self.footerView];
    
    
    _notyfiylab.frame=CGRectMake(10, 15, screenWidth-20, 20);
    self.mywebview.frame=CGRectMake(0, 40,screenWidth, 90);
    
    
    _logininfolab.frame=CGRectMake(10, 135, screenWidth-60, 20);
    _usernameTF.frame=CGRectMake(10, 162, screenWidth-20, 44);
    _passwordTF.frame=CGRectMake(10, 214, screenWidth-20, 44);
    [self.tView setTableHeaderView:_headerView];
}

#pragma mark - layout -
#pragma mark

- (UITableView *)tView
{
    if (!_tView) {
        _tView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tView.delegate = self;
        _tView.dataSource = self;
    }
    return _tView;
}
- (UIView *)headerView
{
    if (!_headerView) {
        //_footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 80)];
        _headerView = [[UIView alloc] initWithFrame:CGRectZero];
        //_headerView.backgroundColor=[UIColor ];
        _notyfiylab=[[UILabel alloc]initWithFrame:CGRectMake(10, 15, self.view.bounds.size.width-20, 40)];
        //_notyfiylab.backgroundColor=[UIColor lightGrayColor];
        _notyfiylab.textColor=[UIColor blackColor];
        _notyfiylab.text=NSLocalizedString(@"notyfiyinfo", nil) ;
        
        [_headerView addSubview:_notyfiylab];
        
        self.mywebview=[[UIWebView alloc]init];
        self.mywebview.delegate=self;
        BACK(^{
            if ([NACheckNetwork sharedInstance].isHavenetwork) {
                NSString *urlString = [NASaveData getInformationUrl];
                NSURL *url = [NSURL URLWithString:urlString];
                NSData *data = [NSData dataWithContentsOfURL:url];
                [self.mywebview loadData:data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:url];
            }else{
                [self.mywebview loadHTMLString:[[NAFileManager sharedInstance]getLoginHtml] baseURL:nil];
            }
            
        });
        
        [_headerView addSubview:self.mywebview];
        
        _notyview = [[UIView alloc] initWithFrame:CGRectMake(0, 40,self.view.bounds.size.width, 40)];
        //_notyview.backgroundColor=[UIColor redColor];
        //[_headerView addSubview:_notyview];
        
        _detailnotyfiylab=[[UILabel alloc]initWithFrame:CGRectMake(0, 40, self.view.bounds.size.width, 20)];
        //_detailnotyfiylab.textColor=[UIColor blackColor];
        _detailnotyfiylab.textAlignment=NSTextAlignmentCenter;
        _detailnotyfiylab.backgroundColor=[UIColor whiteColor];
        _detailnotyfiylab.text=NSLocalizedString(@"notyfiy", nil) ;
        //[_notyview addSubview:_detailnotyfiylab];
        
        _logininfolab=[[UILabel alloc]initWithFrame:CGRectMake(10, 105, self.view.bounds.size.width-60, 20)];
        _logininfolab.textColor=[UIColor blackColor];
        _logininfolab.text=NSLocalizedString(@"logininfor", nil) ;
        [_headerView addSubview:_logininfolab];
        
        _usernameTF=[[UITextField alloc]initWithFrame:CGRectMake(10, 132, self.view.bounds.size.width-20, 44)];
        _usernameTF.delegate=self;
        _usernameTF.backgroundColor=[UIColor whiteColor];
        _usernameTF.placeholder= NSLocalizedString(@"User ID", nil);
        _usernameTF.returnKeyType=UIReturnKeyDone;
        [_headerView addSubview:_usernameTF];
        
        _passwordTF=[[UITextField alloc]initWithFrame:CGRectMake(10, 184, self.view.bounds.size.width-20, 44)];
        _passwordTF.delegate=self;
        _passwordTF.backgroundColor=[UIColor whiteColor];
        _passwordTF.placeholder=NSLocalizedString(@"User PassWord", nil);
        _passwordTF.secureTextEntry=YES;
        [_headerView addSubview:_passwordTF];
        
        if (![NASaveData getIsVisitorModel]&&[self.isfromWhere isEqualToString:@"topPage"]) {
            self.usernameTF.text=[NASaveData getLoginUserId];
            self.passwordTF.text=[NASaveData getLoginPassWord];
            self.usernameTF.enabled=NO;
            self.passwordTF.enabled=NO;
           
            self.passwordTF.textColor=[UIColor lightGrayColor];
            self.usernameTF.backgroundColor=[[UIColor whiteColor] colorWithAlphaComponent:0.5];
            self.passwordTF.backgroundColor=[[UIColor whiteColor] colorWithAlphaComponent:0.5];
            
            _passwordTF.hidden=NO;
            _usernameTF.hidden=NO;
            _logininfolab.hidden=NO;
           
        }else{
            
            _passwordTF.hidden=YES;
            _usernameTF.hidden=YES;
            _logininfolab.hidden=YES;
        }
        
    }
    
    return _headerView;
}

- (UIView *)footerView
{
    if (!_footerView) {
        //_footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 80)];
        _footerView = [[UIView alloc] initWithFrame:CGRectZero];
        _footerView.backgroundColor=[UIColor whiteColor];
    }
    return _footerView;
}

- (UIButton *)logoutBtn
{
    if (!_logoutBtn) {
        _logoutBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _logoutBtn.frame = CGRectMake(0, 0, 80, 40);
        [_logoutBtn setTitle:NSLocalizedString(@"loginbtn", nil) forState:UIControlStateNormal];
        [_logoutBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_logoutBtn addTarget:self action:@selector(logoutBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _logoutBtn.layer.borderColor = [UIColor blackColor].CGColor;
        _logoutBtn.layer.borderWidth = 1.0f;
        _logoutBtn.layer.cornerRadius = 5.0f;
    }
    return _logoutBtn;
    
}
- (UILabel *)linelab
{
    if (!_linelab) {
        _linelab=[[UILabel alloc]initWithFrame:CGRectZero];
        _linelab.backgroundColor=[UIColor lightGrayColor];
    }
    return _linelab;
}

- (UILabel *)notyfiylab
{
    if (!_notyfiylab) {
        _notyfiylab=[[UILabel alloc]initWithFrame:CGRectMake(5, 60, 80, 40)];
        _notyfiylab.backgroundColor=[UIColor lightGrayColor];
        _notyfiylab.textColor=[UIColor blackColor];
        _notyfiylab.text=NSLocalizedString(@"notyfiy", nil) ;
    }
    return _notyfiylab;
}

#pragma mark - button action -
#pragma mark

//logout
- (void)getlogoutAPI
{
    [ProgressHUD show: nil];
    [[NANetworkClient sharedClient] postLogoutWithDevice:NAUserDevice
                                         completionBlock:^(NALogoutModel *logout, NSError *error) {
                                             if (!error) {
                                                 if (logout.status.integerValue == 1) {
                                                     [NASaveData clearLoginInfo];
                                                     //[self.navigationController popViewControllerAnimated:YES];
                                                     [ProgressHUD dismiss];
                                                     
                                                     if (self.usernameTF.text == nil || [self.usernameTF.text isEqualToString:@""]) {
                                                         return;
                                                     }
                                                     if (self.passwordTF.text == nil || [self.passwordTF.text isEqualToString:@""]) {
                                                         return;
                                                     }
                                                     if ([NASaveData isSaveUserInfo]) {
                                                         [NASaveData SaveLoginWithID:self.usernameTF.text   withPassWord:self.passwordTF.text];
                                                     }
                                                     [self closeKeyboard];
                                                     [self getLoginAPI];
                                                     
                                                 }else{
                                                     //[[[iToast makeText:logout.message]setGravity:iToastGravityBottom] show];
                                                     NSLog(@"logout.message==%@",logout.message);
                                                 }
                                             }else{
                                                 [[[iToast makeText:NSLocalizedString(@"networkerror", @"")]
                                                   setGravity:iToastGravityBottom] show];
                                                 
                                             }
                                             [ProgressHUD dismiss];
                                         }];
    
}

- (void)logoutBtnAction:(id)sender
{
    //    [self dismissViewControllerAnimated:YES completion:^{
    //        if (self.logoutCompletionBlock) {
    //            self.logoutCompletionBlock (YES);
    //        }
    //    }];
    [self saveTheSetting];
    if ([NASaveData getIsVisitorModel]&&self.usernameTF.text.length==0&&self.passwordTF.text.length==0) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
        return;
    }
    if ([isfromWhere isEqualToString:@"topPage"]||[isfromWhere isEqualToString:@"setting"]) {
     
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
        return;
    }
    if ([isfromWhere isEqualToString:@"sukuho"]) {
        if ([[self.usernameTF.text uppercaseString] isEqualToString:[[NASaveData getLoginUserId]uppercaseString]]) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            if (self.usernameTF.text == nil || [self.usernameTF.text isEqualToString:@""]) {
                [[[iToast makeText:NSLocalizedString(@"please input userid", @"")]
                  setGravity:iToastGravityBottom] show];
                
                return;
            }
            if (self.passwordTF.text == nil || [self.passwordTF.text isEqualToString:@""]) {
                [[[iToast makeText:NSLocalizedString(@"please input password", @"")]
                  setGravity:iToastGravityBottom] show];
                
                return;
            }
            
            [self closeKeyboard];
            [self getLoginAPI];
        }
        
        
    }else{
        if (self.usernameTF.text == nil || [self.usernameTF.text isEqualToString:@""]) {
            [[[iToast makeText:NSLocalizedString(@"please input userid", @"")]
              setGravity:iToastGravityBottom] show];
            return;
        }
        if (self.passwordTF.text == nil || [self.passwordTF.text isEqualToString:@""]) {
            [[[iToast makeText:NSLocalizedString(@"please input password", @"")]
              setGravity:iToastGravityBottom] show];
            return;
        }
        
        [self closeKeyboard];
        [self getLoginAPI];
        
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}
- (void)closeKeyboard
{
    [self.usernameTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];
}

#pragma mark - tableView delegate -
#pragma mark

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [zongarray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *myKey=[zongarray objectAtIndex:section];
    NSArray *array=[[myKey allValues]objectAtIndex:0];
    return array.count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;{
    NSString *tmptitle=[titlearray objectAtIndex:section];
    return NSLocalizedString(tmptitle, nil);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *myKey=[zongarray objectAtIndex:indexPath.section];
    NSArray *array=[[myKey allValues]objectAtIndex:0];
    if ([[[myKey allKeys]objectAtIndex:0] isEqualToString:@"download"]) {
        if (indexPath.row==2) {
            static NSString *CellIdentifier = @"NARadioButtonTableViewCell";
            NARadioButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[NARadioButtonTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }
            //cell.isSelectone=[NASaveData getFirstDownload]==0?YES:NO;
            
            cell.oneButton.tag=0;
            cell.otherButton.tag=1;
            [cell.otherButton addTarget:self action:@selector(changeQy:) forControlEvents:UIControlEventTouchUpInside];
            [cell.oneButton addTarget:self action:@selector(changeQy:) forControlEvents:UIControlEventTouchUpInside];
            if (isSelectpage) {
                [cell.oneButton setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
                [cell.otherButton setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                
            }else{
                [cell.oneButton setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                [cell.otherButton setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
                
            }
            
            
            return cell;
        }else{
            static NSString *CellIdentifier = @"NASetSwithTableViewCell";
            NASetSwithTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[NASetSwithTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
            }
            NSMutableDictionary *dic=[array objectAtIndex:indexPath.row];
            cell.mytitlelab.text=NSLocalizedString([[dic allKeys]objectAtIndex:0], nil);
            cell.mytitlelab.textColor = [UIColor blueColor];
            cell.mytitlelab.font=[FontUtil systemFontOfSize:17];
            NSNumber *mynum=[[dic allValues]objectAtIndex:0];
            [cell.myswitch setOn:mynum.boolValue];
            cell.myswitch.tag=indexPath.row;
            [cell.myswitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
            return cell;
        }
        
    }else if ([[[myKey allKeys]objectAtIndex:0] isEqualToString:@"control"]){
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        //NSString *title=[array objectAtIndex:indexPath.row];
        NSMutableDictionary *dic=[array objectAtIndex:indexPath.row];
        cell.textLabel.text =NSLocalizedString([[dic allKeys]objectAtIndex:0], nil);
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor blueColor];
        cell.textLabel.font=[FontUtil systemFontOfSize:17];
        NSInteger index;
        if (indexPath.row==0) {
            index= [NASaveData getExpansion_rateNum];
        }else{
            index= [NASaveData getSpanIndex];
        }
        
        cell.detailTextLabel.text =NSLocalizedString([[[dic allValues]objectAtIndex:0] objectAtIndex:index],nil);
        
        cell.detailTextLabel.textAlignment = NSTextAlignmentLeft;
        
        return cell;
    }else if ([[[myKey allKeys]objectAtIndex:0] isEqualToString:@"info"]){
        static NSString *CellIdentifier = @"myCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        NSString *title=[array objectAtIndex:indexPath.row];
        cell.textLabel.text =NSLocalizedString(title, nil);
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor blueColor];
        cell.textLabel.font=[FontUtil systemFontOfSize:17];
        NSString *ver=[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        cell.detailTextLabel.text=ver;
        cell.detailTextLabel.textAlignment = NSTextAlignmentLeft;
        return cell;
        
        
    }else{
        static NSString *CellIdentifier = @"myCell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        
        NSString *title=[array objectAtIndex:indexPath.row];
        cell.textLabel.text =NSLocalizedString(title, nil);
        cell.textLabel.textColor=[UIColor blueColor];
        cell.textLabel.font=[FontUtil systemFontOfSize:17];
        return cell;
        
    }
}
-(IBAction)changeQy:(UIButton *)sender{
    
    if (isSelectpage) {
        isSelectpage=NO;
        
    }else{
        isSelectpage=YES;
        
    }
    [self.tView reloadData];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    //NSArray *array=[zongarray objectAtIndex:indexPath.section];
    NSDictionary *myKey=[zongarray objectAtIndex:indexPath.section];
    //NSArray *array=[[myKey allValues]objectAtIndex:0];
    if ([[[myKey allKeys]objectAtIndex:0] isEqualToString:@"control"]) {
        if (indexPath.row==0) {
            
            naexview=[[NAExpansionView alloc]init];
            naexview.showtype=TYPE_PAGETATE;
            naexview.backgroundColor=[UIColor clearColor];
            naexview.checkarray= [NSArray arrayWithObjects:@"小",@"中",@"大", nil];
            NSInteger index= [NASaveData getExpansion_rateNum];
            naexview.seclectindex=index;
            //naexview.alpha=0.4;
            [naexview show];
        }else if(indexPath.row==1){
            naexview=[[NAExpansionView alloc]init];
            naexview.showtype=TYPE_SPANNUM;
            naexview.checkarray= [NSArray arrayWithObjects:@"2",@"3",@"4", nil];
            naexview.backgroundColor=[UIColor clearColor];
            NSInteger index= [NASaveData getSpanIndex];
            naexview.seclectindex=index;
            //naexview.alpha=0.4;
            [naexview show];
        }
        
    }else if([[[myKey allKeys]objectAtIndex:0] isEqualToString:@"reset"])
    {
        if (indexPath.row == 0) {
            
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"ID／パスワードをクリアしますか？" message:@"" delegate:self cancelButtonTitle:@"はい" otherButtonTitles:@"いいえ", nil];
            alert.tag = 0;
            [alert show];
            
        }else if(indexPath.row==1)
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"検索履歴を削除しますか？" message:@"" delegate:self cancelButtonTitle:@"はい" otherButtonTitles:@"いいえ", nil];
            alert.tag = 1;
            [alert show];
            
        }else if(indexPath.row==2)
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"全てのデータを削除しますか？" message:@"" delegate:self cancelButtonTitle:@"はい" otherButtonTitles:@"いいえ", nil];
            alert.tag = 2;
            [alert show];
            
        }
    }
}
-(void)switchAction:(UISwitch*)sender
{
    //UISwitch *switchButton = (UISwitch*)sender;
    NSMutableDictionary *dic=[downloadinforarray objectAtIndex:[sender tag]];
    //BOOL isButtonOn = [switchButton isOn];
    if ([sender tag]==0) {
        BOOL isLoginStatus = [NASaveData isSaveUserInfo];
        [dic setObject:[NSNumber numberWithBool:sender.isOn] forKey:@"autologin"];
        //[NASaveData saveUserInfo:[NSNumber numberWithBool:!isLoginStatus]];
        if (!isLoginStatus) {
            //[dic setObject:@"Yes" forKey:@"autologin"];
            //[NASaveData SaveLoginWithID:self.usernameTF.text withPassWord:self.passwordTF.text];
            
        }else {
            //[dic setObject:@"No" forKey:@"autologin"];
            
        }
    }else if ([sender tag]==1){
        //[NASaveData saveAlldownload:[NSNumber numberWithBool:sender.isOn]];
        [dic setObject:[NSNumber numberWithBool:sender.isOn] forKey:@"alldownload"];
    }
    [self.tView reloadData];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        return;
    }
    switch (alertView.tag) {
        case 0:
        {
            _usernameTF.text=@"";
            _passwordTF.text=@"";
            [self clearCookie];
            [NASaveData saveIsVisitorModel:YES];
            [NASaveData clearLoginInfo];
            break;
        }
        case 1:
        {
            [[NAFileManager sharedInstance] deleteSearchResult];
            [[[iToast makeText:NSLocalizedString(@"delete done", nil)]
              setGravity:iToastGravityBottom] show];
            break;
        }case 2:
        {
            _usernameTF.text=@"";
            _passwordTF.text=@"";
            [[NAFileManager sharedInstance] deleteSearchResult];
            [[NAFileManager sharedInstance] deleteDetailInfo];
            [[NASQLHelper sharedInstance]clearFeedTable];
            [NASaveData saveIsVisitorModel:YES];
            [NASaveData clearLoginInfo];
            [self clearCookie];
            [[[iToast makeText:NSLocalizedString(@"delete done", nil)]
              setGravity:iToastGravityBottom] show];
            break;
        }
            
        default:
            break;
    }
}
-(void)clearCookie{
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        [storage deleteCookie:cookie];
    }
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
- (void)getLoginAPI
{
    NSString *deviceModel = isPad ? @"N01" : @"N02";
    
    [ProgressHUD show:NSLocalizedString(@"logininloading", nil)];
    
    [[NALoginClient sharedClient] postLoginwithUserId:self.usernameTF.text
                                         withPassword:self.passwordTF.text
                                      withDeviceModel:deviceModel
                                      completionBlock:^(NALoginModel *login, NSError *error) {
                                          
                                          if (error == nil) {
                                              NSLog(@"login.status==%@",login.status);
                                              if (login.status.integerValue == 1) {
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      //[ProgressHUD dismissWithNoAnimation];
                                                      [NASaveData saveIsVisitorModel:NO];
                                                      [NASaveData SaveLoginWithID:login.userId withPassWord:login.password];
                                                      [NASaveData saveTimeStamp:login.timeStamp];
                                                      
                                                      
                                                      [self saveTheSetting];
                                                      
                                                      NSDictionary *alluserdic=[NASaveData getALLUser];
                                                      NSMutableDictionary *alldic;
                                                      if (alluserdic) {
                                                          NSDictionary *alluserdic=[NASaveData getALLUser];
                                                          NSDictionary *valuedic=[alluserdic objectForKey:[[NASaveData getLoginUserId] uppercaseString]];
                                                          NSMutableDictionary *changevaluedic=[NSMutableDictionary dictionaryWithDictionary:valuedic];
                                                          [changevaluedic setObject:login.password forKey:userpassword];
                                                          
                                                          NSMutableDictionary *changealluser=[NSMutableDictionary dictionaryWithDictionary:alluserdic];
                                                          [changealluser setObject:changevaluedic forKey:[[NASaveData getLoginUserId] uppercaseString]];
                                                          [NASaveData saveALLUser:changealluser];
                                                      }else{
                                                          alldic=[[NSMutableDictionary alloc]init];
                                                          NSDictionary *valuedic=[NSDictionary dictionaryWithObjectsAndKeys:login.password,userpassword,[NSNumber numberWithBool:NO],ishavenote, nil];
                                                          [alldic setValue:valuedic forKey:[login.userId uppercaseString]];
                                                          [NASaveData saveALLUser:alldic];
                                                      }
                                                      NSDictionary *tmpdic=[NASaveData getALLUser];
                                                      NSLog(@"tmpdic==%@",tmpdic);
                                                      
                                                      //                                                  [ProgressHUD showSuccess:NSLocalizedString(@"Login Success", nil)];
                                                      if ([isfromWhere isEqualToString:@"login"]) {
                                                          
                                                          NAHomeViewController *home = [[NAHomeViewController alloc] init];
                                                          [self.navigationController pushViewController:home animated:YES];
                                                          
                                                      }else{
                                                          //[[NAFileManager sharedInstance] deleteDetailInfo];
                                                          [[NADownloadHelper sharedInstance] cancel];
                                                          //[[NSNotificationCenter defaultCenter] postNotificationName:@"changeUser" object:nil userInfo:nil];
                                                          [self dismissViewControllerAnimated:YES completion:^{
                                                              if (self.logoutCompletionBlock) {
                                                                  self.logoutCompletionBlock (YES);
                                                              }
                                                          }];
                                                          ;
                                                          
                                                      }
                                                      
                                                      
                                                  });
                                              }else if (login.status.integerValue == 2) {
                                                  [[[iToast makeText:NSLocalizedString(@"Login Error With UserId or Password", nil)]
                                                    setGravity:iToastGravityBottom] show];
                                                  [ProgressHUD dismiss];
                                              }else if (login.status.integerValue == 3) {
                                                  [[[iToast makeText:NSLocalizedString(@"Login Error With UserId", nil)]
                                                    setGravity:iToastGravityBottom] show];
                                                  [ProgressHUD dismiss];
                                                  
                                              }else if (login.status.integerValue == 4) {
                                                  [[[iToast makeText:NSLocalizedString(@"Login Error With Password", nil)]
                                                    setGravity:iToastGravityBottom] show];
                                                  [ProgressHUD dismiss];
                                                  
                                              }else if (login.status.integerValue == 5) {
                                                  [[[iToast makeText:NSLocalizedString(@"Login Error With UseDevice", nil)]
                                                    setGravity:iToastGravityBottom] show];
                                                  [ProgressHUD dismiss];
                                                  
                                              }else if (login.status.integerValue == 6) {
                                                  [[[iToast makeText:NSLocalizedString(@"Login Error With UseDevice nil", nil)]
                                                    setGravity:iToastGravityBottom] show];
                                                  [ProgressHUD dismiss];
                                                  
                                              }else{
                                                  [[[iToast makeText:NSLocalizedString(@"Login Error With UseDevice nil", nil)]
                                                    setGravity:iToastGravityBottom] show];
                                                  [ProgressHUD dismiss];
                                                  
                                              }
                                              
                                          }else{
                                              if (error.domain) {
                                                  //[[[iToast makeText:error.domain]setGravity:iToastGravityBottom] show];
                                                  NSLog(@"logout.message==%@",error.domain);
                                              } else {
                                                  [[[iToast makeText:NSLocalizedString(@"Login Error With UserId or Password", nil)]
                                                    setGravity:iToastGravityBottom] show];
                                              }
                                              
                                              [ProgressHUD dismiss];
                                          }
                                      }];
}


@end

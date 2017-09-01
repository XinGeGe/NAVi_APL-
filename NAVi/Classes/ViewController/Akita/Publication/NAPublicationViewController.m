
#import "NAPublicationViewController.h"
#import "FontUtil.h"

@implementation NAPublicationViewController{
    NALoginAlertView *myalertview;
    BOOL isTempAutoLogin;
    BOOL isTempAllDownload;
    NADoc *currentDoc;
    BOOL isShowTopWeb;
    
    NAAgreementViewController *agvc;
    UIBarButtonItem *notloginItem;
    BOOL isCanTopUrl;
}
- (void)initViews
{
    [super initViews];
    if (![NASaveData getIsVisitorModel]) {
        self.title=NSLocalizedString(@"topPage", nil);
    }
    self.navigationItem.leftBarButtonItem = nil;
    [self.view addSubview:self.tView];
    self.dateSelectedArray = [NSMutableArray array];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tView.hidden = YES;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:NSLocalizedString(@"not login", nil) forState:UIControlStateNormal];
    //[button addTarget:self action:@selector(notLoginAction) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 100, 40);
    button.titleLabel.font=[FontUtil systemFontOfSize:14];
    
    notloginItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    if ([NASaveData getIsVisitorModel]) {
        self.navigationItem.rightBarButtonItem=notloginItem;
    }
    
    NSDictionary *changedic=[NAFileManager ChangePlistTodic];
    NSNumber *myshow=[changedic objectForKey:NAISSHOWTOPOSIRASE];
    isShowTopWeb=myshow.boolValue;
    NSString *urlString = [NASaveData getTopUrl];
    isCanTopUrl = [Util webFileExists:urlString];
    if (myshow.boolValue&&isCanTopUrl) {
        [self addTopOsiraseWeb];
    }
    
    UIButton  *menubtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menubtn.frame = CGRectMake(0, 0, 80, 49);
    //[menubtn setImage:[UIImage imageNamed:@"menu_menu_on"] forState:UIControlStateNormal];
    [menubtn setTitle:NSLocalizedString(@"Menu", nil) forState:UIControlStateNormal];
    [menubtn addTarget:self action:@selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];
    menubtn.backgroundColor = [UIColor clearColor];
    UIBarButtonItem *menubar= [[UIBarButtonItem alloc] initWithCustomView:menubtn];
    
    self.toolBar.items=[NSArray arrayWithObjects:menubar,nil];
    [self.view addSubview:self.toolBar];
    
}

/**
 * view更新
 *
 */
- (void)updateViews
{
    [super updateViews];
    CGFloat screenWidth = self.view.frame.size.width;
    CGFloat screenHeight = self.view.frame.size.height;
    CGFloat navHeight = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    CGFloat barHeight = 44;
    if (isShowTopWeb&&isCanTopUrl) {
        self.tView.frame = CGRectMake(0, navHeight+75, screenWidth, screenHeight - navHeight-barHeight-75);
    }else{
        self.tView.frame = CGRectMake(0, navHeight, screenWidth, screenHeight - navHeight-barHeight);
    }
    
    self.mywebview.frame=CGRectMake(0, navHeight+5, self.view.frame.size.width, 70);
    self.toolBar.frame=CGRectMake(0, screenHeight - barHeight, self.view.frame.size.width, barHeight);
}

- (void)showMenu:(UIButton *)sender
{
    NSArray *menuItems;
    
    menuItems =@[
                 
                 [KxMenuItem menuItem:@"利用規約"
                                image:nil
                               target:self
                               action:@selector(pushMenuItem:)],
                 
                 [KxMenuItem menuItem:@"アプリ設定"
                                image:nil
                               target:self
                               action:@selector(pushMenuItem:)],
                 
                 [KxMenuItem menuItem:@"ログアウト"
                                image:nil
                               target:self
                               action:@selector(pushMenuItem:)],
                 
                 
                 
                 ];
    
    
    
    [KxMenu showMenuInView:self.view
                  fromRect:CGRectMake(self.toolBar.frame.origin.x, self.toolBar.frame.origin.y, self.toolBar.frame.size.width/4, self.toolBar.frame.size.height)
                 menuItems:menuItems];
    
}
- (void) pushMenuItem:(id)sender
{
    KxMenuItem *myitem=sender;
    //NSLog(@"%@", myitem.title);
    if ([myitem.title isEqualToString:@"利用規約"]) {
        agvc=[[NAAgreementViewController alloc]init];
        agvc.delegate=self;
        NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:agvc];
        [self presentViewController:nav animated:YES completion:^{
            agvc.agreeBtn.hidden=YES;
            agvc.notAgreeBtn.hidden=YES;
            agvc.OkBtn.hidden=NO;
        }];
        
    }else if ([myitem.title isEqualToString:@"アプリ設定"]){
        NASettingViewController *naset=[[NASettingViewController alloc]init];
        naset.isfromWhere=@"topPage";
        NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:naset];
        [self presentViewController:nav animated:YES completion:nil];
    }else if ([myitem.title isEqualToString:@"ログアウト"]){
        //[NASaveData saveUserInfo:[NSNumber numberWithBool:NO]];
        [NASaveData saveIsVisitorModel:YES];
        [NASaveData clearLoginInfo];
        self.navigationItem.rightBarButtonItem=notloginItem;
        [self.tView reloadData];
        [self notLoginAction];
        ITOAST_BOTTOM(@"ログアウト ok");
        //        [self dismissViewControllerAnimated:YES completion:^{
        //
        //        }];
        //[[(AppDelegate *)[UIApplication sharedApplication].delegate loginViewController]showLogin];
        
    }
}
-(void)notLoginAction{
    myalertview=[[NALoginAlertView alloc]init];
    myalertview.delegate=self;
//    isTempAutoLogin=myalertview.saveIDSwitch.isOn;
//    isTempAllDownload=myalertview.allDownloadSwitch.isOn;
    [myalertview show];
}
-(void)cancelLoginClick{
    
}

-(void)IAgree{
    [agvc dismissViewControllerAnimated:YES completion:nil];
}

-(void)addTopOsiraseWeb{
    
    self.mywebview=[[UIWebView alloc]initWithFrame:CGRectMake(0,5, self.view.frame.size.width, 70)];
    self.mywebview.delegate=self;
    //self.mywebview.userInteractionEnabled=NO;
    BACK(^{
        if ([NACheckNetwork sharedInstance].isHavenetwork) {
            NSString *urlString = [NASaveData getTopUrl];
            NSURL *url = [NSURL URLWithString:urlString];
            NSData *data = [NSData dataWithContentsOfURL:url];
            [self.mywebview loadData:data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:url];
            [[NAFileManager sharedInstance]saveTophtml:data];
            
        }else{
            [self.mywebview loadHTMLString:[[NAFileManager sharedInstance]getTopHtml] baseURL:nil];
        }
        
    });
    //[self.view addSubview:self.mywebview];
    //self.tView.tableHeaderView=self.mywebview;
}


#pragma mark - tableView delegate -
#pragma mark

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([NASaveData getIsHaveWebBtn]||[NASaveData getIsHaveExtraImage]) {
        return 2;
    }else{
        return 1;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isPad) {
        if (section==0) {
            NSInteger count  = 0;
            NSInteger item = isPad ? 4 : 2;
            count = self.dateSelectedArray.count / item;
            if (self.dateSelectedArray.count % item != 0) {
                count = count + 1;
            }
            return count;
        }else{
            return 1;
        }
    }else{
        if (section==0) {
            NSInteger count  = 0;
            NSInteger topCount = 0;
            topCount=self.dateSelectedArray.count;
            NSInteger item = isPad ? 4 : 2;
            count = topCount / item;
            if (topCount% item != 0) {
                count = count + 1;
            }
            return count;
        }else{
            if (![NASaveData getIsHaveExtraImage]&![NASaveData getIsHaveWebBtn]) {
                return 0;
            }else{
                return 1;
            }
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat ret = 190.0f;
    if (isPad) {
        ret = 240.0f;
    }
    return ret;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==1) {
        return 2;
    }else{
        return 0;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==1) {
        UIView *myBackview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 2)];
        myBackview.backgroundColor=[UIColor lightGrayColor];
        return myBackview;
    }else{
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isPad) {
         if (indexPath.section==0) {
        static NSString *CellIdentifier = @"Cell";
        NADocPadCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[NADocPadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        NSInteger index = indexPath.row * 4;
        if (index < self.dateSelectedArray.count) {
            NADoc *doc = self.dateSelectedArray[index];
            cell.docView1.tag = index + 1;
            [self setMyCollectionView:cell.docView1 withDoc:doc];
        }
        index = indexPath.row * 4 + 1;
        if (index < self.dateSelectedArray.count) {
           NADoc *doc = self.dateSelectedArray[index];
            cell.docView2.tag = index + 1;
            [self setMyCollectionView:cell.docView2 withDoc:doc];
        }
        index = indexPath.row * 4 + 2;
        if (index < self.dateSelectedArray.count) {
            NADoc *doc = self.dateSelectedArray[index];
            cell.docView3.tag = index + 1;
            [self setMyCollectionView:cell.docView3 withDoc:doc];
        }
        index = indexPath.row * 4 + 3;
        if (index < self.dateSelectedArray.count) {
           NADoc *doc = self.dateSelectedArray[index];
            cell.docView4.tag = index + 1;
            [self setMyCollectionView:cell.docView4 withDoc:doc];
        }
        cell.selectedObjectCompletionBlock = ^(id object) {
            UIView *view = (UIView *)object;
            NADoc *tmpDoc=self.dateSelectedArray[view.tag - 1];
            currentDoc=tmpDoc;
            if (![NASaveData getIsVisitorModel]) {
               
                [self dismissViewControllerAnimated:YES completion:^{
                    if (self.selectedDocCompletionBlock) {
                        self.selectedDocCompletionBlock (tmpDoc);
                    }
                    
                }];
                
            }else{
                if ([tmpDoc.publication_disOrder3 isEqualToString:@"1"]) {
                    //无料
                    [self dismissViewControllerAnimated:YES completion:^{
                        if (self.selectedDocCompletionBlock) {
                            self.selectedDocCompletionBlock (tmpDoc);
                        }
                        
                    }];
                }else{
                    [self notLoginAction];
                }
            }

            
        };
        return cell;
         }else{
             static NSString *CellIdentifier = @"webCell";
             NADocPadCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
             if (cell == nil) {
                 cell = [[NADocPadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
             }
             
             
             if ([NASaveData getIsHaveWebBtn]) {
                 [cell.docView1.imageView setImage:[UIImage imageNamed:@"web.png"]];
                 [cell.docView1 updateMainTitleWithName:@"Web"];
                 [cell.docView1 updateTitleWithName:@""];
                 cell.docView1.tag = 1;
                 if ([NASaveData getIsHaveExtraImage]) {
                     [cell.docView2.imageView setImage:[UIImage imageNamed:@"extraImage.png"]];
                     [cell.docView2 updateMainTitleWithName:NSLocalizedString(@"extra", nil) ];
                     [cell.docView2 updateTitleWithName:@""];
                     cell.docView2.tag = 2;
                 }
                 
                 cell.selectedObjectCompletionBlock = ^(id object) {
                     UIView *view = (UIView *)object;
                     if (view.tag) {
                         if (view.tag==1) {
                             [self toTOWebViewControllerWithUrlStr:[NASaveData getWebUrl]];
                         }else{
                             [self toTOWebViewControllerWithUrlStr:[NASaveData getExtraUrl]];
                         }
                     }
                 };
             }else{
                 if ([NASaveData getIsHaveExtraImage]) {
                     [cell.docView1.imageView setImage:[UIImage imageNamed:@"extraImage.png"]];
                     [cell.docView1 updateMainTitleWithName:NSLocalizedString(@"extra", nil) ];
                     [cell.docView1 updateTitleWithName:@""];
                     
                     cell.selectedObjectCompletionBlock = ^(id object) {
                         UIView *view = (UIView *)object;
                         if (view.tag) {
                             [self toTOWebViewControllerWithUrlStr:[NASaveData getExtraUrl]];
                             
                         }
                     };
                     
                 }
                 
             }
             return cell;
             
             
         }

        
    }else{
        if (indexPath.section==0) {
        static NSString *CellIdentifier = @"Cell";
        NADocCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[NADocCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.leftDocView.hidden=YES;
        cell.rightDocView.hidden=YES;
        
        NSInteger index = indexPath.row * 2;
        NADoc *doc;
        if (index < self.dateSelectedArray.count) {
            cell.leftDocView.hidden=NO;
            doc = self.dateSelectedArray[index];
            cell.leftDocView.tag = index;
            [self setMyCollectionView:cell.leftDocView withDoc:doc];
            
        }
        
        

        index = indexPath.row * 2 + 1;
        if (index < self.dateSelectedArray.count) {
            cell.rightDocView.hidden=NO;
            doc = self.dateSelectedArray[index];
            cell.rightDocView.tag = index;
            [self setMyCollectionView:cell.rightDocView withDoc:doc];
            
        }
        
            

        
        cell.selectedObjectCompletionBlock = ^(id object) {
            
            UIView *view = (UIView *)object;
            if (view.tag <self.dateSelectedArray.count) {
                NADoc *tmpDoc=self.dateSelectedArray[view.tag];
                currentDoc=tmpDoc;
                if (![NASaveData getIsVisitorModel]) {
                    [self dismissViewControllerAnimated:YES completion:^{
                        if (self.selectedDocCompletionBlock) {
                            self.selectedDocCompletionBlock (self.dateSelectedArray[view.tag ]);
                        }
                        
                    }];
                    
                }else{
                    if ([tmpDoc.publication_disOrder3 isEqualToString:@"1"]) {
                        //无料
                        [self dismissViewControllerAnimated:YES completion:^{
                            if (self.selectedDocCompletionBlock) {
                                self.selectedDocCompletionBlock (self.dateSelectedArray[view.tag ]);
                            }
                            
                        }];
                    }else{
                        [self notLoginAction];
                    }
                }
                
            }
        };
        
        return cell;
        }else{
            static NSString *CellIdentifier = @"Cell";
            NADocCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[NADocCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            cell.leftDocView.hidden=YES;
            cell.rightDocView.hidden=YES;
            
            if ([NASaveData getIsHaveWebBtn]) {
                cell.leftDocView.imageIdentfier.hidden=YES;
                cell.leftDocView.hidden=NO;
                cell.leftDocView.tag = 1;
                [cell.leftDocView.imageView setImage:[UIImage imageNamed:@"web.png"]];
                [cell.leftDocView updateMainTitleWithName:@"Web"];
                [cell.leftDocView updateTitleWithName:@""];
                if ([NASaveData getIsHaveExtraImage]) {
                    cell.rightDocView.imageIdentfier.hidden=YES;
                    cell.rightDocView.hidden=NO;
                    cell.rightDocView.tag = 2;
                    [cell.rightDocView.imageView setImage:[UIImage imageNamed:@"extraImage.png"]];
                    [cell.rightDocView updateMainTitleWithName:NSLocalizedString(@"extra", nil) ];
                    [cell.rightDocView updateTitleWithName:@""];
                }
            }else{
                if ([NASaveData getIsHaveExtraImage]) {
                    cell.leftDocView.imageIdentfier.hidden=YES;
                    cell.leftDocView.hidden=NO;
                    cell.leftDocView.tag = 2;
                    [cell.leftDocView.imageView setImage:[UIImage imageNamed:@"extraImage.png"]];
                    [cell.leftDocView updateMainTitleWithName:NSLocalizedString(@"extra", nil) ];
                    [cell.leftDocView updateTitleWithName:@""];
                    
                }
            }
            cell.selectedObjectCompletionBlock = ^(id object) {
                UIView *view = (UIView *)object;
                if (view.tag==1){
                    [self toTOWebViewControllerWithUrlStr:[NASaveData getWebUrl]];
                }else if (view.tag==2){
                    [self toTOWebViewControllerWithUrlStr:[NASaveData getExtraUrl]];
                }
            };
            return cell;
        }
    }
}

#pragma mark - NALoginAlertView delegate -
#pragma mark
-(void)loginClick:(NSString *)username Password:(NSString *)password{
    [self getLoginAPIWithUsername:username ThePassword:password];
}
- (void)getLoginAPIWithUsername:(NSString *)username ThePassword:(NSString *)password
{
    NSString *deviceModel = isPad ? @"N01" : @"N02";
    
    [ProgressHUD show:NSLocalizedString(@"logininloading", nil)];
    
    [[NALoginClient sharedClient] postLoginwithUserId:username
                                         withPassword:password
                                      withDeviceModel:deviceModel
                                      completionBlock:^(NALoginModel *login, NSError *error) {
                                          
                                          if (error == nil) {
                                              if (login.status.integerValue == 1) {
                                                  self.navigationItem.rightBarButtonItem=nil;
                                                  [myalertview dismissMyview];
                                                  [NASaveData saveIsVisitorModel:NO];
                                                  [NASaveData saveUserInfo:[NSNumber numberWithBool:isTempAutoLogin]];
                                                  [NASaveData saveAlldownload:[NSNumber numberWithBool:isTempAllDownload]];
                                                  
                                                  if (isTempAutoLogin) {
                                                      [NASaveData SaveLoginWithID:login.userId withPassWord:login.password];
                                                      
                                                  }
                                                  [self dismissViewControllerAnimated:YES completion:^{
                                                      if (self.selectedDocCompletionBlock) {
                                                          self.selectedDocCompletionBlock (currentDoc);
                                                      }
                                                  }];
                                                  return ;
                                                  //navigation = [[NABaseNavigationController alloc] initWithRootViewController:home];
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
                                              ITOAST_BOTTOM(error.localizedDescription);
                                              [ProgressHUD dismiss];
                                              
                                          }
                                          
                                      }];
}

-(void)switchDidChange:(BOOL)isAutoLogin TheAllDownload:(BOOL)isAllDownload{
    isTempAutoLogin=isAutoLogin;
    isTempAllDownload=isAllDownload;
}
-(void)setMyCollectionView:(UIView *)myCollectionView withDoc:(NADoc *)mydoc{
    NASubPagerView *myPageView=(NASubPagerView *)myCollectionView;
    [myPageView imageViewWthInfo:mydoc];
    [myPageView updateMainTitleWithName:[self getMainTitleText:mydoc]];
    [myPageView updateTitleWithName:[self getSubTitleText:mydoc]];
    
    
    if ([NASaveData getIsVisitorModel]) {
        myPageView.imageIdentfier.hidden=NO;
        //无料
        if ([mydoc.publication_disOrder3 isEqualToString:@"1"]) {
            [myPageView.imageIdentfier setImage:[UIImage imageNamed:@"icon_mark_sample"]];
        }else{
            [myPageView.imageIdentfier setImage:[UIImage imageNamed:@"icon_mark_cost"]];
        }
        
    }
    
}

-(void)toTOWebViewControllerWithUrlStr:(NSString *)urlStr{
    NSURL *url =[NSURL URLWithString:urlStr];
    TOWebViewController *webViewController = [[TOWebViewController alloc] initWithURL:url];
    //webViewController.navigationButtonsHidden=YES;
    webViewController.showActionButton=NO;
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:webViewController] animated:YES completion:nil];
}

@end

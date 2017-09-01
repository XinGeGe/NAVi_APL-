//
//  NAAgreementViewController.m
//  NAVi
//
//  Created by y fs on 15/12/2.
//  Copyright © 2015年 dxc. All rights reserved.
//

#import "NAAgreementViewController.h"

@implementation NAAgreementViewController

@synthesize agreeBtn;
@synthesize notAgreeBtn;
@synthesize OkBtn;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[Util colorWithHexString:@"e6e6e6"];
    self.title=NSLocalizedString(@"agreement title", nil);
    self.myWebView=[[UIWebView alloc]init];
    self.myWebView.delegate=self;
    //[self.myWebView loadHTMLString:[[NAFileManager sharedInstance]getLoginHtml] baseURL:nil];
    NSDictionary *dic=[NAFileManager ChangePlistTodic];
    NSString *urlStr=[dic objectForKey:PROTOCOLURL];
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] ];
    [self.view addSubview:self.myWebView];
    
    agreeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    agreeBtn.tag=101;
    [agreeBtn setTitle:NSLocalizedString(@"agree", nil) forState:UIControlStateNormal];
    [agreeBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [agreeBtn addTarget:self action:@selector(agreeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:agreeBtn];
    
    notAgreeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    notAgreeBtn.tag=102;
    [notAgreeBtn setTitle:NSLocalizedString(@"not agree", nil) forState:UIControlStateNormal];
    [notAgreeBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [notAgreeBtn addTarget:self action:@selector(agreeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:notAgreeBtn];
    
    OkBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    OkBtn.tag=103;
    [OkBtn setTitle:@"ok" forState:UIControlStateNormal];
    [OkBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [OkBtn addTarget:self action:@selector(agreeAction:) forControlEvents:UIControlEventTouchUpInside];
    OkBtn.hidden=YES;
    [self.view addSubview:OkBtn];
}
/**
 * view初期化
 *
 */
- (void)initViews
{
    [super initViews];
    
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
    self.myWebView.frame=CGRectMake(10, 10, screenWidth-20, screenHeight-80);
    agreeBtn.frame=CGRectMake(screenWidth-110, screenHeight-70, 100, 40);
    notAgreeBtn.frame=CGRectMake(10, screenHeight-70, 100, 40);
    OkBtn.frame=CGRectMake((screenWidth-100)/2, screenHeight-70, 100, 40);
    
}
-(IBAction)agreeAction:(UIButton *)sender{
    if (sender.tag==102) {
        //ITOAST_BOTTOM(NSLocalizedString(@"not agree", nil));
        UIAlertViewWithBlock *alert= [[UIAlertViewWithBlock alloc] initWithTitle:@"" message:NSLocalizedString(@"not agreement", nil) cancelButtonTitle:@"いいえ" otherButtonTitles:@"はい", nil];
        [alert showWithDismissHandler:^(NSInteger selectedIndex) {
            switch (selectedIndex) {
                case 1: {
                    
                    
                } break;
                case 0: {
                    exit(0);
                   
                }
                default:
                    NSLog(@"case default:");
                    break;
            }
            
            
        }];

    }else if(sender.tag==101){
        [NASaveData saveIsAgreeMent:[NSNumber numberWithBool:YES ]];
        [self.delegate IAgree];
    }else if(sender.tag==103){
        [self.delegate IAgree];
    }
}
@end

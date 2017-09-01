
#import "NABaseViewController.h"
#import "FontUtil.h"
@interface NABaseViewController ()

@property (nonatomic, strong) UIView *leftCustomView;

@end

@implementation NABaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self updateViews];
}

/**
 * view初期化
 *
 */
- (void)initViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.translucent = NO;

}

/**
 * view更新
 *
 */
- (void)updateViews
{

}

/**
 * Titleを設定
 *
 */
- (void)setNavMainTitle:(NSString *)mtitle subTitle:(NSString *)sTitle
{
    NSInteger titleWidth = 200;
    if (isPad) {
        titleWidth = 400;
    }
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, titleWidth, self.navigationController.navigationBar.frame.size.height)];
    titleView.backgroundColor = [UIColor clearColor];
    UILabel *mLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, titleWidth, 14)];
    mLabel.backgroundColor = [UIColor clearColor];
    mLabel.textAlignment = NSTextAlignmentCenter;
    mLabel.font = [FontUtil boldSystemFontOfSize:12];
    UILabel *sLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, titleWidth, 20)];
    sLabel.backgroundColor = [UIColor clearColor];
    sLabel.textAlignment = NSTextAlignmentCenter;
    sLabel.font = [FontUtil boldSystemFontOfSize:16];
    sLabel.textColor = [UIColor blackColor];
    
    [titleView addSubview:mLabel];
    [titleView addSubview:sLabel];
    
    if ([NASaveData getIsPublication]) {
        UILabel *publication=[[UILabel alloc]init];
        publication.text=NSLocalizedString(@"publication", nil);
        publication.textColor=[UIColor redColor];
        if (isPad) {
            publication.frame=CGRectMake(0, 15, 100, 20);
             publication.font=[FontUtil boldSystemFontOfSize:14];
        }else{
            mLabel.frame=CGRectMake(0, 0, titleWidth, 10);
            mLabel.font = [FontUtil boldSystemFontOfSize:10];
            sLabel.frame= CGRectMake(0, 11, titleWidth, 20);
            sLabel.font = [FontUtil boldSystemFontOfSize:14];
            publication.frame=CGRectMake(0, 30, titleWidth, 14);
            publication.textAlignment = NSTextAlignmentCenter;
            publication.font=[FontUtil boldSystemFontOfSize:12];
        }
        
        //[titleView addSubview:publication];
    }
    [mLabel setTextColor:[UIColor blueColor]];
    
    mLabel.text = mtitle;
    if ([sTitle isKindOfClass:[NSString class]]) {
        sLabel.text = sTitle;
    }else{
        sLabel.text = @"";
    }
    
    self.navigationItem.titleView = titleView;
    
}

/**
 * toolBar初期化
 *
 */
- (UIToolbar *)toolBar
{
    if (!_toolBar) {
        _toolBar = [[UIToolbar alloc] initWithFrame:CGRectZero];
        _toolBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _toolBar.backgroundColor = [UIColor whiteColor];
    }
    return _toolBar;
}

/**
 * 戻るボタン初期化
 *
 */
- (UIBarButtonItem  *)backBtnItem
{
    if (!_backBtnItem) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:@"19_blue"]
                          forState:UIControlStateNormal];
        [button addTarget:self action:@selector(backBtnItemAction:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, 0, 78/2, 36/2);
        _backBtnItem= [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    return _backBtnItem;
}

/**
 * homeボタン初期化
 *
 */
- (UIBarButtonItem *)homeBtnItem
{
    if (!_homeBtnItem) {
        _homeBtnItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Back", nil) style:UIBarButtonItemStylePlain target:self action:@selector(homeBtnItemAction:)];
    }
    return _homeBtnItem;
}


/**
 * 戻るボタン action
 *
 */
- (void)backBtnItemAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

/**
 * homeボタン action
 *
 */
- (void)homeBtnItemAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end

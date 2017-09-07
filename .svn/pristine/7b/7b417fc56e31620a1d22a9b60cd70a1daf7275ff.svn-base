//
//  NASearchResultTableViewCell.m
//  NAVi
//
//  Created by Liyuanmeng on 2017/8/1.
//  Copyright © 2017年 dxc. All rights reserved.
//
#import "NADefine.h"
#import "FontUtil.h"
#import "NASearchResultTableViewCell.h"

@implementation NASearchResultTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateViews];
}

#pragma mark - utility -
#pragma mark

- (void)cellClickStatus:(BOOL)aClip
{
    self.clipType = aClip;
}

- (void)initViews
{
    [self.contentView addSubview:self.titleLbl];
    [self.contentView addSubview:self.dateLbl];
    [self.contentView addSubview:self.lineView];
    
}
- (void)loadDetailWithisHaveRuby:(BOOL)isRuby{
    [self.detailLbl removeFromSuperview];
    [self.detailWeb removeFromSuperview];
    if (isRuby) {
        [self.contentView addSubview:self.detailWeb];
    }else{
        [self.contentView addSubview:self.detailLbl];
    }
    
}
- (void)updateViews
{
    CGRect titleFrame = CGRectZero;
    CGRect detailFrame = CGRectZero;
    CGRect dateFrame = CGRectZero;
    CGRect lineFrame = CGRectZero;
    CGFloat width = self.frame.size.width;
    //CGFloat height = self.frame.size.height;
    CGFloat originX = 10.0f;
    CGFloat originY = -5.0f;
    CGFloat frameHeight = 0.0f;
    CGFloat frameWidth = width - originX * 2;
    //    NALog(@"%f   %f",width,height);
    switch (self.cellType) {
        case NAiPadLandscape:
            //            NALog(@"NAiPadLandscape");
            frameHeight = 25.0f;
            dateFrame = CGRectMake(originX, originY, frameWidth, frameHeight);
            originY = originY + frameHeight-5;
            frameHeight = 27.0f;
            titleFrame = CGRectMake(originX, originY, frameWidth, frameHeight);
            originY = originY + frameHeight-5;
            frameHeight = 53.0f;
            lineFrame = CGRectMake(originX, originY + 1, frameWidth, 1);
            detailFrame = CGRectMake(originX, originY + 1, frameWidth, frameHeight);
            //originY = originY + frameHeight;
            break;
        case NAiPadPortrait:
            //            NALog(@"NAiPadPortrait");
            frameHeight = 25.0f;
            dateFrame = CGRectMake(originX, originY, frameWidth, frameHeight);
            originY = originY + frameHeight-5 ;
            frameHeight = 27.0f;
            titleFrame = CGRectMake(originX, originY, frameWidth, frameHeight);
            originY = originY + frameHeight-5;
            frameHeight = 53.0f;
            lineFrame = CGRectMake(originX, originY + 1, frameWidth, 1);
            detailFrame = CGRectMake(originX, originY + 1, frameWidth, frameHeight);
            //originY = originY + frameHeight;
            break;
        case NAiPhoneLandscape:
            //            NALog(@"NAiPhoneLandscape");
            frameHeight = 25.0f;
            dateFrame = CGRectMake(originX, originY, frameWidth, frameHeight);
            originY = originY + frameHeight-10;
            frameHeight = 31.0f;
            titleFrame = CGRectMake(originX, originY, frameWidth, frameHeight);
            originY = originY + frameHeight-10;
            frameHeight = 70.0f;
            lineFrame = CGRectMake(originX, originY + 1, frameWidth, 1);
            detailFrame = CGRectMake(originX, originY + 1, frameWidth, frameHeight);
            //originY = originY + frameHeight;
            break;
        case NAiPhonePortrait:
            //            NALog(@"NAiPhonePortrait");
            frameHeight = 25.0f;
            dateFrame = CGRectMake(originX, originY, frameWidth, frameHeight);
            originY = originY + frameHeight-15 ;
            frameHeight = 50.0f;
            titleFrame = CGRectMake(originX, originY, frameWidth, frameHeight);
            originY = originY + frameHeight-10;
            frameHeight = 70.0f;
            lineFrame = CGRectMake(originX, originY + 1, frameWidth, 1);
            detailFrame = CGRectMake(originX, originY + 1, frameWidth, frameHeight);
            //originY = originY + frameHeight;
            
            break;
        default:
            break;
    }
    self.titleLbl.frame = titleFrame;
    self.dateLbl.frame = dateFrame;
    self.lineView.frame = lineFrame;
    self.detailLbl.frame = detailFrame;
    self.detailWeb.frame = detailFrame;
    
}

#pragma mark - layout -
#pragma mark

- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLbl.backgroundColor = [UIColor clearColor];
        _titleLbl.font = [FontUtil systemFontOfSize:18];
        _titleLbl.numberOfLines=1;
        _titleLbl.userInteractionEnabled=NO;
    }
    return _titleLbl;
}

- (UILabel *)detailLbl
{
    if (!_detailLbl) {
        _detailLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        _detailLbl.backgroundColor = [UIColor clearColor];
        _detailLbl.font = [FontUtil systemFontOfSize:18];
    }
    return _detailLbl;
}
- (UIWebView *)detailWeb
{
    if (!_detailWeb) {
        _detailWeb = [[UIWebView alloc] initWithFrame:CGRectZero];
        _detailWeb.backgroundColor = [UIColor clearColor];
        _detailWeb.userInteractionEnabled=NO;
        _detailWeb.delegate=self;
        _detailWeb.opaque=NO;
    }
    return _detailWeb;
}


- (UILabel *)dateLbl
{
    if (!_dateLbl) {
        _dateLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        _dateLbl.backgroundColor = [UIColor clearColor];
        _dateLbl.textColor = [UIColor blueColor];
        _dateLbl.font =[FontUtil systemFontOfSize:14];
        _dateLbl.userInteractionEnabled=NO;
    }
    return _dateLbl;
}
- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = [UIColor colorWithRed:135.0/255.0 green:206.0/255.0 blue:250.0/255.0 alpha:1];
        _lineView.userInteractionEnabled=NO;
    }
    return _lineView;
}
- (void)searchMatchInDirection:(NSString *)mysearchstr{
    NSString *searchString = mysearchstr;
    if (searchString.length>0){
        //[CharUtil setHighlightwithTextview:_detailLbl keyword:searchString];
        if (self.isHaveRuby) {
            [CharUtil setHighlightwithLabel:_titleLbl keyword:searchString];
            NSString *bundleFile = [[NSBundle mainBundle] pathForResource:@"htmlsource" ofType:@"bundle"];
            NSString *filePath = [NSString stringWithFormat:@"%@/listNote.html",bundleFile];
            NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
            
            htmlString = [htmlString stringByReplacingOccurrencesOfString:@"@clamp@" withString:@"3"];
            htmlString = [htmlString stringByReplacingOccurrencesOfString:@"@myContent@" withString:[CharUtil ChangetheDetailtext:_detailtext keyword:searchString]];
            
            
            [_detailWeb loadHTMLString:htmlString baseURL:nil];
        }else{
            [CharUtil setHighlightwithLabel:_titleLbl keyword:searchString];
            [CharUtil setHighlightwithLabel:_detailLbl keyword:searchString];
        }
        
    }
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSString *jsString;
    jsString = [[NSString alloc] initWithFormat:@"document.body.style.fontSize=%d;",14];
    [_detailWeb stringByEvaluatingJavaScriptFromString:jsString];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

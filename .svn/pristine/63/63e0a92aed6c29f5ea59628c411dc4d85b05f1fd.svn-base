//
//  NAMyClipTableViewCell.m
//  NAVi
//
//  Created by y fs on 15/10/29.
//  Copyright © 2015年 dxc. All rights reserved.
//

#import "NAMyClipTableViewCell.h"
#import "NADefine.h"
#import "FontUtil.h"
@interface NAMyClipTableViewCell ()

@end

@implementation NAMyClipTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    return self;
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
- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
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
    [self.contentView addSubview:self.detailLbl];
    [self.contentView addSubview:self.dateLbl];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.clipLbl];
    [self.contentView addSubview:self.clipImg];
}

- (void)updateViews
{
    CGRect titleFrame = CGRectZero;
    CGRect detailFrame = CGRectZero;
    CGRect dateFrame = CGRectZero;
    CGFloat width = self.frame.size.width;
    CGRect lineFrame = CGRectZero;
    CGRect clipFrame = CGRectZero;
    CGRect clipImgFrame = CGRectZero;
    //CGFloat height = self.frame.size.height;
    CGFloat originX = 10.0f;
    CGFloat originY = 5.0f;
    CGFloat frameHeight = 0.0f;
    CGFloat frameWidth = width - originX * 2;
    //    NALog(@"%f   %f",width,height);
    switch (self.cellType) {
        case NAMyiPadLandscape:
            //            NALog(@"NAiPadLandscape");
            frameHeight = 25.0f;
            dateFrame = CGRectMake(originX, originY, frameWidth, frameHeight);
            originY = originY + frameHeight;
            frameHeight = 0.0f;
            lineFrame = CGRectMake(originX, originY+2, frameWidth, 1);
            titleFrame = CGRectMake(originX, originY, frameWidth, frameHeight);
            originY = originY + frameHeight;
            frameHeight = 70.0f;
            detailFrame = CGRectMake(originX, originY+8, frameWidth, frameHeight);
            originY = originY + frameHeight;
            frameHeight = 20.0f;
            clipImgFrame = CGRectMake(originX, originY + 5, 20, 20);
            clipFrame = CGRectMake(originX+25, originY + 5, frameWidth-25, frameHeight);
            break;
        case NAMyiPadPortrait:
            //            NALog(@"NAiPadPortrait");
            frameHeight = 25.0f;
            dateFrame = CGRectMake(originX, originY, frameWidth, frameHeight);
            originY = originY + frameHeight;
            frameHeight = 0.0f;
            lineFrame = CGRectMake(originX, originY+2, frameWidth, 1);
            titleFrame = CGRectMake(originX, originY, frameWidth, frameHeight);
            originY = originY + frameHeight;
            frameHeight = 70.0f;
            detailFrame = CGRectMake(originX, originY+8, frameWidth, frameHeight);
            originY = originY + frameHeight;
            frameHeight = 20.0f;
            clipImgFrame = CGRectMake(originX, originY + 5, 20, 20);
            clipFrame = CGRectMake(originX+25, originY + 5, frameWidth-25, frameHeight);
            break;
        case NAMyiPhoneLandscape:
            //            NALog(@"NAiPhoneLandscape");
            frameHeight = 25.0f;
            dateFrame = CGRectMake(originX, originY, frameWidth, frameHeight);
            originY = originY + frameHeight;
            frameHeight = 0.0f;
            lineFrame = CGRectMake(originX, originY+2, frameWidth, 1);
            titleFrame = CGRectMake(originX, originY, frameWidth, frameHeight);
            originY = originY + frameHeight;
            frameHeight = 70.0f;
            detailFrame = CGRectMake(originX, originY+8, frameWidth, frameHeight);
            originY = originY + frameHeight;
            frameHeight = 20.0f;
            clipImgFrame = CGRectMake(originX, originY + 5, 20, 20);
            clipFrame = CGRectMake(originX+25, originY + 5, frameWidth-25, frameHeight);
            break;
        case NAMyiPhonePortrait:
            //            NALog(@"NAiPhonePortrait");
            frameHeight = 25.0f;
            dateFrame = CGRectMake(originX, originY, frameWidth, frameHeight);
            originY = originY + frameHeight;
            frameHeight = 0.0f;
            lineFrame = CGRectMake(originX, originY+2, frameWidth, 1);
            titleFrame = CGRectMake(originX, originY, frameWidth, frameHeight);
            originY = originY + frameHeight;
            frameHeight = 70.0f;
            detailFrame = CGRectMake(originX, originY+8, frameWidth, frameHeight);
            originY = originY + frameHeight;
            frameHeight = 20.0f;
            clipImgFrame = CGRectMake(originX, originY + 5, 20, 20);
            clipFrame = CGRectMake(originX+25, originY + 5, frameWidth-25, frameHeight);
            break;
        default:
            break;
    }
    self.titleLbl.frame = titleFrame;
    self.dateLbl.frame = dateFrame;
    self.lineView.frame = lineFrame;
    self.detailLbl.frame = detailFrame;
    self.detailWeb.frame = detailFrame;
    self.clipLbl.frame = clipFrame;
    self.clipImg.frame = clipImgFrame;
    
}

#pragma mark - layout -
#pragma mark

- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLbl.backgroundColor = [UIColor clearColor];
        _titleLbl.font = [FontUtil boldSystemFontOfSize:18];
        //[_titleLbl setEditable:NO];
        _titleLbl.userInteractionEnabled=NO;
    }
    return _titleLbl;
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
- (UILabel *)detailLbl
{
    if (!_detailLbl) {
        _detailLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        _detailLbl.backgroundColor = [UIColor clearColor];
        _detailLbl.userInteractionEnabled=NO;
        _detailLbl.opaque=NO;
        
        
    }
    return _detailLbl;
}
- (UILabel *)clipLbl
{
    if (!_clipLbl) {
        _clipLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        _clipLbl.backgroundColor = [UIColor clearColor];
        _clipLbl.userInteractionEnabled=NO;
        _clipLbl.opaque=NO;
        _clipLbl.textColor = [UIColor lightGrayColor];
        _clipLbl.font = [FontUtil boldSystemFontOfSize:15];
        
    }
    return _clipLbl;
}
- (UIImageView *)clipImg{
    if (!_clipImg) {
        _clipImg = [[UIImageView alloc]initWithFrame:CGRectZero];
        _clipImg.image = [UIImage imageNamed:@"11_glay"];
        
    }
    return _clipImg;
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
- (UITextView *)dateLbl
{
    if (!_dateLbl) {
        _dateLbl = [[UITextView alloc] initWithFrame:CGRectZero];
        _dateLbl.backgroundColor = [UIColor clearColor];
        _dateLbl.textColor = [UIColor colorWithRed:135.0/255.0 green:206.0/255.0 blue:250.0/255.0 alpha:1];
        _dateLbl.font = [FontUtil boldSystemFontOfSize:16];
        [_dateLbl setEditable:NO];
        _dateLbl.userInteractionEnabled=NO;
    }
    return _dateLbl;
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
@end

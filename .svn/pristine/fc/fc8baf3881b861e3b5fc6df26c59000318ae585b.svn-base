//
//  NAGifuSWView.m
//  NAVi
//
//  Created by y fs on 15/7/20.
//  Copyright (c) 2015年 dxc. All rights reserved.
//

#import "NAGifuSWView.h"

@implementation NAGifuSWView{
    
    NSString *bundleFile;
    NSString *viewFormatHtml;
    NSString *dataFormatHtml;
}
@synthesize mywebview;
@synthesize viewPattern;

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
        bundleFile = [[NSBundle mainBundle] pathForResource:@"htmlsource" ofType:@"bundle"];
        
        NSString *viewFilePath =[NSString stringWithFormat:@"%@/sokuho_view_format.html",bundleFile];
        viewFormatHtml = [NSString stringWithContentsOfFile:viewFilePath encoding:NSUTF8StringEncoding error:nil];
        
        NSString *dataFilePath = [NSString stringWithFormat:@"%@/sokuho_data_format.html",bundleFile];
        dataFormatHtml = [NSString stringWithContentsOfFile:dataFilePath encoding:NSUTF8StringEncoding error:nil];
    }
    
   
    return self;
}

-(void)initViews{
    mywebview = [[UIWebView alloc] initWithFrame:CGRectZero];
    mywebview.delegate = self;
    mywebview.backgroundColor = [UIColor clearColor];
    mywebview.userInteractionEnabled=YES;
    mywebview.scrollView.scrollEnabled=NO;
    mywebview.opaque=NO;
    [self addSubview:mywebview];
    
    self.displayNotes = [NSMutableArray array];
}

/**
 * html内容を設定
 *
 */
-(void)loadHtml{
    if (self.displayNotes.count == 0) {
        return;
    }
    [mywebview stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML='';"];
    
    NSString *viewHtml = viewFormatHtml.copy;
    
    NSInteger i;
    for (i = 0; i < self.displayNotes.count; i++) {
        NAClipDoc *temdoc=[self.displayNotes objectAtIndex:i];
        NSString *imagePath;
        // 記事画像を設定
        if ([temdoc.miniPhotoPath isKindOfClass:[NSString class]] && temdoc.miniPhotoPath.length > 0) {
            NSArray *urlarray=[temdoc.miniPhotoPath componentsSeparatedByString:@","];
            NSString *urlstr=[urlarray objectAtIndex:0];
            imagePath =urlstr ;
        }else {
            imagePath = nil;
        }
        
        NSString *dataHtml = dataFormatHtml.copy;
        dataHtml = [dataHtml stringByReplacingOccurrencesOfString:@"@kijiIndexNo@" withString:temdoc.indexNo];
        
        NSString *mynewsGroupTitle=temdoc.newsGroupTitle;
        if (self.keyword.length>0){
            mynewsGroupTitle=[CharUtil ChangetheDetailtext:temdoc.newsGroupTitle keyword:self.keyword];
        }
        dataHtml = [dataHtml stringByReplacingOccurrencesOfString:@"@noteTitle@" withString:mynewsGroupTitle];
        
        if (imagePath) {
            dataHtml = [dataHtml stringByReplacingOccurrencesOfString:@"@imgSrc@" withString:imagePath];
            dataHtml = [dataHtml stringByReplacingOccurrencesOfString:@"@display@" withString:@"block"];
        } else {
            dataHtml = [dataHtml stringByReplacingOccurrencesOfString:@"@imgSrc@" withString:@""];
            dataHtml = [dataHtml stringByReplacingOccurrencesOfString:@"@display@" withString:@"none"];
        }
        
        NSString *mynewstext=temdoc.newsText;
        if (self.keyword.length>0){
            mynewstext=[CharUtil ChangetheDetailtext:temdoc.newsText keyword:self.keyword];
        }
        
        dataHtml = [dataHtml stringByReplacingOccurrencesOfString:@"@noteContent@" withString:mynewstext];
        NSArray *mydatearray=[temdoc.lastUpdateDateAndTime componentsSeparatedByString:@" "];
        NSString *datestr=[mydatearray objectAtIndex:0];
        NSString *timestr=[mydatearray objectAtIndex:1];
        
        dataHtml = [dataHtml stringByReplacingOccurrencesOfString:@"@shimenInfo@" withString:[NSString stringWithFormat:@"%@ %@",datestr,[timestr substringWithRange:NSMakeRange(0, 5)]]];
        dataHtml = [dataHtml stringByReplacingOccurrencesOfString:@"@paperInfo@" withString:temdoc.publishingHistoryInfoContentIdPaperInfo];
        
        NSString *dataPattern = [NSString stringWithFormat:@"@viewpt_36_%lu_%lu@",(unsigned long)self.displayNotes.count, (long)(i + 1)];
        viewHtml = [viewHtml stringByReplacingOccurrencesOfString:dataPattern withString:dataHtml];
    }
    
    if (self.isThefirst) {
        AFTER(0.5, ^{
            MAIN(^{
                NSLog(@"mywebview");
                [mywebview loadHTMLString:viewHtml baseURL:[NSURL fileURLWithPath:bundleFile]];
            });
            
        });
        
    }else{
        [mywebview loadHTMLString:viewHtml baseURL:[NSURL fileURLWithPath:bundleFile]];
        
    }
}

/**
 * 記事click事件
 *
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *requestString = [[request URL] absoluteString];
    NSArray *components = [requestString componentsSeparatedByString:@":"];
    if ([components count] > 1 && [(NSString *)[components objectAtIndex:0] isEqualToString:@"naviapp"]) {
        if([(NSString *)[components objectAtIndex:1] isEqualToString:@"noteClick"])
        {
            [self toNoteDetail:[components objectAtIndex:2]];
        }
        return NO;
    }
    
    return YES;
}

/**
 * webviewで、jsを行う
 *
 */
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    if (self.displayNotes.count == 0) {
        return;
    }
    
    [self setShowStyle:_isTateShow];
    
}

/**
 * 縦、横書を設定
 *
 */
- (void)setShowStyle:(BOOL)isTateShow{
    CGFloat width = mywebview.frame.size.width;
    CGFloat height = mywebview.frame.size.height;
    
    NSString *jsString = [NSString stringWithFormat:@"showKijiArea('%lu',%d,'%f','%f','%ld');",(unsigned long)self.displayNotes.count, isTateShow, width, height, (long)self.myFontSize];
    [mywebview stringByEvaluatingJavaScriptFromString:jsString];
    
    self.isTateShow = isTateShow;
}

/**
 * 字体を設定
 *
 */
- (void)changeFontSize
{
    [self setShowStyle:_isTateShow];
}

/**
 * Layout　更新
 *
 */
- (void)updateLayout
{
    mywebview.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

/**
 * 記事詳細画面を表示
 *
 */
- (void)toNoteDetail:(NSString *)noteIndexNo{
    
    NSMutableDictionary *tmpdic=[[NSMutableDictionary alloc]init];
    [tmpdic setObject:noteIndexNo forKey:@"noteIndexNo"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"toNoteDetail" object:nil userInfo:tmpdic];
}

/**
 * 選択した記事を取得
 *
 */
- (NSString *)getSelectedNote {
    NSString *jsString = @"getSelectedKiji()";
    NSString *selectedNote = [mywebview stringByEvaluatingJavaScriptFromString:jsString];
    
    return selectedNote;
}
@end

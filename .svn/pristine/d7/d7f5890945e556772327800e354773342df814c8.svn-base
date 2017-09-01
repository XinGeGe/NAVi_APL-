
#import "NASubNoteView.h"

@interface NASubNoteView () <UIScrollViewDelegate>

@end

@implementation NASubNoteView

/**
 * Frame初期化
 *
 */
- (id)initWithFrame:(CGRect)rect
{
    self.imageFrame = rect;
    self.noteArray = nil;
    self.viewWidth = rect.size.width;
    self.viewHeight = rect.size.height;
    
    self = [super initWithFrame:rect];
    self.alpha = 0.4;
    self.backgroundColor = [UIColor clearColor] ;
    
    return self;
}

/**
 * drawRect
 *
 */
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBFillColor(ctx, 0, 0, 0, 1);
    CGContextFillRect(ctx, self.imageFrame);
    
    for (NSValue *value in self.noteArray) {
        CGRect make = CGRectZero;
        [value getValue:&make];
        
        CGContextClearRect(ctx, make);
    }
    
    CGContextStrokePath(ctx);
}

/**
 * 紙面に選択した記事内容を表示
 *
 */
- (void)drawNote:(NSArray *)array curItemIndex:(NSString *)curPaperIndexNo noteIndexNo:(NSString *)noteIndexNo
{
    if (array && array.count > 0) {
        self.hidden = NO;
    } else {
        self.hidden = YES;
    }

    self.curPaperIndexNo = curPaperIndexNo;
    self.curNoteIndexNo = noteIndexNo;
    self.noteArray = array;
    
    
    [self setNeedsDisplay];
    MAIN(^{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"myPopviewisshowNoty" object:[NSNumber numberWithBool:self.isHidden]];
    });
}

/**
 * 紙面に選択した記事内容をクリア
 *
 */
- (void)clearNote
{
    self.hidden = YES;
    self.curNoteIndexNo = @"";
    self.noteArray = nil;
    
    [self setNeedsDisplay];
    MAIN(^{
         [[NSNotificationCenter defaultCenter]postNotificationName:@"myPopviewisshowNoty" object:[NSNumber numberWithBool:self.isHidden]];
     });
}

@end

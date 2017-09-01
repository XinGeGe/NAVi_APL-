
#import "NAGripToolbar.h"

@implementation NAGripToolbar


- (id)initWithFrame:(CGRect)frame delegate:(id)aDelegate;
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:GETIMAGENAME(@"bg_navigation_footer")]];
        self.delegate = aDelegate;
        [self initViews];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)layoutSubviews{
    [super layoutSubviews];
    [self updateViews];
    
}

#pragma mark - utility -
#pragma mark

- (void)initViews
{
    [self addSubview:self.line];
    if(![NASaveData getIsVisitorModel]){
        [self addSubview:self.collectBtn];
    }
    [self addSubview:self.lblCurNum];
    [self addSubview:self.lblCount];
}

- (void)updateViews
{
    self.line.frame = CGRectMake(0, 0, self.frame.size.width, 1);
    self.collectBtn.center = CGPointMake(self.collectBtn.frame.size.width/2+5, self.frame.size.height/2);
    self.lblCount.center = CGPointMake(self.frame.size.width/2, self.lblCount.frame.size.height/2+3);
    self.lblCurNum.center = CGPointMake(self.frame.size.width/2, self.lblCount.center.y+3+self.lblCurNum.frame.size.height);
}

#pragma mark - layout -
#pragma mark

- (UIButton *)collectBtn
{
    if (!_collectBtn) {
        _collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _collectBtn.frame = CGRectMake(0, 0, 60, 49);
        [_collectBtn setImage:[UIImage imageNamed:GETIMAGENAME(@"btn_tool_clip_off")] forState:UIControlStateNormal];
        [_collectBtn addTarget:self.delegate action:@selector(collectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _collectBtn.backgroundColor = [UIColor clearColor];
    }
    return _collectBtn;
}
- (void)collectBtnAction:(id)sender
{
    NALog(@"collectBtnAction");
}
- (UIBarButtonItem *)spaceButtonItem
{
    UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    return spaceButtonItem;
}

- (UILabel *)line
{
    if (!_line) {
        _line = [[UILabel alloc] initWithFrame:CGRectZero];
        _line.backgroundColor = [UIColor grayColor];
    }
    return _line;
}


- (UILabel *)lblCount
{
    if (!_lblCount) {
        _lblCount = [[UILabel alloc] initWithFrame:CGRectZero];
         _lblCount.textColor=NAPageDetailTitleColor;
    }
    return _lblCount;
}

- (UILabel *)lblCurNum
{
    if (!_lblCurNum) {
        _lblCurNum = [[UILabel alloc] initWithFrame:CGRectZero];
        _lblCurNum.textColor=NAPageDetailTitleColor;
        
    }
    return _lblCurNum;
}

-(void) updateLblCount:(NSString *)value
{
    _lblCount.text = value;
    [_lblCount sizeToFit];
}

-(void) updatelblCurNum:(NSString *)value
{
    _lblCurNum.text = value;
    [_lblCurNum sizeToFit];
}




#pragma mark - button action -
#pragma mark

@end

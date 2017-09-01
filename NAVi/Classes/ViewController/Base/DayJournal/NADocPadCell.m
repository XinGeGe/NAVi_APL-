
#import "NADocPadCell.h"

static const CGFloat cellHeight = 220.0f;

@implementation NADocPadCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self updateViews];
}

#pragma mark -  -
#pragma mark

- (void)initViews
{
    self.selectionStyle = NO;
    [self.contentView addSubview:self.docView1];
    [self.contentView addSubview:self.docView2];
    [self.contentView addSubview:self.docView3];
    [self.contentView addSubview:self.docView4];
}

- (void)updateViews
{
    subWidth = self.frame.size.width / 4 - 20*5/4;
    self.docView1.frame = CGRectMake(20, 10, subWidth, cellHeight);
    self.docView2.frame = CGRectMake(subWidth+self.docView1.frame.origin.x+20, 10, subWidth, cellHeight);
    self.docView3.frame = CGRectMake(subWidth + self.docView2.frame.origin.x+ 20, 10, subWidth, cellHeight);
    self.docView4.frame = CGRectMake(subWidth + self.docView3.frame.origin.x+20, 10, subWidth, cellHeight);
}

#pragma mark - layout -
#pragma mark

- (NASubPagerView *)docView1
{
    if (!_docView1) {
        _docView1 = [[NASubPagerView alloc] initWithFrame:CGRectMake(0, 10, subWidth, cellHeight)];
        _docView1.delegate = self;
    }
    return _docView1;
}

- (NASubPagerView *)docView2
{
    if (!_docView2) {
        _docView2 = [[NASubPagerView alloc] initWithFrame:CGRectMake(subWidth, 10, subWidth, cellHeight)];
        _docView2.delegate = self;
    }
    return _docView2;
}

- (NASubPagerView *)docView3
{
    if (!_docView3) {
        _docView3 = [[NASubPagerView alloc] initWithFrame:CGRectMake(subWidth *2, 10, subWidth, cellHeight)];
        _docView3.delegate = self;
    }
    return _docView3;
}

- (NASubPagerView *)docView4
{
    if (!_docView4) {
        _docView4 = [[NASubPagerView alloc] initWithFrame:CGRectMake(subWidth *3, 10, subWidth, cellHeight)];
        _docView4.delegate = self;
    }
    return _docView4;
}


#pragma mark - NASubPagerViewDelegate -
#pragma mark

- (void)subPagerViewselected:(id)object
{
    if (self.selectedObjectCompletionBlock) {
        self.selectedObjectCompletionBlock (object);
    }
}

@end

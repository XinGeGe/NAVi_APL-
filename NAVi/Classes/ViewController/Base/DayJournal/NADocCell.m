
#import "NADocCell.h"

static const CGFloat cellHeight = 170.0f;

@implementation NADocCell

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
    [self.contentView addSubview:self.leftDocView];
    [self.contentView addSubview:self.rightDocView];
}

- (void)updateViews
{
    self.leftDocView.frame = CGRectMake(20, 10, self.bounds.size.width / 2 -40, cellHeight);
    self.rightDocView.frame = CGRectMake(self.bounds.size.width / 2 + 10, 10, self.bounds.size.width / 2 -40, cellHeight);
}

#pragma mark - layout -
#pragma mark

- (NASubPagerView *)leftDocView
{
    if (!_leftDocView) {
        _leftDocView = [[NASubPagerView alloc] initWithFrame:CGRectMake(20, 10, self.bounds.size.width / 2 -40, cellHeight)];
        _leftDocView.delegate = self;
    }
    return _leftDocView;
}

- (NASubPagerView *)rightDocView
{
    if (!_rightDocView) {
        _rightDocView = [[NASubPagerView alloc] initWithFrame:CGRectMake(self.bounds.size.width / 2 + 10, 10, self.bounds.size.width / 2 -40, cellHeight)];
        _rightDocView.delegate = self;
    }
    return _rightDocView;
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

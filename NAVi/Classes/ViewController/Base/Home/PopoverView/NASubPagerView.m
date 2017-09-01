
#import "NASubPagerView.h"
#import "FontUtil.h"
@interface NASubPagerView ()

@property (nonatomic, strong) UIButton *imageButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *mainTitleLabel;

@end

@implementation NASubPagerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
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

- (void)initViews
{
    [self addSubview:self.imageView];
    [self addSubview:self.imageButton];
    [self addSubview:self.subMainTitleLabel];
    [self addSubview:self.titleLabel];
    [self addSubview:self.imageIdentfier];
    
}

- (void)updateViews
{
    self.imageButton.frame = self.bounds;
    
    [_imageButton addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(_imageButton);
        make.height.mas_equalTo(129);
    }];
    [_imageButton addSubview:_imageIdentfier];
    [_imageIdentfier mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(_imageButton);
        make.height.mas_equalTo(129);
    }];
    
    [_imageButton addSubview:_mainTitleLabel];
    [_mainTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageView.mas_bottom).offset(1);
        make.left.right.equalTo(_imageButton);
        make.height.mas_equalTo(20);
    }];
    
    [_mainTitleLabel addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(_mainTitleLabel);
        make.height.mas_equalTo(16);
    }];
    
    
    if (self.mainTitleLabel.text != nil) {
        self.backgroundColor = [UIColor darkGrayColor];
    }
}

- (void)imageViewWthInfo:(NADoc *)doc
{
    UIImage *image =doc.thumbimage;
    if (image == nil) {
        NSString *path = [[NAFileManager sharedInstance] searchPathWithFileName:doc withImageName:NAPageMiniPhoto];
        image = [UIImage imageWithContentsOfFile:path];
        [self updateViews];
    }
    
    if (image) {
        [self.imageView setImage:image];
    }else{
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:doc.miniPagePath]];
        [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
        __block NASubPagerView *_self = self;
        [self.imageView setImageWithURLRequest:request
                              placeholderImage:[UIImage imageNamed:@"waiting"]
                                       success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                           dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                               [[NAFileManager sharedInstance] writeMinImageToSearchManager:UIImageJPEGRepresentation(image, 1.0) info:doc];
                                           });
                                           [_self.imageView setImage:image];
                                           //doc.thumbimage = image;
                                       } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                           
                                       }];
    }
}

- (void)updateTitleWithName:(NSString *)name
{
    self.titleLabel.text = name;
}

- (void)updateMainTitleWithName:(NSString *)name
{
    self.mainTitleLabel.text = name;
    [self updateViews];
}

-(void)setFreeIdentfierView:(BOOL)isFree{
    
}
-(void)setIsShowImageIdentfier:(BOOL)isShow{
    self.imageIdentfier.hidden=isShow;
}
#pragma mark - layout -
#pragma mark

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

- (UIImageView *)imageIdentfier
{
    if (!_imageIdentfier) {
        _imageIdentfier = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageIdentfier.contentMode = UIViewContentModeScaleAspectFit;
        _imageIdentfier.hidden=YES;
    }
    return _imageIdentfier;
}

- (UIButton *)imageButton
{
    if (!_imageButton) {
        _imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_imageButton addTarget:self action:@selector(imageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_imageButton addTarget:self action:@selector(button1BackGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
    }
    return _imageButton;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [FontUtil boldSystemFontOfSize:14];
    }
    return _titleLabel;
}

- (UILabel *)subMainTitleLabel
{
    if (!_mainTitleLabel) {
        _mainTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _mainTitleLabel.textAlignment = NSTextAlignmentCenter;
        _mainTitleLabel.adjustsFontSizeToFitWidth = YES;
        _mainTitleLabel.textColor = [UIColor whiteColor];
        _mainTitleLabel.font = [FontUtil boldSystemFontOfSize:12];
        
    }
    return _mainTitleLabel;
}

#pragma mark - button action -
#pragma mark

- (void)imageButtonAction:(UIButton*)sender
{
    sender.backgroundColor =[UIColor clearColor];
    [self.delegate subPagerViewselected:self];
}
- (void)button1BackGroundHighlighted:(UIButton *)sender
{
    sender.backgroundColor = [UIColor colorWithRed:189/255.0 green:189/255.0 blue:189/255.0 alpha:0.48];
}
@end


#import "NACustomButtonItem.h"

@interface NACustomButtonItem ()

@end

@implementation NACustomButtonItem

- (id)initWithTitle:(NSString *)title image:(UIImage *)image
{
    self = [super initWithFrame:CGRectMake(0, 0, 50, 44)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.imageView];
        //[self addSubview:self.titleLabel];
//        self.titleLabel.text = title;
//        self.titleLabel.highlightedTextColor = [UIColor blueColor];
        self.imageView.image = image;
    }
    return self;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    }
    return _imageView;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.imageView.highlighted = YES;
//    self.titleLabel.highlighted = YES;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.imageView.highlighted = NO;
//    self.titleLabel.highlighted = NO;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.imageView.highlighted = NO;
//    self.titleLabel.highlighted = NO;
    [self.delegate customItemSelected:self];
}

@end

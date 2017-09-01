//
//  NARadioButtonTableViewCell.m
//  NAVi
//
//  Created by y fs on 15/8/11.
//  Copyright (c) 2015年 dxc. All rights reserved.
//

#import "NARadioButtonTableViewCell.h"

@implementation NARadioButtonTableViewCell
@synthesize oneButton;
@synthesize otherButton;
@synthesize isSelectone;
@synthesize isSelecttwo;
@synthesize mytitlelab;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [oneButton setTitle:NSLocalizedString(@"pagebarnospace", nil)  forState:UIControlStateNormal];
        [oneButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [oneButton layoutIfNeeded];
//        oneButton.tag=0;
//        [oneButton addTarget:self action:@selector(changeQy:) forControlEvents:UIControlEventTouchUpInside];
        [oneButton setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
//        [oneButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 50, 40, 40)];
//        [oneButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0,40,40)];

        [self addSubview:oneButton];
        
        otherButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [otherButton setTitle:NSLocalizedString(@"fastnewnospace", nil)   forState:UIControlStateNormal];
        [otherButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [otherButton layoutIfNeeded];
//        otherButton.tag=1;
//        [otherButton addTarget:self action:@selector(changeQy:) forControlEvents:UIControlEventTouchUpInside];
        [otherButton setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
//        [otherButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 50, 40, 40)];
//        [otherButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0,40,40)];
        [self addSubview:otherButton];
        
        mytitlelab=[[UILabel alloc]init];
        mytitlelab.text=NSLocalizedString(@"firstdownload", nil);
        mytitlelab.textColor=[UIColor blueColor];
        [self addSubview:mytitlelab];
    }
    return self;
}
-(IBAction)changeQy:(UIButton *)sender{
   
        if (isSelectone) {
            isSelectone=NO;
            [oneButton setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
            [otherButton setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
            [NASaveData saveFirstDownload:[NSNumber numberWithInteger:0]];
        }else{
            isSelectone=YES;
            [oneButton setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
            [otherButton setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
            [NASaveData saveFirstDownload:[NSNumber numberWithInteger:1]];
        }
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateViews];
}
-(void)updateViews{
    CGFloat width = self.frame.size.width;
   
    mytitlelab.frame=CGRectMake(10, 2, width-140, 40);
    oneButton.frame=CGRectMake(width-160, 2, 80, 40);
    otherButton.frame=CGRectMake(width-90, 2, 80, 40);
    
}


@end

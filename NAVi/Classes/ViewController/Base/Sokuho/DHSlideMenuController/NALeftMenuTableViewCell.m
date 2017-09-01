//
//  NALeftMenuTableViewCell.m
//  NAVi
//
//  Created by y fs on 15/7/14.
//  Copyright (c) 2015年 dxc. All rights reserved.
//

#import "NALeftMenuTableViewCell.h"
#import "FontUtil.h"
@implementation NALeftMenuTableViewCell

@synthesize titlelab;
@synthesize menuimage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
        
    }
    return self;
}
-(void)initViews{
    
    titlelab=[[UILabel alloc]init];
    titlelab.font=[FontUtil boldSystemFontOfSize:17];
    titlelab.numberOfLines=0;
    [self addSubview:titlelab];
    
    menuimage=[[UIImageView alloc]init];
    [self addSubview:menuimage];
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateViews];
}
- (void)updateViews
{
    menuimage.frame=CGRectMake(10, 10, 120, 80);
    titlelab.frame=CGRectMake(135, 10, 110, 80);
}

@end

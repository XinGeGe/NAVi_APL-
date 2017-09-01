//
//  NASetSwithTableViewCell.m
//  NAVi
//
//  Created by y fs on 15/5/11.
//  Copyright (c) 2015年 dxc. All rights reserved.
//

#import "NASetSwithTableViewCell.h"

@implementation NASetSwithTableViewCell
@synthesize mytitlelab;
@synthesize myswitch;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        mytitlelab=[[UILabel alloc]init];
        [self addSubview:mytitlelab];
        
        myswitch=[[UISwitch alloc]init];
        [self addSubview:myswitch];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateViews];
}
-(void)updateViews{
    CGFloat width = self.frame.size.width;
    //CGFloat height = self.frame.size.height;
    mytitlelab.frame=CGRectMake(10, 2, width-10, 40);
    myswitch.frame=CGRectMake(width-70, 7, 60, 40);
}
@end

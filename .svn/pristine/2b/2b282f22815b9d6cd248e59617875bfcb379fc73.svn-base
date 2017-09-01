//
//  NALogoViewController.m
//  NAVi
//
//  Created by y fs on 15/12/3.
//  Copyright © 2015年 dxc. All rights reserved.
//

#import "NALogoViewController.h"

@implementation NALogoViewController{
    UIImageView *mylogoview;
}
- (void)initViews
{
    [super initViews];
    mylogoview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [Util screenSize].width, [Util screenSize].height)];
    [self.view  addSubview:mylogoview];
    
       
}

- (void)updateViews
{
    mylogoview.frame=self.view.frame;
    if ([Util screenSize].width>[Util screenSize].height) {
        mylogoview.image=[UIImage imageNamed:@"nextep_logo_blue_1024_768.png"];
    }else{
        mylogoview.image=[UIImage imageNamed:@"nextep_logo_blue.png"];
    }
 
}
@end

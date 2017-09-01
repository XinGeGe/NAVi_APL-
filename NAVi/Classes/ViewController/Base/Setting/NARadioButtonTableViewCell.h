//
//  NARadioButtonTableViewCell.h
//  NAVi
//
//  Created by y fs on 15/8/11.
//  Copyright (c) 2015年 dxc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NASaveData.h"

@interface NARadioButtonTableViewCell : UITableViewCell

@property (nonatomic,strong)UIButton *oneButton;
@property (nonatomic,strong)UIButton *otherButton;
@property (nonatomic,readwrite)BOOL isSelectone;
@property (nonatomic,readwrite)BOOL isSelecttwo;
@property (nonatomic,strong)UILabel *mytitlelab;
@end

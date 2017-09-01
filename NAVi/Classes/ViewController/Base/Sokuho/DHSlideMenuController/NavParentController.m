

//
//  NavParentController.m
//  SlideTest
//
//  Created by 胡大函 on 14/10/11.
//  Copyright (c) 2014年 HuDahan_payMoreGainMore. All rights reserved.
//

#import "NavParentController.h"
#import "DHSlideMenuController.h"
@interface NavParentController ()

@end

@implementation NavParentController

- (void)loadView {
    [super loadView];
    self.navigationBar.barTintColor = BaseNavBarColor;
    self.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationBar.translucent = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

@end

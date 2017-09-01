//
//  NAExpansionView.m
//  NAVi
//
//  Created by y fs on 15/5/11.
//  Copyright (c) 2015年 dxc. All rights reserved.
//

#import "NACheckListView.h"
#import "NASaveData.h"

@implementation NACheckListView{
    AGWindowView *windowView;
}

@synthesize mytableview;
@synthesize checkarray;
@synthesize seclectindex;
@synthesize mybackview;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    
    return self;
}
- (void)dismissClick:(UITapGestureRecognizer *)recognizer
{
    [UIView animateWithDuration:0.3 animations:^{
        [windowView removeFromSuperview];
        [windowView removeObserver:self forKeyPath:@"frame"];
    }];
}
-(void)initViews{
    mybackview=[[UIView alloc]init];
    mybackview.alpha=0.4;
    mybackview.backgroundColor=[UIColor blackColor];
    [mybackview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissClick:)]];
    [self addSubview:mybackview];
    
    mytableview=[[UITableView alloc]init];
    mytableview.delegate=self;
    mytableview.dataSource=self;
    [self addSubview:mytableview];
//    _brScrollBarController = [BRScrollBarController setupScrollBarWithScrollView:self.mytableview
//                                                                      inPosition:BRScrollBarPostionRight
//                                                                        delegate:self];
//    _brScrollBarController.scrollBar.hideScrollBar = NO;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    mybackview.frame=self.bounds;
    CGFloat screenWidth = self.frame.size.width;
    CGFloat screenHeight = self.frame.size.height;
    mytableview.frame=CGRectMake(20, (screenHeight-132)/2, screenWidth-60, 132);
    _brScrollBarController.scrollBar.frame=CGRectMake(screenWidth-48, (screenHeight-132)/2, 8, 132);
    
}
-(void)show{
    [UIView animateWithDuration:0.3 animations:^{
        windowView = [[AGWindowView alloc] initAndAddToKeyWindow];
        self.frame =windowView.bounds;
        windowView.supportedInterfaceOrientations = AGInterfaceOrientationMaskAll;
        [windowView addSubview:self];
        [windowView addObserver:self forKeyPath:@"frame" options:0 context:nil];
        [mytableview reloadData];
        [mytableview flashScrollIndicators];
    }];
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(UIView *)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"frame"]) {
        self.frame = object.bounds;
    }
}
#pragma mark - BRScrollBarcontroller

/*!
 * return title for cell at this point
 * to show in the BrScrollBarLabel
 */
- (NSString *)brScrollBarController:(BRScrollBarController *)controller
             textForCurrentPosition:(CGPoint)position {
    NSIndexPath *index = [self.mytableview indexPathForRowAtPoint:position];
    UITableViewCell *cell = [self.mytableview cellForRowAtIndexPath:index];
    
    return cell.textLabel.text;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return checkarray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"myCell2";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString *title=[checkarray objectAtIndex:indexPath.row];
    if (indexPath.row==seclectindex) {
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    
    cell.textLabel.text = title;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *name=[checkarray objectAtIndex:indexPath.row];
    seclectindex=indexPath.row;
    [self.delegate selcetClickName:name MyView:self];
    [self.mytableview reloadData];
//    [mytableview flashScrollIndicators];
    [self performSelector:@selector(dissMissmyview) withObject:self afterDelay:0.3];
    
}
-(void)dissMissmyview{
    [UIView animateWithDuration:0.3 animations:^{
        [windowView removeFromSuperview];
        [windowView removeObserver:self forKeyPath:@"frame"];
    }];
    
}
@end

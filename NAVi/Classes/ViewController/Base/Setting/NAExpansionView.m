//
//  NAExpansionView.m
//  NAVi
//
//  Created by y fs on 15/5/11.
//  Copyright (c) 2015年 dxc. All rights reserved.
//

#import "NAExpansionView.h"
#import "NASaveData.h"

@implementation NAExpansionView{
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
    [windowView removeFromSuperview];
    [windowView removeObserver:self forKeyPath:@"frame"];
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
    
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    mybackview.frame=self.bounds;
    CGFloat screenWidth = self.frame.size.width;
    CGFloat screenHeight = self.frame.size.height;
    mytableview.frame=CGRectMake(20, (screenHeight-132)/2, screenWidth-40, 132);
}
-(void)show{
        windowView = [[AGWindowView alloc] initAndAddToKeyWindow];
        self.frame =windowView.bounds;
        windowView.supportedInterfaceOrientations = AGInterfaceOrientationMaskAll;
        [windowView addSubview:self];
        [windowView addObserver:self forKeyPath:@"frame" options:0 context:nil];
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(UIView *)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"frame"]) {
        self.frame = object.bounds;
    }
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
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%ld", (long)indexPath.row],@"myselectnum",name,@"myname", self.showtype,@"showtype",nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Expansion_rate" object:nil userInfo:dic];
    seclectindex=indexPath.row;
    
    [self.mytableview reloadData];
    [self performSelector:@selector(dissMissmyview) withObject:self afterDelay:0.3];
    
}
-(void)dissMissmyview{
    [windowView removeFromSuperview];
    [windowView removeObserver:self forKeyPath:@"frame"];
}
@end

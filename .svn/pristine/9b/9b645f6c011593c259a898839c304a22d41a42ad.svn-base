
#import "NAMenuView.h"

@interface NAMenuView ()

@property (nonatomic, strong) NSArray *dataSource;;

@end

@implementation NAMenuView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = [NSArray arrayWithObjects:NSLocalizedString(@"New News", nil), NSLocalizedString(@"Search", nil) ,NSLocalizedString(@"Digest", nil), NSLocalizedString(@"Logout", nil), nil];
        [self addSubview:self.tView];
    }
    return self;
}


#pragma mark - layout -
#pragma mark

- (UITableView *)tView
{
    if (!_tView) {
        _tView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tView.delegate = self;
        _tView.dataSource = self;
        _tView.scrollEnabled = NO;
    }
    return _tView;
}


#pragma mark - tableView delegate -
#pragma mark

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.delegate menuSelectIndex:indexPath.row];

}


@end

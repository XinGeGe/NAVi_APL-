
#import "NADateView.h"

@interface NADateView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation NADateView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateViews];
}


#pragma mark - Utility -
#pragma mark

- (void)initViews
{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.tView];
}

- (void)updateViews
{
    self.tView.frame = self.bounds;
}

- (void)reloadDateView:(NSArray *)array
{
    self.dataSource = array;
    [self.tView reloadData];
}

#pragma mark - layout -
#pragma mark

- (UITableView *)tView
{
    if (!_tView) {
        _tView = [[UITableView alloc] initWithFrame:CGRectZero
                                              style:UITableViewStyleGrouped];
        _tView.delegate = self;
        _tView.dataSource = self;
    }
    return _tView;
}

#pragma mark - tableView delegate -
#pragma mark

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = self.dataSource[section];
    return array.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray *array = self.dataSource[section];
    NADoc *doc =  array[0];
    return [Util getTheFormatString:doc.publishDate];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSArray *array = self.dataSource[indexPath.section];
    NADoc *doc =  array[indexPath.row];
    cell.textLabel.text = doc.editionInfoName;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end


#import "NAArticleView.h"

#define SEGMENT_HEIGHT 30

@interface NAArticleView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tView;
@property (nonatomic, strong) UISegmentedControl *segment;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation NAArticleView

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
    [self addSubview:self.segment];
    [self.tView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
}

- (void)updateViews
{
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    self.segment.frame = CGRectMake(0, 0, width, SEGMENT_HEIGHT);
    self.tView.frame = CGRectMake(0, SEGMENT_HEIGHT, width, height - SEGMENT_HEIGHT);
}

- (void)reloadArticleData:(NSArray *)array
{
    self.dataSource = array;
    [self.tView reloadData];
}

#pragma mark -layout  -
#pragma mark

- (UISegmentedControl *)segment
{
    if (!_segment) {
        _segment = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"朝1", nil]];
        [_segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
        _segment.selectedSegmentIndex = 0;
    }
    return _segment;
}

- (UITableView *)tView
{
    if (!_tView) {
        _tView = [[UITableView alloc] initWithFrame:CGRectZero
                                              style:UITableViewStylePlain];
        _tView.delegate = self;
        _tView.dataSource = self;
    }
    return _tView;
}


#pragma mark - button action -
#pragma mark

- (void)segmentAction:(id)sender
{
    
}


#pragma mark - tableView delegate -
#pragma mark

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NADoc *doc = self.dataSource[indexPath.row];
    cell.textLabel.text = doc.headlineText;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}



@end


#import "NAHomeToobar.h"

@interface NAHomeToobar ()


@end

@implementation NAHomeToobar


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //self.backgroundColor=[UIColor clearColor];
        [self initViews];
        [self setBackgroundImage:[UIImage imageNamed:GETIMAGENAME(@"bg_hometoolbar_bg")] forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self updateViews];
}

#pragma mark - utility -
#pragma mark

- (void)initViews
{
    //    [self setItems:[NSArray arrayWithObjects:self.newsButtonItem, [self spaceButtonItem], self.dayJournalButtonItem, [self spaceButtonItem], self.paperButtonItem, [self spaceButtonItem],self.settingButtonItem, nil]];
    
    [self addSubview:self.line];
    
}

- (void)updateViews
{
    self.line.frame = CGRectMake(0, 0, self.frame.size.width, 1);
    [self sizeToFit];
}


#pragma mark - layout -
#pragma mark

- (UIBarButtonItem *)dayJournalButtonItem
{
    if (!_dayJournalButtonItem) {
        _dayJournalButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.dayJournalItem];
    }
    return _dayJournalButtonItem;
}

- (UIBarButtonItem *)newsButtonItem
{
    if (!_newsButtonItem) {
        _newsButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.newsItem];
    }
    return _newsButtonItem;
}

- (UIBarButtonItem *)paperButtonItem
{
    if (!_paperButtonItem) {
        _paperButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.paperItem];
    }
    return _paperButtonItem;
}

- (UIBarButtonItem *)settingButtonItem
{
    if (!_settingButtonItem) {
        _settingButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.settingItem];
    }
    return _settingButtonItem;
}

- (UIBarButtonItem *)clipButtonItem
{
    if (!_clipButtonItem) {
        _clipButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.clipItem];
    }
    return _clipButtonItem;
}

- (UIBarButtonItem *)noteButtonItem
{
    if (!_noteButtonItem) {
        _noteButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.noteItem];
    }
    return _noteButtonItem;
}

- (UIBarButtonItem *)publicationButtonItem
{
    if (!_publicationButtonItem) {
        _publicationButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.publicationItem];
    }
    return _publicationButtonItem;
}
- (UIBarButtonItem *)sokuhoButtonItem
{
    if (!_sokuhoButtonItem) {
        _sokuhoButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.sokuhoItem];
    }
    return _sokuhoButtonItem;
}

- (UIBarButtonItem *)searchLastNewsButtonItem
{
    if (!_searchLastNewsButtonItem) {
        _searchLastNewsButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.searchLastNewsItem];
    }
    return _searchLastNewsButtonItem;
}

- (UIBarButtonItem *)spaceButtonItem
{
    UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    return spaceButtonItem;
}

- (NACustomButtonItem *)newsItem
{
    if (!_newsItem) {
        //        _newsItem = [[NACustomButtonItem alloc] initWithTitle:NSLocalizedString(@"News List", nil) image:[UIImage imageNamed:@"common_navibar_ico_search"]];
        
        _newsItem = [[NACustomButtonItem alloc] initWithTitle:NSLocalizedString(@"News List", nil) image:[UIImage imageNamed:GETIMAGENAME(@"menu_kanlist_off")]];
        _newsItem.tag = NAHomeToobarModeNewsList;
        _newsItem.delegate = self;
    }
    return _newsItem;
}

- (NACustomButtonItem *)publicationItem
{
    if (!_publicationItem) {
        //        _publicationItem = [[NACustomButtonItem alloc] initWithTitle:NSLocalizedString(@"Publication List", nil) image:[UIImage imageNamed:@"common_navibar_ico_search"]];
        
        _publicationItem = [[NACustomButtonItem alloc] initWithTitle:NSLocalizedString(@"Publication List", nil) image:[UIImage imageNamed:GETIMAGENAME(@"menu_medialist_off")]];
        _publicationItem.delegate = self;
        _publicationItem.tag = NAHomeToobarModePublication;
    }
    return _publicationItem;
}

- (NACustomButtonItem *)dayJournalItem
{
    if (!_dayJournalItem) {
        //        _dayJournalItem = [[NACustomButtonItem alloc] initWithTitle:NSLocalizedString(@"Day Journal", nil) image:[UIImage imageNamed:@"common_navibar_ico_search"]];
        
        _dayJournalItem = [[NACustomButtonItem alloc] initWithTitle:NSLocalizedString(@"Day Journal", nil) image:[UIImage imageNamed:GETIMAGENAME(@"menu_datelist_off")]];
        _dayJournalItem.tag = NAHomeToobarModeDayJournal;
        _dayJournalItem.delegate = self;
    }
    return _dayJournalItem;
}

- (NACustomButtonItem *)paperItem
{
    if (!_paperItem) {
        //        _paperItem = [[NACustomButtonItem alloc] initWithTitle:NSLocalizedString(@"Paper List", nil) image:[UIImage imageNamed:@"common_navibar_ico_search"]];
        _paperItem = [[NACustomButtonItem alloc] initWithTitle:NSLocalizedString(@"Paper List", nil) image:[UIImage imageNamed:GETIMAGENAME(@"menu_pagelist_off")]];
        
        _paperItem.tag = NAHomeToobarModePaper;
        _paperItem.delegate = self;
    }
    return _paperItem;
}

- (NACustomButtonItem *)noteItem
{
    if (!_noteItem) {
        //        _noteItem = [[NACustomButtonItem alloc] initWithTitle:NSLocalizedString(@"Article List", nil) image:[UIImage imageNamed:@"common_navibar_ico_search"]];
        
        _noteItem = [[NACustomButtonItem alloc] initWithTitle:NSLocalizedString(@"Article List", nil) image:[UIImage imageNamed:GETIMAGENAME(@"menu_kijilist_off")]];
        
        _noteItem.delegate = self;
        _noteItem.tag = NAHomeToobarModeArticle;
    }
    return _noteItem;
}

- (NACustomButtonItem *)clipItem
{
    if (!_clipItem) {
        //        _clipItem = [[NACustomButtonItem alloc] initWithTitle:NSLocalizedString(@"Grip", nil) image:[UIImage imageNamed:@"common_navibar_ico_search"]];
        _clipItem = [[NACustomButtonItem alloc] initWithTitle:NSLocalizedString(@"Grip", nil) image:[UIImage imageNamed:GETIMAGENAME(@"menu_cliplist_off")]];
        _clipItem.tag = NAHomeToobarModeGrip;
        _clipItem.delegate = self;
    }
    return _clipItem;
}




- (NACustomButtonItem *)settingItem
{
    if (!_settingItem) {
        //        _settingItem = [[NACustomButtonItem alloc] initWithTitle:NSLocalizedString(@"Setting", nil) image:[UIImage imageNamed:@"common_navibar_ico_search"]];
        
        _settingItem = [[NACustomButtonItem alloc] initWithTitle:NSLocalizedString(@"Setting", nil) image:[UIImage imageNamed:GETIMAGENAME(@"menu_setting_off")]];
        
        _settingItem.delegate = self;
        _settingItem.tag = NAHomeToobarModeSetting;
    }
    return _settingItem;
}

- (NACustomButtonItem *)sokuhoItem
{
    if (!_sokuhoItem) {
        //        _settingItem = [[NACustomButtonItem alloc] initWithTitle:NSLocalizedString(@"Setting", nil) image:[UIImage imageNamed:@"common_navibar_ico_search"]];
        
        _sokuhoItem = [[NACustomButtonItem alloc] initWithTitle:NSLocalizedString(@"", nil) image:[UIImage imageNamed:GETIMAGENAME(@"menu_sokuho_off")]];
        
        _sokuhoItem.delegate = self;
        _sokuhoItem.tag = NAHomeToobarModeSokuho;
    }
    return _sokuhoItem;
}
- (NACustomButtonItem *)searchLastNewsItem
{
    if (!_searchLastNewsItem) {
        //        _newsItem = [[NACustomButtonItem alloc] initWithTitle:NSLocalizedString(@"News List", nil) image:[UIImage imageNamed:@"common_navibar_ico_search"]];
        
        _searchLastNewsItem = [[NACustomButtonItem alloc] initWithTitle:NSLocalizedString(@"News List", nil) image:[UIImage imageNamed:GETIMAGENAME(@"menu_update_off")]];
        _searchLastNewsItem.tag = NAHomeToobarModeSearchLastNews;
        _searchLastNewsItem.delegate = self;
    }
    return _searchLastNewsItem;
}


- (UILabel *)line
{
    if (!_line) {
        _line = [[UILabel alloc] initWithFrame:CGRectZero];
        _line.backgroundColor = [UIColor grayColor];
    }
    return _line;
}


#pragma mark - NACustomButtonItemDelegate -
#pragma mark

- (void)customItemSelected:(id)sender
{
    NACustomButtonItem *item = (NACustomButtonItem *)sender;
    [self.homeBarDelegate toolbarActionWithType:(NAHomeToobarMode)item.tag];
}

- (void)noteItemEnable:(BOOL)enable
{
    //    self.noteButtonItem.enabled = enable;
    //    self.noteItem.hidden = !enable;
}

@end

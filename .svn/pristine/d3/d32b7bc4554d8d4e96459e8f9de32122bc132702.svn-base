
#import "NABaseViewController.h"
#import "RMDateSelectionViewController.h"
#import "NASDoc.h"
#import "NACheckListView.h"
typedef void(^searchResult)(NSArray *result);

typedef void(^searchSokuhoBlack)(NSArray *result,NSString *keyword,NSString *fromdate,NSString *todate);

@interface NASearchViewController : NABaseViewController<NACheckDelegate>{
    BOOL isEndDateFirstEntered;
}

@property (nonatomic, strong) searchResult resultCompletion;
@property (nonatomic, strong) searchSokuhoBlack sokuhoCompletion;
@property (nonatomic, strong) NADoc *currDoc;
@property (nonatomic, strong) NASDoc *currsDoc;
@property (nonatomic, assign) BOOL isNote;
@property (nonatomic, strong) NSString *isfromWhere;
@property (nonatomic, strong) NADoc *tmpDoc;//never change
@property (nonatomic, strong) UISegmentedControl *segment;
@property (nonatomic, strong) UISegmentedControl *searchOrderNoSegment;
@end

/*!
 @header NANotePageView.h
 @abstract 記事詳細画面の関連紙面view
 @author eland
 @version 1.00 2015/05/20 Creation
 */

#import <UIKit/UIKit.h>
#import "DataModels.h"
#import "UIImageView+WebCache.h"
#import "NASaveData.h"

@interface NANotePageView : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *headLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSString *isfromWhere;
@property (nonatomic, strong) NAClipDoc *noteDoc;
@property (nonatomic, strong) NADoc *paperDoc;

- (void)setViewValue:(NAClipDoc *)doc;

@end

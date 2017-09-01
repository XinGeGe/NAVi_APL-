
#import "NABaseViewController.h"

typedef void(^selectedDoc)(NADoc *obj);

@interface NANewsViewController : NABaseViewController

@property (nonatomic, strong) selectedDoc selectedDocCompletionBlock;
@property (nonatomic, strong) NADoc *currDoc;
@end

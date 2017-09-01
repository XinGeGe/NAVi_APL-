
#import <UIKit/UIKit.h>

#define YMErrorCodeE103 103

@interface UIAlertView (UIAlertViewAdditions)

+ (void)showSimpleAlertWithTitle:(NSString *)aTitle message:(NSString *)aMessage;
+ (void)showSimpleAlertWithDelegate:(id)aDelegate
                              title:(NSString *)aTitle
                            message:(NSString *)aMessage
                                tag:(NSInteger)aTag;
+ (void)showConfirmAlertWithDelegate:(id)aDelegate
                               title:(NSString *)aTitle
                             message:(NSString *)aMessage
                                 tag:(NSInteger)aTag;
+ (void)showNormalAlert:(NSString *)message;

@end

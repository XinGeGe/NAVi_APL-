
#import "UIAlertView+Additions.h"


@implementation UIAlertView (UIAlertViewAdditions)
+ (void)showSimpleAlertWithTitle:(NSString *)aTitle message:(NSString *)aMessage
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:aTitle
                                                        message:aMessage
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                              otherButtonTitles:nil];
        
        [alert show];
    });
    
    
}

+ (void)showSimpleAlertWithDelegate:(id)aDelegate
                              title:(NSString *)aTitle
                            message:(NSString *)aMessage
                                tag:(NSInteger)aTag
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:aTitle
                                                        message:aMessage
                                                       delegate:aDelegate
                                              cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                              otherButtonTitles:nil];
        alert.tag = aTag;
        
        [alert show];
    });
}

+ (void)showConfirmAlertWithDelegate:(id)aDelegate
                              title:(NSString *)aTitle
                            message:(NSString *)aMessage
                                tag:(NSInteger)aTag
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:aTitle
                                                        message:aMessage
                                                       delegate:aDelegate
                                              cancelButtonTitle:NSLocalizedString(@"Cancel", nil)
                                              otherButtonTitles:NSLocalizedString(@"OK", nil), nil];
        alert.tag = aTag;
        
        [alert show];
    });
}

+ (void)showNormalAlert:(NSString *)message
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                              otherButtonTitles:nil, nil];
        [alert show];
    });

}




@end

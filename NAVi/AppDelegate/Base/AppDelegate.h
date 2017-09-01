
#import <UIKit/UIKit.h>
#import "NABaseNavigationController.h"
#import "NAHomeViewController.h"
#import "NALoginViewController.h"
#import "NASaveData.h"
#import "NASettingViewController.h"
#import "NALoginClient.h"




@class TAGManager;
@class TAGContainer;




@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NALoginViewController *loginViewController;
@property (strong, nonatomic) NAHomeViewController *homeViewController;
@property(nonatomic, retain) TAGManager *tagManager;
@property(nonatomic, retain) TAGContainer *container;


@end


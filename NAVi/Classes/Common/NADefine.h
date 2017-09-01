
#ifndef NAVi_NADefine_h
#define NAVi_NADefine_h

#define isPad  (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define isPhone  (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

//login
#define LoginLabelFont [FontUtil systemFontOfSize:12]

#define BaseNavBarColor [UIColor colorWithRed:39.0f / 255.0f green:39.0f / 255.0f blue:39.0f / 255.0f alpha:0.8]
//#define BaseToolBarbuleColor [UIColor colorWithRed:0 green:32.0f / 255.0f blue:96.0f / 255.0f alpha:1]

#define NAUserDevice  (isPad ? @"N01" : @"N02")


//toolbar
#define NAVBAR_HEIGHT 64
#define TOOLBAR_HEIGHT 44
#define PROGRESS_HEIGHT 12

#ifdef DEBUG
#define NALog(...) NSLog(__VA_ARGS__)
#else
#define NALog(...)
#endif



#endif

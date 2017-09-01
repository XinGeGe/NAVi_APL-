//
//  WQPDFManager.h
//  TestScrollView
//
//  Created by y fs on 15/12/14.
//  Copyright © 2015年 houyunchen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WQPDFManager : NSObject
/**
 *  @brief  创建PDF文件
 *
 *  @param  imgData         NSData型   照片数据
 *  @param  destFileName    NSString型 生成的PDF文件名
 *  @param  pw              NSString型 要设定的密码
 */
+ (void)WQCreatePDFFileWithSrc:(NSData *)imgData
                    toDestFile:(NSString *)destFileName
                  withPassword:(NSString *)pw;


/**
 *  @brief  抛出pdf文件存放地址
 *
 *  @param  filename    NSString型 文件名
 *
 *  @return NSString型 地址
 */
+ (NSString *)pdfDestPath:(NSString *)filename;
@end

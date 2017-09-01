
#import <Foundation/Foundation.h>

@interface SHXMLParser : NSObject <NSXMLParserDelegate>

+ (NSArray *)convertDictionaryArray:(NSArray *)dictionaryArray toObjectArrayWithClassName:(NSString *)className classVariables:(NSArray *)classVariables;
+ (id)getDataAtPath:(NSString *)path fromResultObject:(NSDictionary *)resultObject;
+ (NSArray *)getAsArray:(id)object; //Utility function to get single NSDictionary object inside a array, if array is passed return the same

- (NSDictionary *)parseData:(NSData *)XMLData;
- (void)parseData4Async:(NSData *)XMLData completionBlock:(void(^)(NSMutableDictionary *resultObj))completion;

@end
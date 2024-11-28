//
//  Mnager.h
//  Zhihu Daily
//
//  Created by nanxun on 2024/10/20.
//

#import <Foundation/Foundation.h>
#import "MainPageModel.h"
#import "AFNetworking.h"
#import "NewsModel.h"
#import "CommentsModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^successBlock)(MainPageModel* model);
typedef void(^success)(NewsModel* model);
typedef void(^allComment)(CommentsModel* model);
typedef void(^realComment)(NSMutableArray* ary);
@interface Manger : NSObject
+(instancetype) sharedManger;
- (void)urlDataLoad: (successBlock)success;
- (void)newDateLoad: (successBlock)success andNsstring:(NSString*) string;
- (void)commentsDataLoad:(success)success andSting:(NSString*) string;
- (void)longCommentContent:(allComment)success andNsstring:(NSString *)string;
- (void)shortCommentContent:(allComment)success andNsstring:(nonnull NSString *)string;
- (void)allCommentsContent:(realComment)success andNsstring:(nonnull NSString *)string;
@end

NS_ASSUME_NONNULL_END

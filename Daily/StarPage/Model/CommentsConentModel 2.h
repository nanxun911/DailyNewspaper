//
//  CommentsConentModel.h
//  Daily
//
//  Created by nanxun on 2024/10/31.
//

#import <Foundation/Foundation.h>
#import "ContentModel.h"
#import "YYModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CommentsConentModel : NSObject<YYModel>
@property (nonatomic, copy) NSString* author;
@property (nonatomic, copy) NSString* content;
@property (nonatomic, copy) NSString* avatar;
@property (nonatomic, assign) NSInteger PersonId;
@property (nonatomic, assign) NSInteger likes;
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, strong) ContentModel *replyTo;
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, assign) BOOL isHidden;
@end

NS_ASSUME_NONNULL_END

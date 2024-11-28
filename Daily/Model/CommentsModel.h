//
//  CommentsModel.h
//  Daily
//
//  Created by nanxun on 2024/10/29.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
#import "CommentsConentModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CommentsModel : NSObject
@property (nonatomic, copy) NSArray<CommentsConentModel*> *comments;

@end

NS_ASSUME_NONNULL_END

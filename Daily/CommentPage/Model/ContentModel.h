//
//  ConentModel.h
//  Daily
//
//  Created by nanxun on 2024/10/31.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ContentModel : NSObject<YYModel>
@property (nonatomic, copy) NSString* content;
@property (nonatomic, copy) NSString* author;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger personId;
@end

NS_ASSUME_NONNULL_END

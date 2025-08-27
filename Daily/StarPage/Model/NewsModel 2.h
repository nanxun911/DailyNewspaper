//
//  NewsModel.h
//  Daily
//
//  Created by nanxun on 2024/10/29.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface NewsModel : NSObject<YYModel>
@property (nonatomic, assign) NSInteger longComments;
@property (nonatomic, assign) NSInteger popularity;
@property (nonatomic, assign) NSInteger shortComments;
@property (nonatomic, assign) NSInteger comments;
@end

NS_ASSUME_NONNULL_END

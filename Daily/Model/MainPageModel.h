//
//  MainPageModel.h
//  Zhihu Daily
//
//  Created by nanxun on 2024/10/20.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
#import "SoriesModel.h"
#import "TopModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MainPageModel : NSObject<YYModel>
@property (nonatomic, copy) NSString* date;
@property (nonatomic, copy) NSArray* stories;
@property (nonatomic, copy) NSArray* topStories;
@end

NS_ASSUME_NONNULL_END

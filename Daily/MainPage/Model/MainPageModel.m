//
//  MainPageModel.m
//  Zhihu Daily
//
//  Created by nanxun on 2024/10/20.
//

#import "MainPageModel.h"

@implementation MainPageModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{@"topStories":[TopModel class], @"stories":[SoriesModel class]};
}
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{@"topStories":@"top_stories"};
}
@end

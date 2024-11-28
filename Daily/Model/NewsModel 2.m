//
//  NewsModel.m
//  Daily
//
//  Created by nanxun on 2024/10/29.
//

#import "NewsModel.h"

@implementation NewsModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{@"longComments":@"long_comments", @"shortComments":@"short_comments"};
}
@end

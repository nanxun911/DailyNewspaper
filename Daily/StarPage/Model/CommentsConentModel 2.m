//
//  CommentsConentModel.m
//  Daily
//
//  Created by nanxun on 2024/10/31.
//

#import "CommentsConentModel.h"

@implementation CommentsConentModel
//+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
//    return @{@"replyTo":[ContentModel class]};
//}
+ (NSArray *)modelPropertyBlacklist {
    return @[@"isOpen", @"isHidden"];
}
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{@"personId":@"id",@"replyTo":@"reply_to"};
}

@end

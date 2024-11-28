//
//  CommentsModel.m
//  Daily
//
//  Created by nanxun on 2024/10/29.
//

#import "CommentsModel.h"

@implementation CommentsModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{@"comments":[CommentsConentModel class]};
}
@end

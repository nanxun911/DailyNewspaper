//
//  soriesModel.m
//  Zhihu Daily
//
//  Created by nanxun on 2024/10/20.
//

#import "SoriesModel.h"

@implementation SoriesModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{@"pageId":@"id",@"gaPrefix":@"ga_prefix",@"imageHue":@"image_hue"};
}
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{@"images":[NSString class]};
}
@end

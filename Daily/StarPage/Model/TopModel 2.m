//
//  TopModel.m
//  Zhihu Daily
//
//  Created by nanxun on 2024/10/20.
//

#import "TopModel.h"

@implementation TopModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{@"pageId":@"id",@"imageHue":@"image_hue"};
}

@end

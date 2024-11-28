//
//  Mnager.m
//  Zhihu Daily
//
//  Created by nanxun on 2024/10/20.
//

#import "Manger.h"
static id sharedManger = nil;
@implementation Manger
+(instancetype) sharedManger {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManger = [[super allocWithZone:NULL] init];
    });
    return sharedManger;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [Manger sharedManger];
}
- (void)urlDataLoad: (successBlock)success{
    AFHTTPSessionManager* manger = [AFHTTPSessionManager manager];
    NSString* str = @"https://news-at.zhihu.com/api/4/news/latest";
    [manger GET:str parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MainPageModel* model = [MainPageModel yy_modelWithJSON:responseObject];
        success(model);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ;
    }];
}
- (void)newDateLoad:(successBlock)success andNsstring:(nonnull NSString *)string{
    AFHTTPSessionManager* manger = [AFHTTPSessionManager manager];
    
    NSString* str = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/news/before/%@", string];
    [manger GET:str parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success");
        MainPageModel* model = [MainPageModel yy_modelWithJSON:responseObject];
        success(model);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error");
    }];
}

@end

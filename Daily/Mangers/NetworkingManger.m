//
//  Mnager.m
//  Zhihu Daily
//
//  Created by nanxun on 2024/10/20.
//

#import "NetworkingManger.h"
static id sharedManger = nil;
@implementation NetworkingManger
+(instancetype) sharedManger {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManger = [[super allocWithZone:NULL] init];
    });
    return sharedManger;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [NetworkingManger sharedManger];
}
- (void)urlDataLoad:(successBlock)success {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlString = @"https://news-at.zhihu.com/api/4/news/latest";
    
    // 设置响应序列化格式
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // 配置缓存策略为使用缓存
    //manager.requestSerializer.cachePolicy = NSURLRequestReloadRevalidatingCacheData;
    
    [manager GET:urlString parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 请求成功，处理服务器返回数据
        MainPageModel *model = [MainPageModel yy_modelWithJSON:responseObject];
        NSLog(@"从网络加载数据");
        success(model);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 网络请求失败，尝试从缓存加载数据
        NSCachedURLResponse *cachedResponse = [[NSURLCache sharedURLCache] cachedResponseForRequest:task.originalRequest];
        if (cachedResponse) {
            NSLog(@"网络请求失败，从缓存加载数据");
            id cachedObject = [NSJSONSerialization JSONObjectWithData:cachedResponse.data options:0 error:nil];
            MainPageModel *model = [MainPageModel yy_modelWithJSON:cachedObject];
            success(model);
        } else {
            NSLog(@"无网络且无缓存，无法加载数据：%@", error.localizedDescription);
        }
    }];
}

-(void)AFNReachability{
    /*
     AFNetworkReachabilityStatusUnknown     = 未知
     AFNetworkReachabilityStatusNotReachable   = 没有网络
     AFNetworkReachabilityStatusReachableViaWWAN = 3G
     AFNetworkReachabilityStatusReachableViaWiFi = WIFI
     */
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                manager.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataDontLoad;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                manager.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataDontLoad;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringCacheData;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringCacheData;
                break;
            default:
                manager.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataDontLoad;
                break;
        }
    }];
    
}
- (void)commentsDataLoad:(success)success andSting:(NSString*) string {
    AFHTTPSessionManager* manger = [AFHTTPSessionManager manager];
    
    NSString* str = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/story-extra/%@", string];
    NSLog(@"%@", str);
    [manger GET:str parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success");
        NewsModel* model = [NewsModel yy_modelWithJSON:responseObject];
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSString *etag = response.allHeaderFields[@"Etag"];
        NSLog(@"Etag: %@", etag);
        //NSLog(@"%@", model);
        success(model);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error");
    }];
}
- (void)newDateLoad:(successBlock)success andNsstring:(nonnull NSString *)string {
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
- (void)longCommentContent:(allComment)success andNsstring:(nonnull NSString *)string {
    AFHTTPSessionManager* manger = [AFHTTPSessionManager manager];
    
    NSString* str = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/story/%@/long-comments", string];
    [manger GET:str parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success");
        CommentsModel* model = [CommentsModel yy_modelWithJSON:responseObject];
        for (id comments in model.comments) {
            CommentsConentModel* comment = (CommentsConentModel*) comments;
            comment.isOpen = NO;
        }
        success(model);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error");
    }];
}
- (void)shortCommentContent:(allComment)success andNsstring:(nonnull NSString *)string {
    AFHTTPSessionManager* manger = [AFHTTPSessionManager manager];
    
    NSString* str = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/story/%@/short-comments", string];
    NSLog(@"%@", str);
    [manger GET:str parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success");
        CommentsModel* model = [CommentsModel yy_modelWithJSON:responseObject];
        for (id comments in model.comments) {
            CommentsConentModel* comment = (CommentsConentModel*) comments;
            comment.isOpen = NO;
            comment.isHidden = YES;
        }
        success(model);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error");
    }];
}

@end

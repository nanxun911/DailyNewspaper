//
//  soriesModel.h
//  Zhihu Daily
//
//  Created by nanxun on 2024/10/20.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SoriesModel : NSObject<YYModel>
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* hint;
@property (nonatomic, copy) NSString* gaPrefix;
@property (nonatomic, copy) NSArray* images;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger pageId;
@property (nonatomic, copy) NSString* imageHue;
@end

NS_ASSUME_NONNULL_END

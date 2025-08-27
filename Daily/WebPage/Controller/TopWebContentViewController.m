//
//  TopWebContentViewController.m
//  Daily
//
//  Created by nanxun on 2024/10/28.
//

#import "TopWebContentViewController.h"

@interface TopWebContentViewController ()

@end

@implementation TopWebContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webSet = [NSMutableSet set];
    self.newsModel = [NSMutableDictionary dictionary];
    self.iView = [[WebScrollView alloc] initWithFrame:self.view.bounds];
    self.iView.webContentView.webView.navigationDelegate = self;
    self.iView.scrollView.delegate = self;
    self.iView.backgroundColor = UIColor.whiteColor;
    //self.navigationController.toolbarHidden = NO;
    self.navigationController.toolbar.backgroundColor = [UIColor colorWithRed:246.0 / 256.0 green:246.0 / 256.0 blue:246.0 / 256.0 alpha:1];
    
    
    if (self.navigationController.toolbar.subviews.count == 1) {
        
    }
    
    [self.view addSubview:self.iView];
    self.loading = NO;
    NSLog(@"%ld", self.navigationController.toolbar.subviews.count);
    
    self.urlString = [NSString stringWithFormat:@"https://daily.zhihu.com/story/%ld", self.webId];
    NSLog(@"%@", _urlString);
    [self.webSet addObject:_urlString];
    //NSLog(@"%@", self.urlString);
    NSURL* url = [NSURL URLWithString:self.urlString];
    NSURLRequest* requset = [NSURLRequest requestWithURL:url];
    //NSLog(@"%ld", self.ary.count);
    self.loading = YES;
    if (self.section == self.ary.count - 1) {
        NSLog(@"点击最后一张视图");
        [self.iView setScrollContent:self.section];
        [self.iView setWebPoint:self.section];
        [self.iView.webContentView.webView loadRequest:requset];
        [self addTargetToButton:self.iView andSection:0];
        [self loadLabel:self.section andView:self.iView];
    } else {
        [self.iView setScrollContent:self.section + 2];
        [self.iView setWebPoint:self.section];
        [self.iView.webContentView.webView loadRequest:requset];
        [self addTargetToButton:self.iView andSection:0];
        [self loadLabel:self.section andView:self.iView];
    }
    [self.iView setScrollContent:self.section + 2];
    [self.iView setWebPoint:self.section];
    [self.iView.webContentView.webView loadRequest:requset];
    [self addTargetToButton:self.iView andSection:0];
    [self loadLabel:self.section andView:self.iView];
    [self searchInDataBase];
//    NSLog(@"%@", self.iView.ary);
//    NSLog(@"%ld", self.section);
//    NSLog(@"%lf %lf", self.iView.scrollView.contentOffset.x, self.iView.scrollView.contentSize.width);
    
    //toolbar
    
//    self.toolbarItems = [NSArray arrayWithArray:self.iView.ary];
//    for (int i = 0; i < self.toolbarItems.count; i++) {
//        UIBarButtonItem* item = self.toolbarItems[i];
//        UIButton* button = item.customView;
//        switch (i) {
//            case 0:
//                [button addTarget:self action:@selector(turnBack) forControlEvents:UIControlEventTouchUpInside];
//                break;
//            case 2:
//
//                break;
//            case 4:
//                break;
//            case 6:
//                break;
//            case 8:
//                break;
//            default:
//                break;
//        }
//    }
    //NSLog(@"%ld", self.navigationController.toolbar.subviews.count);
    // Do any additional setup after loading the view.
}
#pragma mark buttonType
- (void)turnBack {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)HeighlightPress:(UIButton*)button {
    button.selected = !button.selected;
}
#pragma mark viewController
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
#pragma mark scrollView
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat x = scrollView.contentOffset.x;
    CGFloat width = scrollView.contentSize.width;
    CGFloat screenWidth = self.view.bounds.size.width;
    
    if (x > width - 2 * screenWidth && !self.loading) {
        NSLog(@"后面的内容");
        self.loading = YES;
        self.section = (x / screenWidth + 1);
        [self scrollViewAfter:(x / screenWidth + 1)];
            //[self scrollViewAfter:(x / screenWidth + 2)];
    } else if (!self.loading){
        NSLog(@"前面的内容");
        self.loading = YES;
        self.section = x / screenWidth;
        [self scrollViewBefore:x / screenWidth];
    }
}
- (void)pushComment {
    
    CommentsViewController* viewController = [[CommentsViewController alloc] init];
    //viewController.dicty = [NSMutableDictionary dictionary];
    //viewController.dicty[[NSNumber numberWithInteger:self.section]] = self.ary[self.section];
    viewController.num = [self.ary[self.section] integerValue];
    [self.navigationController pushViewController:viewController animated:YES];
}
- (void)scrollViewBefore:(NSUInteger) section {
    NSString* string = [NSString stringWithFormat:@"https://daily.zhihu.com/story/%ld", [self.ary[section] integerValue]];
    if (![self.webSet containsObject:string]) {
        WebContentView* ContentView = [[WebContentView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * (section), 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        //ContentView.webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
        ContentView.webView.navigationDelegate = self;
        [self.webSet addObject:string];
        [self loadLabel:section andView:self.iView];
        NSURL* url = [NSURL URLWithString:string];
        NSURLRequest* request = [NSURLRequest requestWithURL:url];
        [ContentView.webView loadRequest:request];
        [self.iView.scrollView addSubview:ContentView];
        [self searchInDataBase];
    } else {
        NSLog(@"1不需要加载");
        [self loadLabel:section andView:self.iView];
        //NSLog(@"")
        self.loading = NO;
        [self searchInDataBase];
        return;
    }
}
-(void)scrollViewAfter:(NSUInteger) section {
    NSLog(@"%ld %ld", section, self.ary.count);
    if (section >= self.ary.count) {
        self.loading = NO;
        self.iView.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * section, 0);
        //[self loadLabel:self.ary.count - 1 andView:self.iView];
        self.section = self.ary.count - 1;
        return;
    }
    NSString* string = [NSString stringWithFormat:@"https://daily.zhihu.com/story/%ld", [self.ary[section] integerValue]];
    NSLog(@"%@", string);
    NSLog(@"%@", self.webSet);
    if (![self.webSet containsObject:string]) {
        NSLog(@"加载后面的内容");
        if (section == self.ary.count - 1) {
            self.iView.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * (section + 1), 0);
        } else {
            self.iView.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * (section + 2), 0);
        }
        WebContentView* ContentView = [[WebContentView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * (section), 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        //ContentView.webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
        ContentView.webView.navigationDelegate = self;
        [self.iView.scrollView addSubview:ContentView];
        [self.webSet addObject:string];
        [self loadLabel:section andView:self.iView];
        //webView.navigationDelegate = self;
        NSURL* url = [NSURL URLWithString:string];
        NSURLRequest* request = [NSURLRequest requestWithURL:url];
        [ContentView.webView loadRequest:request];
        [self searchInDataBase];
    } else {
        NSLog(@"2不需要加载");
        [self loadLabel:section andView:self.iView];
        self.loading = NO;
        [self searchInDataBase];
        return;
    }
}
-(void) loadLabel:(NSInteger) section andView:(WebScrollView*) view{
    NSString* str = [NSString stringWithFormat:@"%ld", [self.ary[section] integerValue]];
    NSLog(@"%ld", [self.ary[section] integerValue]);
    NSNumber* number = self.ary[section];
    if (!self.newsModel[number]) {
        [[NetworkingManger sharedManger] commentsDataLoad:^(NewsModel * _Nonnull model) {
            NSNumber* number = self.ary[section];
            self.newsModel[number] = model;
            NSLog(@"%@", self.newsModel);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self addTittleToButton:view andSection:section];
            });
        } andSting:str];
    } else {
        [self addTittleToButton:view andSection:section];
    }
    
}
#pragma mark Button
- (void)addTargetToButton:(WebScrollView*) view andSection:(NSInteger) section {
    int tmp = 0;
    for (id i in view.bar.subviews) {
        if ([i isKindOfClass:[UIButton class]]) {
            UIButton* button = (UIButton*) i;
            if (tmp == 0) {
                [button addTarget:self action:@selector(turnBack) forControlEvents:UIControlEventTouchUpInside];
            } else if (tmp == 1) {
                NSLog(@"1111");
                [button addTarget:self action:@selector(pushComment) forControlEvents:UIControlEventTouchUpInside];
            } else if (tmp == 4) {
                [button addTarget:self action:@selector(changeData:) forControlEvents:UIControlEventTouchUpInside];
            } else if (tmp == 2) {
                [button addTarget:self action:@selector(addLike:) forControlEvents:UIControlEventTouchUpInside];
            }
            tmp++;
        }
    }
}
-(void)addLike:(UIButton*)btn {
    btn.selected = !btn.selected;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeLike" object:nil userInfo:@{@"section":[NSNumber numberWithInteger:self.section], @"state":[NSNumber numberWithBool:btn.selected], @"top":self.ary[self.section]}];
}
-(void)changeData:(UIButton*)btn {
    btn.selected = !btn.selected;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeData" object:nil userInfo:@{@"section":[NSNumber numberWithInteger:self.section], @"state":[NSNumber numberWithBool:btn.selected], @"top":self.ary[self.section]}];
}
- (void)addTittleToButton:(WebScrollView*) view andSection:(NSInteger) section{
    int tmp = 0;
    for (id i in view.bar.subviews) {
        if ([i isKindOfClass:[UIButton class]]) {
            UIButton* button = (UIButton*) i;
            if (tmp == 0) {
                ;
            } else if (tmp == 1) {
                NSNumber* number = self.ary[section];
                NewsModel* commentCount = self.newsModel[number];
                NSString* str1 = [NSString stringWithFormat:@"%ld", commentCount.comments];
                [button setTitle:str1 forState:UIControlStateNormal];
            } else if (tmp == 2) {
                NSNumber* number = self.ary[section];
                NSInteger popularity = [self.newsModel[number] popularity];
                NSString* str1 = [NSString stringWithFormat:@"%ld", popularity];
                NSInteger popularity2 = [self.newsModel[number] popularity] + 1;
                NSString* str2 = [NSString stringWithFormat:@"%ld", popularity2];
                [button setTitle:str2 forState:UIControlStateSelected];
                [button setTitle:str1 forState:UIControlStateNormal];
            }
            tmp++;
        }
    }
}
-(void)searchInDataBase {
    BOOL selectFlag = NO;
    BOOL starFlag = NO;
    if ([[DataBaseManger ShareDateBaseManger].db open]) {
        FMResultSet* set = [[DataBaseManger ShareDateBaseManger].db executeQuery:@"select * from collectionCenter"];
        NSString* string = [NSString stringWithFormat:@"%ld", [self.ary[self.section] integerValue]];
        
        while ([set next]) {
            NSString* pageId = [set stringForColumn:@"webPageId"];
            BOOL select = [set boolForColumn:@"likes"];
            BOOL selectStar = [set boolForColumn:@"star"];
            //NSLog(@"")
            if ([pageId isEqualToString:string] && selectStar) {
                starFlag = YES;
                NSLog(@"该页面已经被收藏了");
            }
            if (select && [pageId isEqualToString:string]) {
                selectFlag = YES;
                NSLog(@"该页面曾经被点过一个赞");
            }
        }
    } else {
        NSLog(@"error");
    }
    UIButton* likeButton = (UIButton*)self.iView.bar.subviews[4];
    UIButton* starButton = (UIButton*)self.iView.bar.subviews[2];
    likeButton.selected = starFlag;
    starButton.selected = selectFlag;
}
//- (void)loadMyView:(NSInteger)section andString:(NSString*)string{
//    self.iView.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * (section + 1), 0);
//    WKWebView* webView = [[WKWebView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * section , 0, self.view.bounds.size.width, self.view.bounds.size.height - 60)];
//    [self.iView.scrollView addSubview:webView];
//    [self.webSet addObject:string];
//    webView.navigationDelegate = self;
//    NSURL* url = [NSURL URLWithString:string];
//    NSURLRequest* request = [NSURLRequest requestWithURL:url];
//    [webView loadRequest:request];
//}
//#pragma mark NetWork
//- (void)loadNewDate:(NSString*)str andSetcion:(NSInteger) section{
//    [[Manger sharedManger] newDateLoad:^(MainPageModel * _Nonnull model) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeModel" object:nil userInfo:@{@"model":model}];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            for (int j = 0; j < model.stories.count; j++) {
//                NSInteger pageId = [model.stories[j] pageId];
//                NSNumber* number = [NSNumber numberWithInteger:pageId];
//                [self.ary addObject:number];
//            }
//            NSInteger loadPageId;
//            loadPageId = [self.ary[self.ary.count - model.stories.count] integerValue];
//            NSString* string = [NSString stringWithFormat:@"https://daily.zhihu.com/story/%ld", loadPageId];
//            WebContentView* ContentView = [[WebContentView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * (section), 0, self.view.bounds.size.width, self.view.bounds.size.height)];
//            
//            //ContentView.webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
//            ContentView.webView.navigationDelegate = self;
//            [self.iView.scrollView addSubview:ContentView];
//            [self.webSet addObject:string];
//            //ContentView.webView.navigationDelegate = self;
//            NSURL* url = [NSURL URLWithString:string];
//            NSURLRequest* request = [NSURLRequest requestWithURL:url];
//            [ContentView.webView loadRequest:request];
//        });
//    } andNsstring:str];
//}
#pragma mark WKWeb
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"网页加载完成");
    self.loading = NO;
    NSLog(@"1");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

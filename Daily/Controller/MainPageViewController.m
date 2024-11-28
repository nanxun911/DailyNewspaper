//
//  MainPageViewController.m
//  Zhihu Daily
//
//  Created by nanxun on 2024/10/20.
//

#import "MainPageViewController.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface MainPageViewController ()

@end

@implementation MainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loading = NO;
    //id manger = [Manger sharedManger];
    DateModel* date = [[DateModel alloc] init];
    [date judgeTime];
    [date judgeDate];
    self.dateModel = date;

    Manger* manger = [Manger sharedManger];
//    [manger urlDataLoad:^(MainPageModel * _Nonnull model) {
//        
//    }];
    self.timer = nil;
    MainPageView* myview = [[MainPageView alloc] init];
    self.iView = myview;
    self.iModel = nil;
    
    //NSLog(@"%@", date.monthString);
    self.iView.dataView.mothLabel.text = [date.monthString copy];
    self.iView.dataView.dayLabel.text = [date.dateString copy];
    [self.view addSubview:self.iView];
    [myview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.width.right.top.equalTo(self.view);
    }];
    [self.iView.rightButton addTarget:self action:@selector(pushPerson) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationController.navigationBar.standardAppearance = self.iView.apperance;
    self.navigationController.navigationBar.scrollEdgeAppearance =  self.iView.apperance;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.iView.dataView];
    myview.titleView.text = [date.string copy];
    UIBarButtonItem* rightButton = [[UIBarButtonItem alloc] initWithCustomView:self.iView.rightButton];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    self.navigationItem.titleView = self.iView.titleView;
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.iView.imageView];
    //myview.scrollView.delegate = self;
    [manger urlDataLoad:^(MainPageModel * _Nonnull model) {
        self.iModel = [NSMutableArray array];
        [self.iModel addObject:model];
        NSLog(@"123");
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //NSLog(@"12312312");
            //NSLog(@"%ld", self.iModel.count);
            self.iView.tableView.tableHeaderView = self.iView.headerView;
            self.iView.tableView.tableFooterView = self.iView.footerView;
            self.iView.tableView.delegate = self;
            self.iView.tableView.dataSource = self;
//            [self.iView.tableView.refreshControl addTarget:self action:@selector(download) forControlEvents:UIControlEventValueChanged];
            [self.iView.tableView registerClass:[ContentTableViewCell class] forCellReuseIdentifier:@"content"];
            [self.iView.tableView registerClass:[TopTableViewCell class] forCellReuseIdentifier:@"scrollView"];
            UIScrollView* scrollView = (UIScrollView*)self.iView.tableView;
            [scrollView setContentOffset:CGPointMake(0, -88)];
            //[self.iView.tableView reloadData];
        });
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(push) name:@"touch" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addModel:) name:@"changeModel" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeData:) name:@"changeData" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLike:) name:@"changeLike" object:nil];
//    NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(scrollAuto) userInfo:nil repeats:YES];
    //[self.iView.tableView registerClass:[TopTableViewCell class] forCellReuseIdentifier:@"test"];
    // Do any additional setup after loading the view.
}
-(void)addModel:(NSNotification*) send {
    [self.iModel addObject:send.userInfo[@"model"]];
    [self.iView.tableView reloadData];
}
-(void)changeData:(NSNotification*)send {
    StarModel* model = [[StarModel alloc] init];
    NSNumber* postion = send.userInfo[@"section"];
    NSInteger allCount = [postion integerValue] + 1;
    NSInteger row = 0;
    NSInteger section = 0;
    NSLog(@"%ld %ld %ld", allCount, section, row);
    for (int i = 0; i < self.iModel.count; i++) {
        if (allCount <= self.iModel[i].stories.count) {
            row = allCount - 1;
            section = i;
            break;
        }
        allCount -= self.iModel[i].stories.count;
        //NSLog(@"做减法");
    }
    NSString* string;
    if (send.userInfo[@"top"]) {
        section = allCount - 1;
        row = 0;
        TopModel* story = self.iModel[0].topStories[section];
        string = [NSString stringWithFormat:@"%ld", [send.userInfo[@"top"] integerValue]];
    } else {
        SoriesModel* story = self.iModel[section].stories[row];
        string = [NSString stringWithFormat:@"%ld", story.pageId];
    }
    NSLog(@"%ld %ld %ld", allCount, section, row);
    NSNumber* state = send.userInfo[@"state"];
    if ([state boolValue] && ![self searchInDataBase:string]) {
        if (send.userInfo[@"top"]) {
            NSLog(@"1111");
            TopModel* story = self.iModel[0].topStories[section];
            model.titile = [story.title copy];
            model.webPageId = [NSString stringWithFormat:@"%ld", [send.userInfo[@"top"] integerValue]];
            model.imageUrl = [story.image copy];
        } else {
            NSLog(@"22");
            SoriesModel* story = self.iModel[section].stories[row];
            model.titile = [story.title copy];
            model.webPageId = [NSString stringWithFormat:@"%ld", story.pageId];
            model.imageUrl = [story.images[0] copy];
        }
        
        model.selectLike = 0;
        model.selectStar = 1;
        NSLog(@"%ld", model.selectLike);
        //NSLog(@"%@", model.titile);
        [model insertData];
    } else if ([state boolValue] && [self searchInDataBase:string]) {
        if (send.userInfo[@"top"]) {
            TopModel* story = self.iModel[0].topStories[section];
            model.webPageId = [NSString stringWithFormat:@"%ld", [send.userInfo[@"top"] integerValue]];
        } else {
            SoriesModel* story = self.iModel[section].stories[row];
            model.webPageId = [NSString stringWithFormat:@"%ld", story.pageId];
        }
        
        model.selectStar = 1;
        [model changeData];
    } else {
        if (send.userInfo[@"top"]) {
            TopModel* story = self.iModel[0].topStories[section];
            model.webPageId = [NSString stringWithFormat:@"%ld", [send.userInfo[@"top"] integerValue]];
        } else {
            SoriesModel* story = self.iModel[section].stories[row];
            model.webPageId = [NSString stringWithFormat:@"%ld", story.pageId];
        }
        model.selectStar = 0;
        //NSLog(@"%@", model.titile);
        [model changeData];
    }
}

-(void)changeLike:(NSNotification*)send {
    StarModel* model = [[StarModel alloc] init];
    NSNumber* postion = send.userInfo[@"section"];
    NSInteger allCount = [postion integerValue] + 1;
    NSInteger row = 0;
    NSInteger section = 0;
    NSLog(@"%ld %ld %ld", allCount, section, row);
    
    for (int i = 0; i < self.iModel.count; i++) {
        if (allCount <= self.iModel[i].stories.count) {
            row = allCount - 1;
            section = i;
            break;
        }
        allCount -= self.iModel[i].stories.count;
        //NSLog(@"做减法");
    }
    NSString* string;
    if (send.userInfo[@"top"]) {
        section = allCount - 1;
        row = 0;
        TopModel* story = self.iModel[0].topStories[section];
        string = [NSString stringWithFormat:@"%d", [send.userInfo[@"top"] intValue]];
    } else {
        SoriesModel* story = self.iModel[section].stories[row];
        string = [NSString stringWithFormat:@"%ld", story.pageId];
    }
    NSLog(@"%ld %ld %ld", allCount, section, row);
    NSNumber* state = send.userInfo[@"state"];
    if ([state boolValue] && ![self searchInDataBase:string]) {
        if (send.userInfo[@"top"]) {
            NSLog(@"1111");
            TopModel* story = self.iModel[0].topStories[section];
            model.titile = [story.title copy];
            model.webPageId = [NSString stringWithFormat:@"%d", [send.userInfo[@"top"] intValue]];
            model.imageUrl = [story.image copy];
        } else {
            NSLog(@"22");
            SoriesModel* story = self.iModel[section].stories[row];
            model.titile = [story.title copy];
            model.webPageId = [NSString stringWithFormat:@"%ld", story.pageId];
            model.imageUrl = [story.images[0] copy];
        }
        model.selectStar = 0;
        model.selectLike = 1;
        //NSLog(@"%@", model.titile);
        [model insertData];
    } else if ([state boolValue] && [self searchInDataBase:string]) {
        if (send.userInfo[@"top"]) {
            NSLog(@"1111");
            TopModel* story = self.iModel[0].topStories[section];
            model.titile = [story.title copy];
            model.webPageId = string;
            model.imageUrl = [story.image copy];
        } else {
            NSLog(@"22");
            SoriesModel* story = self.iModel[section].stories[row];
            model.titile = [story.title copy];
            model.webPageId = [NSString stringWithFormat:@"%ld", story.pageId];
            model.imageUrl = [story.images[0] copy];
        }
        model.selectLike = 1;
        [model changeLike];
    } else {
        if (send.userInfo[@"top"]) {
            NSLog(@"1111");
            TopModel* story = self.iModel[0].topStories[section];
            model.titile = [story.title copy];
            model.webPageId = string;
            model.imageUrl = [story.image copy];
        } else {
            NSLog(@"22");
            SoriesModel* story = self.iModel[section].stories[row];
            model.titile = [story.title copy];
            model.webPageId = [NSString stringWithFormat:@"%ld", story.pageId];
            model.imageUrl = [story.images[0] copy];
        }
        model.selectLike = 0;
        NSLog(@"取消点赞");
        //NSLog(@"%@", model.titile);
        [model changeLike];
    }
}

-(BOOL)searchInDataBase:(NSString*) string{
    if ([[DataBaseManger ShareDateBaseManger].db open]) {
        FMResultSet* set = [[DataBaseManger ShareDateBaseManger].db executeQuery:@"select * from collectionCenter"];
        while ([set next]) {
            NSString* pageId = [set stringForColumn:@"webPageId"];
            //NSLog(@"")
            if ([pageId isEqualToString:string]) {
                return YES;
            }
        }
        return NO;
    }
    return NO;
}
-(void)pushPerson {
    PersonViewController* personViewController = [[PersonViewController alloc] init];
    [self.navigationController pushViewController:personViewController animated:YES];
}
-(void)push {
    NSLog(@"选中无限轮播图");
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
    TopWebContentViewController* viewController = [[TopWebContentViewController alloc] init];
    viewController.webId = [self.iModel[0].topStories[self.nowPage] pageId];
    NSMutableArray* ary = [NSMutableArray array];
    BOOL sectionFlag = YES;
    for (int j = 0; j < self.iModel[0].topStories.count; j++) {
        NSInteger pageId = [self.iModel[0].topStories[j] pageId];
        [ary addObject: [NSNumber numberWithInteger:pageId]];
        if (viewController.webId != pageId && sectionFlag) {
            viewController.section++;
        } else {
            sectionFlag = NO;
        }
    }
    NSMutableString* str = [NSMutableString stringWithString:self.dateModel.headString];
    NSUInteger date = [str integerValue] - self.iModel.count + 1;
    viewController.dateString = [NSMutableString stringWithFormat:@"%ld", date];
    viewController.ary = [NSMutableArray arrayWithArray:ary];
    [self.navigationController pushViewController:viewController animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setToolbarHidden:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
#pragma mark tableView;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TopTableViewCell *scrollViewCell = [self.iView.tableView dequeueReusableCellWithIdentifier:@"scrollView"];
    ContentTableViewCell *cell = [self.iView.tableView dequeueReusableCellWithIdentifier:@"content"];
    scrollViewCell.scrollView.delegate = self;
    if (self.iModel == nil) {
        return nil;
    }
    if (indexPath.section == 0) {
        //NSLog(@"error");
        NSUInteger count = self.iModel[0].topStories.count;
        if (self.timer != nil) {
            [self.timer invalidate];
            self.timer = nil;
        }
        //self.iView.page.currentPage = 0;
        [scrollViewCell setImageUrls:self.iModel[0].topStories];
        [self scrollAuto:scrollViewCell.scrollView];
        self.iView.page.currentPage = self.nowPage;
        return scrollViewCell;
    } else {
        SoriesModel* story = self.iModel[indexPath.section - 1].stories[indexPath.row];
        cell.authorLabel.text = [story.hint copy];
        cell.mainLabel.text = [story.title copy];
        //NSLog(@"%@", story.images);
        [cell.storyView sd_setImageWithURL:[NSURL URLWithString:(story.images[0])]];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return;
    } else {
        if (self.timer != nil) {
            [self.timer invalidate];
            self.timer = nil;
        }
        WebContentViewController* viewController = [[WebContentViewController alloc] init];
        viewController.section = 0;
        viewController.webId = [self.iModel[indexPath.section - 1].stories[indexPath.row] pageId];
        NSMutableArray* ary = [NSMutableArray array];
        BOOL sectionFlag = YES;
        for (int i = 0; i < self.iModel.count; i++) {
            for (int j = 0; j < self.iModel[i].stories.count; j++) {
                NSInteger pageId = [self.iModel[i].stories[j] pageId];
                [ary addObject: [NSNumber numberWithInteger:pageId]];
                if (viewController.webId != pageId && sectionFlag) {
                    viewController.section++;
                } else {
                    sectionFlag = NO;
                }
            }
        }
        NSMutableString* str = [NSMutableString stringWithString:self.dateModel.headString];
        NSUInteger date = [str integerValue] - self.iModel.count + 1;
        viewController.dateString = [NSMutableString stringWithFormat:@"%ld", date];
        viewController.ary = [NSMutableArray arrayWithArray:ary];
        viewController.dateModel = self.dateModel;
        viewController.modelNum = self.iModel.count;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return WIDTH - 20;
    } else {
        return 100;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.iModel == nil) {
        return 0;
    } else {
        return self.iModel.count + 1;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.iModel == nil) {
        return 0;
    }
    if (section == 0) {
        return 1;
    } else {
        return self.iModel[section - 1].stories.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section > 1) {
        return 40;
    } else {
        return 0.0001;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section > 1) {
        HeadView* view = [[HeadView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 50)];
        NSMutableString* str = [NSMutableString stringWithFormat:@"%@", [self.dateModel computingTime:self.dateModel.headString andDay:section - 1]];
        NSString* day = [str substringWithRange:NSMakeRange(str.length - 2, 2)];
        NSString* month = [str substringWithRange:NSMakeRange(str.length -4, 2)];
        view.label.text = [NSString stringWithFormat:@"%ld月%ld日", [month integerValue], [day integerValue]];
        return view;
    } else {
        return nil;
    }
}

#pragma mark scrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.tag == 100) {
        CGFloat x = scrollView.contentOffset.x;
        //CGFloat y = scrollView.contentOffset.y;
        CGFloat contentWidth = scrollView.contentSize.width;
        if (x >= contentWidth - WIDTH) {
            [scrollView setContentOffset:CGPointMake(WIDTH, 0) animated:NO];
            NSLog(@"1");
        } else if (x <= 0) {
            [scrollView setContentOffset:CGPointMake(contentWidth - 2 * WIDTH, 0) animated:NO];
            NSLog(@"2");
        } else {
            self.iView.page.currentPage = x / WIDTH - 1;
            self.nowPage = x / WIDTH - 1;
        }
    } else if (scrollView.tag == 101 && !self.loading) {
        CGFloat y = scrollView.contentOffset.y;
        CGFloat contentHeight = scrollView.contentSize.height;
        CGFloat height = scrollView.bounds.size.height;
        //NSLog(@"%lf ? %lf", height, contentHeight);
        //NSLog(@"%lf", y);
        if (y + height >= contentHeight + 10) {
            //NSLog(@"%lf", y);
            [self loadData];
        } else if (y < -90) {
            [self download];
        }
//        if (y >= contentHeight - height - 100) {
//            [self loadData];
//        }
    }
}
-(void)download {
    //[self.iView.tableView.refreshControl beginRefreshing];
    //self.iView.tableView.tableHeaderView = self.iView.footerView;
    if (self.iView.headActivity.animating) {
        return;
    }
    self.iView.tableView.tableHeaderView = self.iView.headerView;
    //[self.iView.activity startAnimating];
    [self.iView.headActivity startAnimating];
    
    [[Manger sharedManger] urlDataLoad:^(MainPageModel * _Nonnull model) {
        self.iModel = [NSMutableArray arrayWithObject:model];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.iView.tableView reloadData];
            //[self.iView.tableView.refreshControl endRefreshing];
            [self.iView.headActivity stopAnimating];
            [self.iView.tableView setContentOffset:CGPointMake(0, -88) animated:YES];
            //self.iView.tableView.tableHeaderView = nil;
        });
    }];
}
-(void)scrollAuto:(UIScrollView*)scrollView {
    if (self.timer == nil) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(scrollNextPage:) userInfo:scrollView repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}
- (void)scrollNextPage:(NSTimer *)timer {
    UIScrollView *scrollView = (UIScrollView *)timer.userInfo;
    CGFloat x = scrollView.contentOffset.x;
    [scrollView setContentOffset:CGPointMake(x + WIDTH, 0) animated:YES];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView.tag == 100) {
        [self.timer invalidate];
        self.timer = nil;
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.tag == 100) {
        if (self.timer == nil) {
            [self scrollAuto:scrollView];
        }
    }
}
#pragma mark netWork
-(void)loadData {
    if (self.loading) {
        return;
    }
    self.loading = YES;
    NSInteger num = [self.dateModel.headString intValue];
    NSString* str = [self.dateModel computingTime:self.dateModel.headString andDay:self.iModel.count - 1];
    NSInteger count = self.iModel.count;
    NSLog(@"%@", str);
    self.iView.tableView.tableFooterView = self.iView.footerView;
    [self.iView.activity startAnimating];
    //dispatch_group_t gruop = dispatch_group_create();
    //[self.iView.activity startAnimating];
    NSConditionLock* lock = [[NSConditionLock alloc] initWithCondition:0];
    dispatch_queue_t queue = dispatch_queue_create(@"current", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 3; i++) {
        //str = [self.dateModel computingTime:self.dateModel.headString andDay:self.iModel.count - 1];
        //dispatch_group_enter(gruop);
        NSLog(@"执行第%ld个任务", i);
        str = [self.dateModel computingTime:self.dateModel.headString andDay:count - 1 + i];
        NSLog(@"每个任务对应的字符串%@", str);
        [[Manger sharedManger] newDateLoad:^(MainPageModel * _Nonnull model) {
            dispatch_async(queue, ^{
                [lock lockWhenCondition:i];
                [self.iModel addObject:model];
                NSLog(@"%ld", self.iModel.count);
                [lock unlockWithCondition:i + 1];
                if (i == 2) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.iView.tableView reloadData];
                        [self.iView.activity stopAnimating];
                        self.iView.tableView.tableFooterView = nil;
                        self.loading = NO;
                    });
                }
                NSLog(@"%@", str);
            });
            //dispatch_group_leave(gruop);
        } andNsstring:str];
        //dispatch_group_wait(gruop, DISPATCH_TIME_FOREVER);
    }
//    dispatch_group_notify(gruop, dispatch_get_main_queue(), ^{
//        [self.iView.tableView reloadData];
//        [self.iView.activity stopAnimating];
//        self.iView.tableView.tableFooterView = nil;
//        self.loading = NO;
//    });
    
}
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

//
//  StarViewController.m
//  Daily
//
//  Created by nanxun on 2024/11/12.
//

#import "StarViewController.h"

@interface StarViewController ()

@end

@implementation StarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.iView = [[StarView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_iView];
    //self.iView.tableView.backgroundColor = UIColor.whiteColor;
    self.iView.tableView.delegate = self;
    self.iView.tableView.dataSource = self;
    [self.iView.tableView registerClass:[StarTableViewCell class] forCellReuseIdentifier:@"star"];
    [[DataBaseManger ShareDateBaseManger] Print];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated {
    self.iModel = [NSMutableArray array];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //UINavigationBarAppearance* apperance = [[UINavigationBarAppearance alloc] init];
    //apperance = [[UINavigationBarAppearance alloc] init];
    UILabel* label = [[UILabel alloc] init];
    label.text = @"收藏中心";
    label.font = [UIFont boldSystemFontOfSize:20];
//    apperance.backgroundColor = UIColor.whiteColor;
//    apperance.shadowColor = nil;
//    apperance.shadowImage = [[UIImage alloc] init];
//    self.navigationController.navigationBar.scrollEdgeAppearance = apperance;
//    self.navigationController.navigationBar.standardAppearance = apperance;
    UIButton* backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"fanhui-3.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(returnBack) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.titleView = label;
    [self loadData];
    [self.iView.tableView reloadData];
}
-(void)loadData {
    if ([[DataBaseManger ShareDateBaseManger].db open]) {
        NSString* selectSql = @"select * from collectionCenter";
        FMResultSet* set = [[DataBaseManger ShareDateBaseManger].db executeQuery:selectSql];
        while ([set next]) {
            StarModel* model = [[StarModel alloc] init];
            model.webPageId = [set stringForColumn:@"webPageId"];
            model.titile = [set stringForColumn:@"webPageTitle"];
            model.imageUrl = [set stringForColumn:@"webImageURL"];
            model.selectLike = [set intForColumn:@"likes"];
            model.selectStar = [set intForColumn:@"star"];
            if (model.selectStar) {
                [self.iModel addObject:model];
            } else if (!model.selectLike && !model.selectStar) {
                [model deleteData];
            }
            
        }
    }
}
-(void)returnBack {
    [self.navigationController popViewControllerAnimated:YES];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StarTableViewCell *cell = [self.iView.tableView dequeueReusableCellWithIdentifier: @"star"];
    NSURL* url = [NSURL URLWithString:self.iModel[indexPath.row].imageUrl];
    [cell.rightView sd_setImageWithURL:url];
    cell.label.text = self.iModel[indexPath.row].titile;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.iModel.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TopWebContentViewController* viewController = [[TopWebContentViewController alloc] init];
    viewController.webId = [[self.iModel[indexPath.row] webPageId] integerValue];
    NSMutableArray* ary = [NSMutableArray array];
    BOOL sectionFlag = YES;
    for (int j = 0; j < self.iModel.count; j++) {
        NSInteger pageId = [[self.iModel[j] webPageId] integerValue];
        [ary addObject: [NSNumber numberWithInteger:pageId]];
        if (viewController.webId != pageId && sectionFlag) {
            viewController.section++;
        } else {
            sectionFlag = NO;
        }
    }
    viewController.ary = [NSMutableArray arrayWithArray:ary];
    [self.navigationController pushViewController:viewController animated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 393, 0.01)];
    view.backgroundColor = UIColor.whiteColor;
    return view;
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

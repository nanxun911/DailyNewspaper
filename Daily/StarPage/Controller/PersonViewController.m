//
//  PersonViewController.m
//  Daily
//
//  Created by nanxun on 2024/11/12.
//

#import "PersonViewController.h"

@interface PersonViewController ()

@end

@implementation PersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.iView = [[PersonView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_iView];
    self.iView.tableView.delegate = self;
    self.iView.tableView.dataSource = self;
    //[self.iView.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"person"];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    UINavigationBarAppearance* apperance = [[UINavigationBarAppearance alloc] init];
    //apperance = [[UINavigationBarAppearance alloc] init];
    apperance.backgroundColor = UIColor.whiteColor;
    apperance.shadowColor = nil;
    apperance.shadowImage = [[UIImage alloc] init];
    self.navigationController.navigationBar.scrollEdgeAppearance = apperance;
    self.navigationController.navigationBar.standardAppearance = apperance;
    UIButton* backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"fanhui-3.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(returnBack) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}
-(void)returnBack {
    [self.navigationController popViewControllerAnimated:YES];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"person"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"person"];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text= @"我的收藏";
    } else {
        cell.textLabel.text = @"消息中心";
    }
    
    //cell.detailTextLabel.text = @"我是子标题";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        StarViewController* viewController = [[StarViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    } else {
        return;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    PesonHeadView* view = [[PesonHeadView alloc] initWithFrame:CGRectMake(0, 0, 393, 200)];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 200;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
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

//
//  CommentsViewController.m
//  Daily
//
//  Created by nanxun on 2024/10/31.
//

#import "CommentsViewController.h"

@interface CommentsViewController ()

@end

@implementation CommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.iView = [[CommentsView alloc] initWithFrame:self.view.bounds];
    
    //self.dicty = [NSMutableDictionary dictionary];
    [self.view addSubview:self.iView];
    NSLog(@"%ld", self.num);
    NSString* str = [NSString stringWithFormat:@"%ld", self.num];
    //self.labelHeightConstraint.constant = 0;
    [self allCommentsContentNsstring:str];
    // Do any additional setup after loading the view.
}
- (void)allCommentsContentNsstring:(nonnull NSString *)string {
    dispatch_group_t group = dispatch_group_create();
    NSMutableArray* ary = [NSMutableArray array];
    dispatch_group_enter(group);
    [[Manger sharedManger] shortCommentContent:^(CommentsModel * _Nonnull model) {
        self.shortCommentsModel = model;
        dispatch_group_leave(group);
    } andNsstring:string];
    dispatch_group_enter(group);
    [[Manger sharedManger] longCommentContent:^(CommentsModel * _Nonnull model) {
        self.LongCommentsModel = model;
        dispatch_group_leave(group);
    } andNsstring:string];
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        self.iView.tableView.delegate = self;
        self.iView.tableView.dataSource = self;
        
        [self.iView.tableView registerClass:[CommentsTableViewCell class] forCellReuseIdentifier:@"comments"];
        [self.iView.tableView reloadData];
    });
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
    UILabel* label = [[UILabel alloc] init];
    label.text = @"全部评论";
    label.font = [UIFont boldSystemFontOfSize:20];
    UIButton* backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"fanhui-3.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(returnBack) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.titleView = label;
}
-(void)returnBack {
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentsTableViewCell* cell = [self.iView.tableView dequeueReusableCellWithIdentifier:@"comments"];
    
    if (indexPath.section == 1 || self.LongCommentsModel.comments.count == 0) {
        if (indexPath.row == 0) {
            [cell.headLabel setHidden:NO];
            cell.headLabel.text = [NSString stringWithFormat:@"%ld条短评论", self.shortCommentsModel.comments.count];
        } else {
            [cell.headLabel setHidden:YES];
            
        }
        cell.commentText.text = nil;
        cell.commentText.attributedText = nil;
        cell.textView.text = self.shortCommentsModel.comments[indexPath.row].content;
        cell.nameLabel.text = self.shortCommentsModel.comments[indexPath.row].author;
        [cell.image sd_setImageWithURL:[NSURL URLWithString:self.shortCommentsModel.comments[indexPath.row].avatar]];
        NSTimeInterval timeStamp = self.shortCommentsModel.comments[indexPath.row].time;
        NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
        NSDateFormatter* fotmatter = [[NSDateFormatter alloc] init];
        //NSLog(@"%@", self.shortCommentsModel.comments[indexPath.row].replyTo);
        if (!self.shortCommentsModel.comments[indexPath.row].replyTo) {
            self.shortCommentsModel.comments[indexPath.row].isHidden = YES;
            [cell.commentText setHidden:self.shortCommentsModel.comments[indexPath.row].isHidden];
        } else {
            self.shortCommentsModel.comments[indexPath.row].isHidden = NO;
            [cell.commentText setHidden:self.shortCommentsModel.comments[indexPath.row].isHidden];
            cell.commentText.delegate = self;
            NSString* str = [NSString stringWithFormat:@"//%@:%@", self.shortCommentsModel.comments[indexPath.row].replyTo.author, self.shortCommentsModel.comments[indexPath.row].replyTo.content];
            cell.commentText.text = str;
            //NSLog(@"%lf", [cell.commentText sizeThatFits:cell.commentText.bounds.size].height);
            NSLog(@"%@", [cell.commentText stringOfLine:1]);
            NSLog(@"%@", [cell.commentText stringOfLine:1]);
            //NSLog(@"行数为%d", [cell.commentText getLinesWithLabelWidth:cell.commentText.contentSize.width]);
            //NSLog(@"%d", [cell.commentText judgeHeight]);
            if ([cell.commentText getLinesWithLabelWidth:(cell.commentText.bounds.size.width - cell.commentText.textContainerInset.left - cell.commentText.textContainerInset.right - cell.commentText.textContainer.lineFragmentPadding * 2)] > 2 && !self.shortCommentsModel.comments[indexPath.row].isOpen) {
                
                NSString* string = @"…展开";
                //NSString* contentString = [NSString stringWithFormat:@"%@%@", str, string];
                
                //[cell.commentText addSuffixString:string isOpne:self.shortCommentsModel.comments[indexPath.row].isOpen];
                NSLog(@"%@", cell.commentText.text);
                [cell.commentText getTitle:cell.commentText.text flagStr:@""];
                NSMutableAttributedString* attStr = [[NSMutableAttributedString alloc] initWithString:cell.commentText.text attributes:@{NSFontAttributeName:cell.commentText.font}];
                [self addTitleButton:string andContent:cell.commentText.text andAtrutbeString:attStr];
                cell.commentText.attributedText = attStr;
                
                //NSLog(@"最后的一个%@", attStr.string);
            } else if (self.shortCommentsModel.comments[indexPath.row].isOpen) {
                //[cell.commentText setHidden:self.shortCommentsModel.comments[indexPath.row].isHidden];
                NSLog(@"12314");
                NSString* string = @" 收起";
                NSString* contentString = [NSString stringWithFormat:@"%@%@", str, string];
                cell.commentText.text = [contentString copy];
                NSMutableAttributedString* attStr = [[NSMutableAttributedString alloc] initWithString:contentString attributes:@{NSFontAttributeName:cell.commentText.font}];
                [self addTitleButton:string andContent:cell.commentText.text andAtrutbeString:attStr];
                cell.commentText.attributedText = attStr;
            }
            

            
            //cell.commentText.text = self.shortCommentsModel.comments[indexPath.row].replyTo.content;
            //cell.commentText.text = self.shortCommentsModel.comments[indexPath.row];
        }
    //    if (!self.shortCommentsModel.comments[indexPath.row].replyTo) {
    //        cell.commentText = nil;
    //        NSLog(@"11");
    //    }
        NSLog(@"点赞的一个个数%ld", self.shortCommentsModel.comments[indexPath.row].likes);
        if (self.shortCommentsModel.comments[indexPath.row].likes != 0) {
            [cell.likeButton setTitle:[NSString stringWithFormat:@"%ld", self.shortCommentsModel.comments[indexPath.row].likes] forState:UIControlStateNormal];
            //NSLog(@"%@", cell.likeButton)
        } else {
            [cell.likeButton setTitle:@"  " forState:UIControlStateNormal];
        }
        if ([date isDateToday:date]) {
            fotmatter.dateFormat = @"今天 HH:mm";
        } else {
            fotmatter.dateFormat = @"MM-dd HH:mm";
        }
        cell.timeLabel.text = [fotmatter stringFromDate:date];
        NSLog(@"%@", cell.timeLabel.text);
        //self.heightAry[indexPath.section][indexPath.row] = height;
        //cell.commentText.text = @"2";
    } else {
        if (indexPath.row == 0) {
            cell.headLabel.text = [NSString stringWithFormat:@"%ld条长评论", self.LongCommentsModel.comments.count];
        }
        cell.commentText.text = nil;
        cell.commentText.attributedText = nil;
        cell.textView.text = self.LongCommentsModel.comments[indexPath.row].content;
        cell.nameLabel.text = self.LongCommentsModel.comments[indexPath.row].author;
        [cell.image sd_setImageWithURL:[NSURL URLWithString:self.LongCommentsModel.comments[indexPath.row].avatar]];
        NSTimeInterval timeStamp = self.LongCommentsModel.comments[indexPath.row].time;
        NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
        NSDateFormatter* fotmatter = [[NSDateFormatter alloc] init];
        if ([date isDateToday:date]) {
            fotmatter.dateFormat = @"今天 HH:mm";
        } else {
            fotmatter.dateFormat = @"MM-dd HH:mm";
        }
        cell.timeLabel.text = [fotmatter stringFromDate:date];
        NSLog(@"%@", cell.timeLabel.text);
        NSLog(@"%@", self.LongCommentsModel.comments[indexPath.row].replyTo);
        if (!self.LongCommentsModel.comments[indexPath.row].replyTo) {
            
        } else {
            NSString* str = [NSString stringWithFormat:@"//%@:%@", self.LongCommentsModel.comments[indexPath.row].replyTo.author, self.LongCommentsModel.comments[indexPath.row].replyTo.content];
            cell.commentText.text = str;
            //cell.commentText.text = self.shortCommentsModel.comments[indexPath.row];
        }
    //    if (!self.shortCommentsModel.comments[indexPath.row].replyTo) {
    //        cell.commentText = nil;
    //        NSLog(@"11");
    //    }
        NSLog(@"点赞的一个个数%ld", self.LongCommentsModel.comments[indexPath.row].likes);
        if (self.LongCommentsModel.comments[indexPath.row].likes != 0) {
            [cell.likeButton setTitle:[NSString stringWithFormat:@"%ld", self.LongCommentsModel.comments[indexPath.row].likes] forState:UIControlStateNormal];
        } else {
            [cell.likeButton setTitle:@"  " forState:UIControlStateNormal];
        }
        //cell.commentText.text = @"2";
    }
    
    return cell;
}
//-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"响应一次");
//    if (!self.heightAry[indexPath.section][@(indexPath.row)] ) {
//        NSLog(@"这%ld行没有存储过的一个高度", indexPath.row);
//        id height = [NSNumber numberWithDouble:cell.frame.size.height];
//        self.heightAry[indexPath.section][@(indexPath.row)] = height;
//    } else {
//        NSLog(@"这%ld行曾今存储过的一个高度", indexPath.row);
//        NSLog(@"%@",  self.heightAry[indexPath.section][@(indexPath.row)]);
//        return;
//    }
//}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.LongCommentsModel.comments.count == 0) {
        return 1;
    } else {
        return 2;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 && self.LongCommentsModel.comments.count != 0) {
        return self.LongCommentsModel.comments.count;
    } else {
        return self.shortCommentsModel.comments.count;
    }
    //return  0;
}
-(NSMutableArray *)heightAry {
    if (_heightAry == nil) {
        _heightAry = [NSMutableArray array];
        [_heightAry addObject:[NSMutableDictionary dictionary]];
        [_heightAry addObject:[NSMutableDictionary dictionary]];
    }
    return _heightAry;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.heightAry[indexPath.section][@(indexPath.row)] ) {
        NSLog(@"%ld %ld 第几行第几列",indexPath.section, indexPath.row);
        return [self.heightAry[indexPath.section][@(indexPath.row)] doubleValue];
    } else {
        return UITableViewAutomaticDimension;
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.heightAry[indexPath.section][@(indexPath.row)] ) {
        NSLog(@"这%ld行没有存储过的一个高度", indexPath.row);
        id height = [NSNumber numberWithDouble:cell.frame.size.height];
        self.heightAry[indexPath.section][@(indexPath.row)] = height;
    } else {
        NSLog(@"这%ld行曾今存储过的一个高度", indexPath.row);
        NSLog(@"%@",  self.heightAry[indexPath.section][@(indexPath.row)]);
        return;
    }
}
//-(void)tableRload {
//    [self.iView.tableView reloadData];
//}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0 && self.LongCommentsModel.comments.count != 0) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 0.01)];
        headerView.backgroundColor = [UIColor whiteColor]; // 设置背景色
        return headerView;
    } else {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 0.01)];
        headerView.backgroundColor = [UIColor whiteColor]; // 设置背景色
        return headerView;
    }
}
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0 && self.LongCommentsModel.comments.count != 0) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 0.01)];
        headerView.backgroundColor = [UIColor whiteColor]; // 设置背景色
//        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 180, 40)];
//        label.text = [NSString stringWithFormat:@"%ld条长评论", self.LongCommentsModel.comments.count];
//        [headerView addSubview:label];
        return headerView;
    } else {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 0.01)];
        headerView.backgroundColor = [UIColor whiteColor]; // 设置背景色
//        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 180, 40)];
//        label.text = [NSString stringWithFormat:@"%ld条短评论", self.shortCommentsModel.comments.count];
//        [headerView addSubview:label];
        return headerView;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    if ([[URL scheme] isEqualToString:@"didOpenClose"]) {
        //点击了“展开”或”收起“，通过代理或者block回调，让持有tableView的控制器去刷新单行Cell
       // NSLog(@"%@", [textView.superview.superview class]);
        CommentsTableViewCell* cell = (CommentsTableViewCell*)textView.superview.superview;
        NSIndexPath* indexpath = [self.iView.tableView indexPathForCell:cell];
        self.shortCommentsModel.comments[indexpath.row].isOpen = !self.shortCommentsModel.comments[indexpath.row].isOpen;
        NSLog(@"之前的一个个高度：%@", self.heightAry[indexpath.section][@(indexpath.row)]);
        [self.heightAry[indexpath.section] removeObjectForKey:@(indexpath.row)];
        
        NSLog(@"删除高度数组%@", self.heightAry[indexpath.section][@(indexpath.row)]);
        
            [self.iView.tableView beginUpdates];

            [self.iView.tableView reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
            [self.iView.tableView endUpdates];
            NSLog(@"响应事件");
        
        return NO;
    }
    return YES;
}

- (void)addTitleButton:(NSString*) suffixStr andContent:(NSString*) contentStr andAtrutbeString:(NSMutableAttributedString*) attStr{
    NSLog(@"111");
    if(suffixStr){
       // NSLog(@"响应事件");
        NSLog(@"添加响应事件：%@， %@, %@", suffixStr, attStr.string, contentStr);
            NSRange range3 = [contentStr rangeOfString:suffixStr];
        NSLog(@"%ld %ld", range3.location, range3.length);
        NSLog(@"%@", [contentStr substringWithRange:range3]);
        [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:[contentStr rangeOfString:contentStr]];
        [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:range3];//[UIColor colorWithHexString:@"#000000"]
        NSString *valueString3 = [[NSString stringWithFormat:@"didOpenClose://%@", suffixStr] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        //NSLog(@"%@", valueString3);
        [attStr addAttribute:NSLinkAttributeName value:valueString3 range:range3];
    }
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

//
//  ViewController.m
//  通讯录过滤加排序
//
//  Created by monster on 16/5/17.
//  Copyright © 2016年 Monster. All rights reserved.
//

#import "ViewController.h"
#import "PersonModel.h"
#import "ChineseString.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

#define HANZI_START 19968
#define HANZI_COUNT 20902

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 通讯录表 */
@property (nonatomic, strong) UITableView *tableView;

/** 初始化数据源 */
@property (nonatomic, strong) NSMutableArray *firstDataArray;

/** 过滤之后的数据源 */
@property (nonatomic, strong) NSMutableArray *filterDataArray;

/** 索引数组 */
@property (nonatomic, strong) NSMutableArray *indexArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //初始化界面
    [self loadUI];
    //初始化数据源
    [self initData];
}

//初始化界面
- (void)loadUI
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

//初始化数据源
- (void)initData
{
    self.firstDataArray = [[NSMutableArray alloc] init];
    PersonModel * p1 = [[PersonModel alloc] init];
    p1.name = @"毛敏";
    [self.firstDataArray addObject:p1];
    PersonModel * p2 = [[PersonModel alloc] init];
    p2.name = @"赵晓倩";
    [self.firstDataArray addObject:p2];
    PersonModel * p3 = [[PersonModel alloc] init];
    p3.name = @"史荒原";
    [self.firstDataArray addObject:p3];
    PersonModel * p4 = [[PersonModel alloc] init];
    p4.name = @"何立春";
    [self.firstDataArray addObject:p4];
    PersonModel * p5 = [[PersonModel alloc] init];
    p5.name = @"何必生";
    [self.firstDataArray addObject:p5];
    PersonModel * p6 = [[PersonModel alloc] init];
    p6.name = @"赵大傻";
    [self.firstDataArray addObject:p6];
    PersonModel * p7 = [[PersonModel alloc] init];
    p7.name = @"刘乔";
    [self.firstDataArray addObject:p7];
    PersonModel * p8 = [[PersonModel alloc] init];
    p8.name = @"刘帝";
    [self.firstDataArray addObject:p8];
    PersonModel * p9 = [[PersonModel alloc] init];
    p9.name = @"王二荣";
    [self.firstDataArray addObject:p9];
    PersonModel * p10 = [[PersonModel alloc] init];
    p10.name = @"何处";
    [self.firstDataArray addObject:p10];
    PersonModel * p11 = [[PersonModel alloc] init];
    p11.name = @"monster";
    [self.firstDataArray addObject:p11];
    PersonModel * p12 = [[PersonModel alloc] init];
    p12.name = @"杨明";
    [self.firstDataArray addObject:p12];
    PersonModel * p13 = [[PersonModel alloc] init];
    p13.name = @"Yang";
    [self.firstDataArray addObject:p13];
    PersonModel * p14 = [[PersonModel alloc] init];
    p14.name = @"ao";
    [self.firstDataArray addObject:p14];
    PersonModel * p15 = [[PersonModel alloc] init];
    p15.name = @"bi";
    [self.firstDataArray addObject:p15];
    PersonModel * p16 = [[PersonModel alloc] init];
    p16.name = @"dd";
    [self.firstDataArray addObject:p16];
    PersonModel * p17 = [[PersonModel alloc] init];
    p17.name = @"hhaha";
    [self.firstDataArray addObject:p17];
    PersonModel * p18 = [[PersonModel alloc] init];
    p18.name = @"100";
    [self.firstDataArray addObject:p18];
    PersonModel * p19 = [[PersonModel alloc] init];
    p19.name = @"*hao";
    [self.firstDataArray addObject:p19];
    PersonModel * p20 = [[PersonModel alloc] init];
    p20.name = @"曾大帅";
    [self.firstDataArray addObject:p20];
    
//    self.firstDataArray = [NSMutableArray arrayWithArray:@[@"毛敏",@"赵晓倩",@"史荒原",@"何立春",@"何必生",@"赵大傻",@"刘乔",@"刘帝",@"王二荣",@"何处",@"monster",@"杨明",@"Yang",@"ao",@"bi",@"dd",@"hhaha"]];
//    self.indexArray = [[NSMutableArray alloc] init];
//    self.filterDataArray = [[NSMutableArray alloc] init];
    self.indexArray = [ChineseString indexArrayFilterWithOriginalArray:self.firstDataArray];
    self.filterDataArray = [ChineseString sortArrayFilterWithOriginalArray:self.firstDataArray];
}


#pragma mark - TableViewDelegate and TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.indexArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.filterDataArray objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mycell"];
    }
    PersonModel *mo = self.filterDataArray[indexPath.section][indexPath.row];
    cell.textLabel.text = mo.name;
    return cell;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.indexArray;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return index;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    header.backgroundColor = [UIColor grayColor];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 22)];
    lab.font = [UIFont systemFontOfSize:16];
    lab.textColor = [UIColor redColor];
    lab.text = self.indexArray[section];
    [lab sizeToFit];
    [header addSubview:lab];
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonModel *mo = self.filterDataArray[indexPath.section][indexPath.row];
    NSLog(@"---->%@",mo.name);
    UIAlertController * alertCtl = [UIAlertController alertControllerWithTitle:@"" message:mo.name preferredStyle:UIAlertControllerStyleAlert];
    NSLog(@"%@",alertCtl);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

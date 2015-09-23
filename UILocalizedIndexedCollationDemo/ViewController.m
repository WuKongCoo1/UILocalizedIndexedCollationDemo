//
//  ViewController.m
//  UILocalizedIndexedCollationDemo
//
//  Created by 吴珂 on 15/9/22.
//  Copyright © 2015年 MyCompany. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (copy, nonatomic) NSArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *testArr = @[@"悟空",@"沙僧",@"八戒", @"吴进", @"悟能", @"唐僧", @"诸葛亮", @"赵子龙",@"air", @"Asia", @"crash", @"basic", @"阿里郎"];
    
    NSMutableArray *personArr = [NSMutableArray arrayWithCapacity:testArr.count];
    for (NSString *str in testArr) {
        Person *person = [[Person alloc] initWithName:str];
        [personArr addObject:person];
    }
    
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    NSLog(@"%@", collation.sectionTitles);
    
    //1.获取获取section标题
    NSArray *titles = collation.sectionTitles;
    
    //2.构建每个section数组
    NSMutableArray *secionArray = [NSMutableArray arrayWithCapacity:titles.count];
    for (int i = 0; i < titles.count; i++) {
        NSMutableArray *subArr = [NSMutableArray array];
        [secionArray addObject:subArr];
    }
    
    //3.排序
    //3.1 按照将需要排序的对象放入到对应分区数组
    for (Person *person in personArr) {
        NSInteger section = [collation sectionForObject:person collationStringSelector:@selector(name)];
        NSMutableArray *subArr = secionArray[section];
        
        [subArr addObject:person];
    }
    
    //3.2 分别对分区进行排序
    for (NSMutableArray *subArr in secionArray) {
        NSArray *sortArr = [collation sortedArrayFromArray:subArr collationStringSelector:@selector(name)];
        [subArr removeAllObjects];
        [subArr addObjectsFromArray:sortArr];
    }

    //修改数据源
    self.dataSource = [NSArray arrayWithArray:secionArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UITableViewDataSource

#pragma mark SectionTitles
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
}


#pragma mark - Cell
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [UILocalizedIndexedCollation currentCollation].sectionTitles.count;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.text = [[self.dataSource[indexPath.section] objectAtIndex:indexPath.row] name];
}


@end

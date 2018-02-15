//
//  FirstViewController.m
//  CXA
//
//  Created by Chanikya on 10/20/16.
//  Copyright © 2016 IBM. All rights reserved.
//

#import "HomeViewController.h"
#import "ItemTableViewCell.h"
#import "BannerImageTableViewCell.h"
#import "ItemDetailViewController.h"
#import "CategoryTableViewCell.h"
#import "ItemListViewController.h"
#import "CXAEnvViewController.h"
#import "TopCategories.h"
#import "Category.h"

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView  *tableView;
@property (nonatomic, strong) NSArray             *data;
@property (nonatomic, strong) NSMutableArray      *resultsArray;
@property (nonatomic, strong) NSArray             *recentItemsArray;
@property (nonatomic, strong) NSArray             *topCategoriesArray;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Home";
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    
    [AppManager sharedInstance].currentTabController = self.tabBarController;
    
    self.data = [NSArray arrayWithObjects:@{@"title" : @"Tablets", @"image" : @"multimediaTablet_thumbnail", @"categoryId" : @"1"}, @{@"title" : @"Furniture", @"image" : @"styleHomeUltraCozy_thumbnail", @"categoryId" : @"2"}, @{@"title" : @"Laptops", @"image" : @"officeLaptop_thumbnail", @"categoryId" : @"3"}, @{@"title" : @"Dairy", @"image" : @"blueCheese_thumbnail", @"categoryId" : @"4"}, @{@"title" : @"Magazines", @"image" : @"sportsfit_thumbnail", @"categoryId" : @"5"}, nil];
    
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"categoryId = %d", 1];
    RLMResults<Item *> *result1 = [Item objectsWithPredicate:pred1];
    self.resultsArray = [NSMutableArray array];
    [self.resultsArray addObject:result1];
    
    self.recentItemsArray = [NSArray array];
    self.recentItemsArray = [[AppManager sharedInstance] getMostRecent];
    
    [self retrieveTopCategories];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadTable)
                                                 name:@"RecentListUpdated"
                                               object:nil];
}

- (void) viewWillAppear:(BOOL)animated {
    self.recentItemsArray = [[AppManager sharedInstance] getMostRecent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) reloadTable {
    self.recentItemsArray = [[AppManager sharedInstance] getMostRecent];
    [self.tableView reloadData];
}

- (void) retrieveTopCategories {
    NSMutableArray *tempArr = [NSMutableArray array];
    RLMResults<Category *> *result = [Category allObjects];   // Retrieving all categories
    for(Category *catog in result)
    {
        [tempArr addObject:catog];
    }
    
    // Sorting Categories based on visited count
    NSArray *sortedCategories = [tempArr sortedArrayUsingComparator:
                            ^NSComparisonResult(Category *obj1, Category *obj2) {
                                if (obj1.visitedCount < obj2.visitedCount) {
                                    return NSOrderedDescending;
                                } else if (obj1.visitedCount > obj2.visitedCount) {
                                    return NSOrderedAscending;
                                } else {
                                    return NSOrderedSame;
                                }
                            }];
    RLMArray<Category *><Category> *topCatArr = (RLMArray <Category> *) [[RLMArray alloc] initWithObjectClassName:@"Category"];
    int isThreeItemsSaved = 0;
    for (int k=0; k< sortedCategories.count; k++) {
        isThreeItemsSaved = isThreeItemsSaved + 1;
        if (isThreeItemsSaved > 3) {
            break;
        }
        [topCatArr addObject:sortedCategories[k]];
    }
    self.topCategoriesArray = [NSArray arrayWithObjects:sortedCategories[0], sortedCategories[1], sortedCategories[2], nil];
    TopCategories *topCats = [[TopCategories alloc] init];
    topCats.categories = topCatArr;
    topCats.categoriesId = @"1";
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addOrUpdateObject:topCats];
    [realm commitWriteTransaction];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 1)
        return 50.0;
    return 50.0; //30.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0.0;
    }
    return 0.0; //38.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return 120.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.recentItemsArray.count > 0) {
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0) {
        return 3;
    }
    else if(section == 1) {
        return self.recentItemsArray.count;
    }
    return 3;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 50)];
    view.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0]; //[UIColor lightGrayColor];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(16, 0, self.tableView.frame.size.width - 32, 1)];
    topView.backgroundColor = [UIColor orangeColor];
    //[view addSubview:topView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 4, 250, 42)];
    [label setFont:[UIFont boldSystemFontOfSize:18]];   //systemFontOfSize:36]];
    //label.textColor = [UIColor colorWithRed:0.49 green:0.78 blue:1.00 alpha:1.0];
    
    if (section == 0) {
        label.text = @"Shop Top Categories";
    }
    else if (section == 1) {
        label.text = @"Recently Viewed";
    }
    [view addSubview:label];
    
    return view;
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 30)];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(16, 0, self.tableView.frame.size.width - 32, 1)];
    topView.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:topView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 4, 80, 30)];
    label.text = @"See more";
    [view addSubview:label];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width - 40, 4, 30, 30)];
    img.image = [UIImage imageNamed:@"rightArrow"];
    [view addSubview:img];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 35, self.tableView.frame.size.width, 3)];
    bottomView.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:bottomView];
    
    return view;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
//        BannerImageTableViewCell *cell = (BannerImageTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"cell"];
//        cell.imageView.image = [UIImage imageNamed:@"supremeGaintSofa_banner"];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
        
//        Item *item = [self.recentItemsArray objectAtIndex:indexPath.row];
//        ItemTableViewCell *cell = (ItemTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"itemCell"];
//        cell.titleLabel.text = item.title;
//        cell.priceLabel.text = [NSString stringWithFormat:@"$%.02f", item.price];
//        UIImage *img = [[AppManager sharedInstance] scaleImage:[UIImage imageNamed:item.thumbnail]];
//        cell.imageView.image = img; //[UIImage imageNamed:item.thumbnail];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        [cell setNeedsDisplay];
//        [cell layoutIfNeeded];
//        return cell;
        
        Item *item = [self.recentItemsArray objectAtIndex:indexPath.row];
        CategoryTableViewCell *cell = (CategoryTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"categoryCell"];
        cell.icon.image = [UIImage imageNamed:item.thumbnail];    //self.data[indexPath.row][@"image"]];
        cell.titleLabel.text = item.title; //self.data[indexPath.row][@"title"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    if (indexPath.section == 2) {
        Item *item = [self.resultsArray objectAtIndex:0][indexPath.row];
        ItemTableViewCell *cell = (ItemTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"itemCell"];
        cell.titleLabel.text = item.title;
        cell.priceLabel.text = [NSString stringWithFormat:@"$%.02f", item.price];
        UIImage *img = [[AppManager sharedInstance] scaleImage:[UIImage imageNamed:item.thumbnail]];
        cell.imageView.image = img;  //[UIImage imageNamed:item.thumbnail];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell setNeedsDisplay];
        [cell layoutIfNeeded];
        return cell;
    }
    
    if (indexPath.section == 0) {
        CategoryTableViewCell *cell = (CategoryTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"categoryCell"];
        cell.icon.image = [UIImage imageNamed:((Category *)self.topCategoriesArray[indexPath.row]).imageThumbnail];    //self.data[indexPath.row][@"image"]];
        cell.titleLabel.text = ((Category *)self.topCategoriesArray[indexPath.row]).categoryTitle; //self.data[indexPath.row][@"title"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        [self performSegueWithIdentifier:@"itemListSegue" sender:self];
    }
    else {
        [self performSegueWithIdentifier:@"itemSegue" sender:self];
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *selectedIndex = [self.tableView indexPathForSelectedRow];
    ItemDetailViewController *destVC = (ItemDetailViewController *) segue.destinationViewController;
    
    if (selectedIndex.section == 1) {
        destVC.dataItem = self.recentItemsArray[selectedIndex.row];
    }
    
    else if (selectedIndex.section == 2) {
        Item *item = [self.resultsArray objectAtIndex:0][selectedIndex.row];
        destVC.dataItem = item;
    }
    else {
        ItemListViewController *destVC = (ItemListViewController *) segue.destinationViewController;
        destVC.categoryId = ((Category *)self.topCategoriesArray[selectedIndex.row]).categoryId; //[self.data[selectedIndex.row][@"categoryId"] integerValue];
        destVC.categoryTitle = ((Category *)self.topCategoriesArray[selectedIndex.row]).categoryTitle; //self.data[selectedIndex.row][@"title"];
        destVC.category = self.topCategoriesArray[selectedIndex.row];
    }
}

@end

//
//  UserAccountViewController.m
//  CXA
//
//  Created by Chanikya on 11/10/16.
//  Copyright © 2016 IBM. All rights reserved.
//

#import "UserAccountViewController.h"
#import "UserAccountTableViewCell.h"
#import "Order.h"
#import "OrderItem.h"
#import "AccountViewController.h"

@interface UserAccountViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (atomic, strong)  NSMutableArray *orderItems;

@end

@implementation UserAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) viewWillAppear:(BOOL)animated
{
    [self retrieveOrderItems];
}

- (void) retrieveOrderItems {
    NSPredicate *pred;
    
    if ([AppManager sharedInstance].userId) {
        pred = [NSPredicate predicateWithFormat:@"userId = %@", [AppManager sharedInstance].userId];
    }
    else {
        pred = [NSPredicate predicateWithFormat:@"userId = %@",@"AnonymousUser"];

    }
    
    // All orders placed on this device are displayed rather than filtering based on userid or anonymous user
    RLMResults<Order *> *results = [Order allObjects];  //[Order objectsWithPredicate:pred];
    
    self.orderItems = [NSMutableArray array];
    
    for (Order *order in results) {
        for (OrderItem *orderItem in order.items) {
            [self.orderItems addObject:orderItem];
        }
    }
    [self.tableView reloadData];
    
    /*commenting this out to avoid double screen logging
    if (![AppManager sharedInstance].skipAccountVCLogging)
    {
        [[TLFCustomEvent sharedInstance] logScreenLayoutWithViewController:self andDelay:0.5f]; // Manually logging the screen
    }
    */
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.orderItems.count > 0)
    {
        return 0.0;
    }
    return 30.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
//    if ([AppManager sharedInstance].userId)
//    {
//        return 0.0;
//    }
    return 0.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return 100.0;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 30)];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(16, 0, self.tableView.frame.size.width - 50, 30);
    label.text = @"No recent orders";
    [view addSubview:label];
    return view;
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 50)];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(gotoLoginScreen) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Return to Login" forState:UIControlStateNormal];
    button.frame = CGRectMake(16.0, 2.5, view.frame.size.width - 32, 45.0);
    button.backgroundColor = [UIColor lightGrayColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [view addSubview:button];
    
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.orderItems.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    OrderItem *orderItem = self.orderItems[indexPath.row];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"itemId = %d", orderItem.itemId];
    RLMResults<Item *> *result = [Item objectsWithPredicate:pred];
    Item  *item = result[0];
    
    NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
    [dateformate setDateFormat:@"MM-dd-yyyy HH:mm:ss"]; // Date formater
    NSString *date = [dateformate stringFromDate:orderItem.orderDate];
    
    UserAccountTableViewCell *cell = (UserAccountTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.icon.image = [UIImage imageNamed:item.image];
    cell.itemTitle.text = item.title;
    cell.orderDate.text = [NSString stringWithFormat:@"Ordered on %@", date];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void) gotoLoginScreen
{
    [[NSUserDefaults standardUserDefaults] setObject:@(NO) forKey:@"isLoginSkipped"];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:[NSBundle mainBundle]];
    
    UINavigationController *destVC = [storyboard instantiateViewControllerWithIdentifier:@"accountVC"];
    
    [self presentViewController:destVC animated:NO completion:nil];
}


@end

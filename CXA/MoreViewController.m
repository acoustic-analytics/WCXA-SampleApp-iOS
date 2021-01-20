//
//  MoreViewController.m
//  CXA
//
//  Created by Chanikya on 1/26/17.
//  Copyright (C) 2017 Acoustic, L.P. All rights reserved.
//
//  NOTICE: This file contains material that is confidential and proprietary to
//  Acoustic, L.P. and/or other developers. No license is granted under any intellectual or
//  industrial property rights of Acoustic, L.P. except as may be provided in an agreement with
//  Acoustic, L.P. Any unauthorized copying or distribution of content from this file is
//  prohibited.
//

#import "MoreViewController.h"
#import <SafariServices/SafariServices.h>
#import "PreHomeViewController.h"

@interface MoreViewController ()
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArray = [NSArray arrayWithObjects:@"View Orders", @"Update CXA Environment Details", @"View Session Replay", @"About IBM WCXA Mobile app", @"Support", @"Exit Demo", @"Settings", nil];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    self.navigationItem.title = @"IBM WCXA Mobile";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray count];
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 30)];
    view.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 4, 250, 22)];
    label.text = @"Categories";
    [view addSubview:label];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)anIndexPath {
    
    UITableViewCell * cell = [aTableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    cell.textLabel.text = self.dataArray[anIndexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:@"ordersSegue" sender:self];
    }
    else if(indexPath.row == 1) {
        [self performSegueWithIdentifier:@"envSegue" sender:self];
    }
    else if(indexPath.row == 2) {
        
        if ([AppManager sharedInstance].openConfigSession) {
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"Enter OrgKey to show the replay"
                                                  message:@"You can find OrgKey in company settings of your Tealeaf Portal"
                                                  preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
             {
                 textField.placeholder = @"Enter OrgKey";
                 [textField addTarget:self
                               action:@selector(alertTextFieldDidChange:)
                     forControlEvents:UIControlEventEditingChanged];
             }];
            UIAlertAction *okAction = [UIAlertAction
                                       actionWithTitle:@"OK"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction *action)
                                       {
                                           UITextField *orgKey = alertController.textFields.firstObject;
                                           NSLog(@"OrgKey");
                                           SFSafariViewController *svc = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.tealeaf.ibmcloud.com/v1/replay?sid=%@&orgKey=%@&redirect=true", [[TLFApplicationHelper sharedInstance] currentSessionId], orgKey.text]]];
                                           [self presentViewController:svc animated:YES completion:nil];
                                       }];
            okAction.enabled = NO;
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else {
            SFSafariViewController *svc = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.tealeaf.ibmcloud.com/v1/replay?sid=%@&orgKey=104aurora-com&redirect=true", [[TLFApplicationHelper sharedInstance] currentSessionId]]]];
            [self presentViewController:svc animated:YES completion:nil];
        }
    }
    else if(indexPath.row == 3) {
        [self performSegueWithIdentifier:@"aboutSegue" sender:self];
    }
    else if(indexPath.row == 4){
        [self performSegueWithIdentifier:@"supportSegue" sender:self];
    }
    else if(indexPath.row == 6){
        [self performSegueWithIdentifier:@"endUserConsentSegue" sender:self];
    }
    else {
        [AppManager sharedInstance].openConfigSession = NO;
        [[TLFApplicationHelper sharedInstance] disableTealeafFramework];
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

- (void)alertTextFieldDidChange:(UITextField *)sender
{
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    if (alertController)
    {
        UITextField *orgTextField = alertController.textFields.firstObject;
        UIAlertAction *okAction = alertController.actions.lastObject;
        okAction.enabled = orgTextField.text.length > 0;
    }
}
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
}

@end

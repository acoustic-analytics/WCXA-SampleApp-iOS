//
//  CartViewController.m
//  CXA
//
//  Created by Chanikya on 10/20/16.
//  Copyright © 2016 IBM. All rights reserved.
//

#import "CartViewController.h"
#import "CartSummaryTableViewCell.h"
#import "CartItemTableViewCell.h"
#import "CartCheckOutTableViewCell.h"
#import "CartItem.h"
#import "ItemDetailViewController.h"

@interface CartViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    int totalRowCout;
}
@property (nonatomic, strong) NSMutableArray *cartItems;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation CartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Cart";
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"Checkout" style:UIBarButtonItemStylePlain target:self action:@selector(checkOut)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    self.cartItems = [NSMutableArray array];
    [self retrieveCartItems];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(retrieveCartItems)
                                                 name:@"CartItemUpdated"
                                               object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) retrieveCartItems {
    if ([AppManager sharedInstance].userId) {
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"userId = %@", [AppManager sharedInstance].userId];
        RLMResults<CartItem *> *results = [CartItem objectsWithPredicate:pred];
        
        self.cartItems = [NSMutableArray array];
        
        for (CartItem *cartItem in results) {
            [self.cartItems addObject:cartItem];
        }
    }
    
    else {
        self.cartItems = [NSMutableArray array];
        
        for (CartItem *card in [AppManager sharedInstance].anonymousCartItems) {
            [self.cartItems addObject:card];
        }
    }
    [self.tableView reloadData];
}

- (void) updateItem:(Item *) item withQuantity:(NSInteger) value
{
    [[AppManager sharedInstance] updateCartItem:item withQuantity:value];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (self.cartItems.count > 0) {
        if (indexPath.row == 0) {
            return 132.0;
        }
        else if (indexPath.row == 1)  //(totalRowCout - 1))
        {
            return 60;
        }
        else {
            return 150.0;
        }
    }
    else {
        if (indexPath.row == 0) {
            return 132.0;
        }
        else {
            return 60.0;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.cartItems.count > 0) {
        totalRowCout = 2 + (int) self.cartItems.count;
        return 2 + self.cartItems.count;
    }
    totalRowCout = 1;
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //int totalRows = (int) [tableView numberOfRowsInSection:indexPath.section];
    if ([tableView numberOfRowsInSection:indexPath.section] > 2) {
        if (indexPath.row == 0) {
            
            double totalPrice = 0.0;
            
            for (CartItem *ct in self.cartItems) {
                totalPrice = totalPrice + ct.price * ct.quantity;
            }
            
            double tax = totalPrice * 0.10;
            double total = totalPrice + tax;
            
            CartSummaryTableViewCell *cell = (CartSummaryTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"itemSummaryCell"];
            cell.subTotalLabel.text = [NSString stringWithFormat:@"$%.02f", totalPrice];
            cell.shippingLabel.text = @"$0.00";
            cell.taxLabel.text = [NSString stringWithFormat:@"$%.02f", tax];
            cell.cartTotalLabel.text = [NSString stringWithFormat:@"$%.02f", total];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else if (indexPath.row == 1) {
            CartCheckOutTableViewCell *cell = (CartCheckOutTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"checkOutCell"];
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else {
                CartItemTableViewCell *cell = (CartItemTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"itemCell"];
                CartItem *cardItem = self.cartItems[indexPath.row -2];
                NSPredicate *pred = [NSPredicate predicateWithFormat:@"itemId = %d", cardItem.itemId];
                RLMResults<Item *> *result = [Item objectsWithPredicate:pred];
                Item  *item = result[0];
                
                cell.itemTitleLabel.text = item.title;
                cell.itemPriceLabel.text = [NSString stringWithFormat:@"$%.02f", item.price];
                cell.itemIcon.image = [UIImage imageNamed:item.image];
                cell.itemOwnerLabel.text = item.owner;
                cell.itemQuantityLabel.text = [NSString stringWithFormat:@"%ld", cardItem.quantity];
                cell.dataItem = item;
                cell.delegate = self;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 1)];
                topView.backgroundColor = [UIColor lightGrayColor];
                [cell.contentView addSubview:topView];
                
                UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, cell.contentView.frame.size.height - 1, tableView.frame.size.width, 1)];
                bottomView.backgroundColor = [UIColor lightGrayColor];
                [cell.contentView addSubview:bottomView];
            
                //[cell layoutIfNeeded];
                [cell setNeedsLayout];
                return cell;
            }
    }
    else {
        CartSummaryTableViewCell *cell = (CartSummaryTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"itemSummaryCell"];
        cell.subTotalLabel.text = @"$0.00";
        cell.shippingLabel.text = @"$0.00";
        cell.taxLabel.text = @"$0.00";
        cell.cartTotalLabel.text = @"$0.00";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void) checkOut
{
    if (self.cartItems.count > 0) {
         [self performSegueWithIdentifier:@"paymentSegue" sender:self];
    }
    else {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Empty Cart"
                                      message:@"Please add items to cart to proceed"
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                             }];
        
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void) deleteItemFromCart:(Item *) item
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    if ([AppManager sharedInstance].userId) {
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"userId = %@ AND itemId = %ld", [AppManager sharedInstance].userId, item.itemId];
        RLMResults<CartItem *> *results = [CartItem objectsWithPredicate:pred];
        for (CartItem *obj in results) {
            [realm transactionWithBlock:^{
                [realm deleteObject:obj];       // Deletes CartItem from Realm as Order is placed
                [self retrieveCartItems];
            }];
        }
    }
    else {
        NSMutableArray *carItems = [AppManager sharedInstance].anonymousCartItems;
//        for (CartItem *card in [AppManager sharedInstance].anonymousCartItems) {
//            if (card.itemId == item.itemId) {
//                [[AppManager sharedInstance].anonymousCartItems removeObject:card];
//            }
//        }
        for (int i = 0; i < carItems.count; i++) {
            if (((CartItem *)carItems[i]).itemId == item.itemId) {
                [[AppManager sharedInstance].anonymousCartItems removeObjectAtIndex:i];
            }
        }
        [self retrieveCartItems];
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"itemDetailPeek"]) {
        UITableViewCell *cell = sender;
        NSIndexPath *selectedIndex =  [self.tableView indexPathForCell:cell]; //[self.tableView indexPathForSelectedRow];
        ItemDetailViewController *destVC = (ItemDetailViewController *) segue.destinationViewController;
        
        CartItem *cardItem = self.cartItems[selectedIndex.row -2];
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"itemId = %d", cardItem.itemId];
        RLMResults<Item *> *result = [Item objectsWithPredicate:pred];
        Item  *item = result[0];
        
        destVC.dataItem = item;
    }
}

@end

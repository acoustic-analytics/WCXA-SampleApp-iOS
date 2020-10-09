//
//  PaymentViewController.m
//  CXA
//
//  Created by Chanikya on 11/8/16.
//  Copyright © 2016 IBM. All rights reserved.
//

#define CVV_MAX_LENGTH 4
#define CARD_NUMBER_MAX_LENGTH 16
#define CARD_EXP_MONTH_MAX_LENGTH 2
#define CARD_EXP_YEAR_MAX_LENGTH 4

#import "PaymentViewController.h"
#import "CartItem.h"
#import "Order.h"
#import "OrderItem.h"

@interface PaymentViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UISwipeGestureRecognizer *missingGestureTestPrefillButtonSwipeGesture;
@end
@interface UIColor(HexString)
+ (UIColor *) colorWithHexString: (NSString *) hexString;
+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length;
@end
@implementation UIColor(HexString)

+ (UIColor *) colorWithHexString: (NSString *) hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            [NSException raise:@"Invalid color value" format: @"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

@end
@implementation PaymentViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Place Your Order";
    
    self.purchaseBtnOutlet.layer.cornerRadius = 5;
    self.purchaseBtnOutlet.layer.shadowOffset = CGSizeMake(3, 3);
    self.prefillBtnOutlet.layer.cornerRadius = 5;
    self.prefillBtnOutlet.layer.shadowOffset = CGSizeMake(3, 3);
    self.prefillBtnOutlet.backgroundColor = [UIColor colorWithHexString:@"#c1c1c1"];
    
    UITapGestureRecognizer *tapScroll = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    tapScroll.cancelsTouchesInView = NO;
    [self.scrollView addGestureRecognizer:tapScroll];
    
    self.zipCodeTextField.delegate = self;
    self.stateTextField.delegate = self;
    self.cityTextField.delegate = self;
    self.cvvTextField.delegate = self;
    self.cardNumber.delegate = self;
    self.expYearTextField.delegate = self;
    self.expMonth.delegate = self;
    
    /*Missing gesture delegate*/
    
    self.missingGestureTestPrefillButtonSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleMissingGestureSingleSwipeGesture:)];
    self.missingGestureTestPrefillButtonSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.prefillBtnOutlet addGestureRecognizer:self.missingGestureTestPrefillButtonSwipeGesture];
    self.missingGestureTestPrefillButtonSwipeGesture.delegate = self;

    /*End Of Missing gesture delegate*/
}
-(void)handleMissingGestureSingleSwipeGesture:(UITapGestureRecognizer *)tapGestureRecognizer
{
}
//Commentout this code .. This will make GesturesViewController class to have a gesture recognizer delegate; but Not have shouldRecognizeSimultaneouslyWithGestureRecognizer method present. When Tealeaf SDK notices this; it will inject this method for the app, like its in the documentation.
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;
//{
//   return YES;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) viewWillAppear:(BOOL)animated {
    [self registerForKeyboardNotifications];
}

- (void) viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) dismissKeyboard {
    [self.view endEditing:YES];
}

- (IBAction)purchaseItem:(id)sender {
    
    if ((self.cardholderName.text.length == 0) || (self.cardNumber.text.length == 0) || (self.cvvTextField.text.length == 0) || (self.expMonth.text.length == 0) || (self.expYearTextField.text.length == 0) || (self.address1TextField.text.length == 0) || (self.stateTextField.text.length == 0) || (self.zipCodeTextField.text.length == 0)) {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Missing required fields"
                                      message:@"Please enter values for all required fields"
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
    
//    else if (self.cardNumber.text.length < 16)
//    {
//        self.cardNumber.layer.borderColor = [UIColor redColor].CGColor;
//    }
    
    else
    {
        
        if ([AppManager sharedInstance].userId) {
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"userId = %@", [AppManager sharedInstance].userId];
            RLMResults<CartItem *> *results = [CartItem objectsWithPredicate:pred];
            
            Order *order = [[Order alloc] init];
            order.orderId = [[NSUUID UUID] UUIDString];
            order.userId = [AppManager sharedInstance].userId;
            order.customerCity = self.cityTextField.text;
            order.customerState = self.stateTextField.text;
            order.customerZip = self.zipCodeTextField.text;
            
            RLMRealm *realm = [RLMRealm defaultRealm];
            
            NSInteger subTotal = 0.0;
            
            RLMArray<OrderItem *><OrderItem> *tempArr = (RLMArray <OrderItem> *) [[RLMArray alloc] initWithObjectClassName:@"OrderItem"];
            for (CartItem *obj in results) {
                OrderItem *ot = [[OrderItem alloc] init];
                ot.userId = order.userId;
                ot.quantity = obj.quantity;
                ot.itemId = obj.itemId;
                ot.orderDate = [NSDate date];
                ot.price = obj.price;
                [tempArr addObject:ot];
                
                subTotal = subTotal + obj.price;
                
                [realm transactionWithBlock:^{
                    [realm deleteObject:obj];       // Deletes CartItem from Realm as Order is placed
                }];
            }
            
            order.items = tempArr;
            order.subTotal = subTotal;
            
            [realm transactionWithBlock:^{
                 [realm addObject:order];
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"CartItemUpdated" object:self];
                 [self showConfirmationDialog];
            }];
        }
        
        else {
            Order *order = [[Order alloc] init];
            order.orderId = [[NSUUID UUID] UUIDString];
            order.customerCity = self.cityTextField.text;
            order.customerState = self.stateTextField.text;
            order.customerZip = self.zipCodeTextField.text;
            
            //NSDateFormatter *format = [[NSDateFormatter alloc] init];
            //[format setDateFormat:@"MMMM-dd-yyyy-HH:mm:ss z Z"];
            //NSDate *now = [NSDate date];
            //NSString *nsstr = [format stringFromDate:now];
            
            order.userId = @"AnonymousUser";
            NSInteger subTotal = 0.0;
            
            RLMArray<OrderItem *><OrderItem> *tempArr = (RLMArray <OrderItem> *) [[RLMArray alloc] initWithObjectClassName:@"OrderItem"];
            
            for (CartItem *card in [AppManager sharedInstance].anonymousCartItems) {
                OrderItem *ot = [[OrderItem alloc] init];
                ot.userId = @"AnonymousUser";
                ot.quantity = card.quantity;
                ot.itemId = card.itemId;
                ot.orderDate = [NSDate date];
                ot.price = card.price;
                [tempArr addObject:ot];
                
                subTotal = subTotal + card.price;
            }
            
            order.items = tempArr;
            order.subTotal = subTotal;
            
            RLMRealm *realm = [RLMRealm defaultRealm];
            [realm transactionWithBlock:^{
                [realm addObject:order];
                [AppManager sharedInstance].anonymousCartItems = [NSMutableArray array];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"CartItemUpdated" object:self];
                [self showConfirmationDialog];
                [[TLFCustomEvent sharedInstance] logFormCompletion:YES withValidData:YES];
            }];
        }
    }
}

- (void) showConfirmationDialog
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Test App"
                                  message:@"This is a sample app for generating session. Please goto portal to see the generated session"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    __weak PaymentViewController *weakSelf = self;
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                             //[AppManager sharedInstance].currentTabController.selectedIndex = 1;    // Switch to order history after purchase
                         }];
    
    [alert addAction:ok];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSCharacterSet *numbersOnly = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    NSCharacterSet *characterSetFromTextField = [NSCharacterSet characterSetWithCharactersInString:string];
    
    BOOL isNumsOnly = [numbersOnly isSupersetOfSet:characterSetFromTextField];
    
    BOOL isValidChars = YES;
    
    int maxLen = 0;
    if ([textField isEqual:self.cvvTextField]) {
        maxLen = CVV_MAX_LENGTH;
        isValidChars = isNumsOnly;
    }
    
    if ([textField isEqual:self.expMonth]) {
        maxLen = CARD_EXP_MONTH_MAX_LENGTH;
        isValidChars = isNumsOnly;
    }
    
    if ([textField isEqual:self.expYearTextField]) {
        maxLen = CARD_EXP_YEAR_MAX_LENGTH;
        isValidChars = isNumsOnly;
    }
    
    if ([textField isEqual:self.cardNumber]) {
        maxLen = CARD_NUMBER_MAX_LENGTH;
        isValidChars = isNumsOnly;
    }
    
    if ((maxLen > 0) && (textField.text.length >= maxLen) && (range.length == 0))
    {
        return NO; // return NO to not change text
    }
    else
    {
        return YES & isValidChars;
    }
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    self.scrollView.contentInset = UIEdgeInsetsMake(self.scrollView.contentInset.top, 0, 49.0, 0);
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(self.scrollView.contentInset.top, 0.0, self.scrollView.contentInset.bottom + kbSize.height + 20 - 49, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(self.scrollView.contentInset.top, 0.0, self.scrollView.contentInset.bottom - kbSize.height - 20 + 49, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (IBAction)prefillForm:(id)sender {
    self.cardholderName.text = @"Leo";
    self.cardNumber.text = @"1234567891234561";
    self.cvvTextField.text = @"123";
    self.expMonth.text = @"04";
    self.expYearTextField.text = @"2017";
    self.address1TextField.text = @"505 Howard St";
    self.address2TextField.text = @"Floor 6";
    self.cityTextField.text = @"San Francisco";
    self.stateTextField.text = @"CA";
    self.zipCodeTextField.text = @"95105";
    /*log layout after prefilling the form*/
    [[TLFCustomEvent sharedInstance] logScreenLayoutDynamicUpdateWithViewController:self andRelatedViews:nil];
}
- (IBAction)textFieldDidChange:(id)sender {
}
@end

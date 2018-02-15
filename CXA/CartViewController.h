//
//  CartViewController.h
//  CXA
//
//  Created by Chanikya on 10/20/16.
//  Copyright © 2016 IBM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartViewController : UIViewController

- (void) checkOut;
- (void) updateItem:(Item *) item withQuantity:(NSInteger) value;
- (void) deleteItemFromCart:(Item *) item;

@end

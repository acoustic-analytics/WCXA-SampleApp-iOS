//
//  PreHomeViewController.h
//  CXA
//
//  Created by Chanikya on 6/5/17.
//  Copyright © 2017 IBM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreHomeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *tryCXAOutlet;
@property (weak, nonatomic) IBOutlet UIButton *configBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *startBtnOutlet;
- (IBAction)startDefaultConfig:(id)sender;
- (IBAction)configureEnv:(id)sender;
- (IBAction)startNewSession:(id)sender;

@end

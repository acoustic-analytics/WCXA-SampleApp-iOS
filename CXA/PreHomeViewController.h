//
//  PreHomeViewController.h
//  CXA
//
//  Created by Chanikya on 6/5/17.
//  Copyright (C) 2017 Acoustic, L.P. All rights reserved.
//
//  NOTICE: This file contains material that is confidential and proprietary to
//  Acoustic, L.P. and/or other developers. No license is granted under any intellectual or
//  industrial property rights of Acoustic, L.P. except as may be provided in an agreement with
//  Acoustic, L.P. Any unauthorized copying or distribution of content from this file is
//  prohibited.
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

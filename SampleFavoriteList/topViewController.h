//
//  topViewController.h
//  SampleFavoriteList
//
//  Created by Eriko Ichinohe on 2014/11/12.
//  Copyright (c) 2014年 Eriko Ichinohe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface topViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *nomallistBtn;
@property (weak, nonatomic) IBOutlet UIButton *favlistBtn;

- (IBAction)tapNormal:(id)sender;
- (IBAction)tapFavorite:(id)sender;

@end

//
//  DetailViewController.h
//  SampleFavoriteList
//
//  Created by Eriko Ichinohe on 2014/11/12.
//  Copyright (c) 2014年 Eriko Ichinohe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
{
    NSMutableArray *_coffeeArray; //メンバ変数宣言
}

@property (nonatomic,assign) int select_num;

@property (weak, nonatomic) IBOutlet UILabel *coffeeTitle;

@property (weak, nonatomic) IBOutlet UITextView *descriptionText;

@property (weak, nonatomic) IBOutlet UIButton *favoriteBtn;

- (IBAction)addFavoriteList:(id)sender;

@end

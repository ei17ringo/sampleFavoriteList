//
//  ViewController.h
//  SampleFavoriteList
//
//  Created by Eriko Ichinohe on 2014/11/12.
//  Copyright (c) 2014年 Eriko Ichinohe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_coffeeArray; //メンバ変数宣言
    NSArray *_foodArray; //メンバ変数宣言
    
    NSArray *_useArray; //メンバ変数宣言
    
}


@property (weak, nonatomic) IBOutlet UITableView *coffeeTableView;
@property (nonatomic,assign) int select_num;


@end


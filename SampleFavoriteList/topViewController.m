//
//  topViewController.m
//  SampleFavoriteList
//
//  Created by Eriko Ichinohe on 2014/11/12.
//  Copyright (c) 2014年 Eriko Ichinohe. All rights reserved.
//

#import "topViewController.h"
#import "ViewController.h"
#import "favoriteViewController.h"

@interface topViewController ()

@end

@implementation topViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)tapNormal:(id)sender {
    ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    
    
    //ナビゲーションコントローラーの機能で画面遷移
    [[self navigationController] pushViewController:vc animated:YES];
}

- (IBAction)tapFavorite:(id)sender {
    favoriteViewController *fvc = [self.storyboard instantiateViewControllerWithIdentifier:@"favoriteViewController"];
    
    
    //ナビゲーションコントローラーの機能で画面遷移
    [[self navigationController] pushViewController:fvc animated:YES];

}
@end

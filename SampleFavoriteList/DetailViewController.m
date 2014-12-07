//
//  DetailViewController.m
//  SampleFavoriteList
//
//  Created by Eriko Ichinohe on 2014/11/12.
//  Copyright (c) 2014年 Eriko Ichinohe. All rights reserved.
//

#import "DetailViewController.h"

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //UserDefaultからデータを取り出す
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray *coffeeTmp;
    NSArray *foodTmp;
    
    //保存されたデータを取り出す
    foodTmp = [defaults objectForKey:@"foodTable"];
    
    if (foodTmp == nil) {
        //一度も保存されていない場合はデフォルトリストを代入する
        
        //配列を使った場合
        foodTmp = @[@{@"name":@"sisig",
                        @"desc":@"説明sisig",
                        @"favoriteflag":@"0"},
                      @{@"name":@"dryed mango",@"desc":@"説明dryed mango",@"favoriteflag":@"0"},
                      @{@"name":@"haroharo",@"desc":@"説明haroharo",@"favoriteflag":@"0"},
                      @{@"name":@"jolibee",@"desc":@"説明jolibee",@"favoriteflag":@"0"}];
    }
    
    _foodArray = foodTmp.mutableCopy;

    
    
    //保存されたデータを取り出す
    coffeeTmp = [defaults objectForKey:@"coffeeTable"];
    
    if (coffeeTmp == nil) {
        //一度も保存されていない場合はデフォルトリストを代入する
        
        //配列を使った場合
        coffeeTmp = @[@{@"name":@"ブルーマウンテン",
                       @"desc":@"ジャマイカにあるブルーマウンテン山脈の標高800～1200mの限られた地域で栽培されるコーヒー豆のブランド。\nブルーマウンテンの特徴として、香りが非常に高く、繊細な味であることが挙げられる。香りが高いため、他の香りが弱い豆とブレンドすることが多い。",
                       @"favoriteflag":@"0"},
                     @{@"name":@"キリマンジャロ",@"desc":@"説明キリ",@"favoriteflag":@"0"},
                     @{@"name":@"ブラジル",@"desc":@"説明ブラジル",@"favoriteflag":@"0"},
                     @{@"name":@"コロンビア",@"desc":@"説明コロンビア",@"favoriteflag":@"0"}];
    }
    
    _coffeeArray = coffeeTmp.mutableCopy;
    
    
    if (self.select_button_num == 1) {
        _useArray = _coffeeArray;
    }else{
        _useArray = _foodArray;
    }
    
    self.coffeeTitle.text = [NSString stringWithFormat:@"%@とは",_useArray[self.select_num][@"name"]];
    self.descriptionText.text = _useArray[self.select_num][@"desc"];

    id favoriteflag = _useArray[self.select_num][@"favoriteflag"];
    
    int intFavFlag = [favoriteflag intValue];
    
    if (intFavFlag == 0) {
        [self.favoriteBtn setTitle:@"お気に入り追加" forState:UIControlStateNormal];
        
    }else{
        [self.favoriteBtn setTitle:@"お気に入り解除" forState:UIControlStateNormal];
        
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addFavoriteList:(id)sender {
    
    
    NSDictionary *selectedCoffee = _useArray[self.select_num];
    
    NSMutableDictionary *changedCoffee = selectedCoffee.mutableCopy;
    
    id favoriteflag = _useArray[self.select_num][@"favoriteflag"];
    
    int intFavFlag = [favoriteflag intValue];
    
    if (intFavFlag == 0) {
        [changedCoffee setObject:@1 forKey:@"favoriteflag"];
        
        //これからお気に入りに追加されるため、ボタン名を解除にセットしておく
        [self.favoriteBtn setTitle:@"お気に入り解除" forState:UIControlStateNormal];
        
    }else{
        [changedCoffee setObject:@0 forKey:@"favoriteflag"];
        
        //これからお気に入り解除されるため、ボタン名を追加にセットしておく
        [self.favoriteBtn setTitle:@"お気に入り追加" forState:UIControlStateNormal];
        
    }
    
    [_useArray replaceObjectAtIndex:self.select_num withObject:changedCoffee];
    
    
    
    //UserDefaultObjectを用意する
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //文字を保存
    if (self.select_button_num == 1) {
        [defaults setObject:_useArray forKey:@"coffeeTable"];
        
    }else{
        [defaults setObject:_useArray forKey:@"foodTable"];
    
    }
    [defaults synchronize];
}

@end

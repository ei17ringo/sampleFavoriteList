//
//  favoriteViewController.m
//  SampleFavoriteList
//
//  Created by Eriko Ichinohe on 2014/11/12.
//  Copyright (c) 2014年 Eriko Ichinohe. All rights reserved.
//

#import "favoriteViewController.h"
#import "DetailViewController.h"

@interface favoriteViewController ()

@end

@implementation favoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //UserDefaultからデータを取り出す
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray *coffeeTmp;
    NSArray *foodTmp;
    
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
    

    
    
    //検索用編集可能配列
    NSMutableArray *tmpcoffeeArray = coffeeTmp.mutableCopy;
    NSMutableArray *tmpfoodArray = foodTmp.mutableCopy;
    
    
    //お気に入りリスト珈琲（最初はお気に入りでないものも全て保存）
    _coffeeArray = coffeeTmp.mutableCopy;
    
    //お気に入りとして指定されているか、チェック後、おきにいりのものだけを残し、他は削除する
    for (NSDictionary *coffeeArray_each in tmpcoffeeArray) {
        id favoriteflag = coffeeArray_each[@"favoriteflag"];

        //取り出したデータをint型に変換（if文で判定しやすいように)
        int intFavFlag = [favoriteflag intValue];
        
        if (intFavFlag == 0) {
            //お気に入り指定されてないので削除
            [_coffeeArray removeObject:coffeeArray_each];
        }

    }
    
    
    //お気に入りリストフード（最初はお気に入りでないものも全て保存）
    _foodArray = foodTmp.mutableCopy;
    
    //お気に入りとして指定されているか、チェック後、おきにいりのものだけを残し、他は削除する
    for (NSDictionary *foodArray_each in tmpfoodArray) {
        id favoriteflag = foodArray_each[@"favoriteflag"];
        
        //取り出したデータをint型に変換（if文で判定しやすいように)
        int intFavFlag = [favoriteflag intValue];
        
        if (intFavFlag == 0) {
            //お気に入り指定されてないので削除
            [_foodArray removeObject:foodArray_each];
        }
        
    }
    
    //重要：珈琲とフードのお気に入りを合体させる
    _useArray = _coffeeArray.mutableCopy;
    [_useArray addObjectsFromArray:_foodArray];
    
    

    
    _favoriteList.delegate = self;
    _favoriteList.dataSource = self;

}

//行数を返す
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return _coffeeArray.count;
    return _useArray.count;
}

//セルに文字を表示する
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //定数を宣言（static = 静的)
    static NSString *CellIdentifer = @"Cell";
    
    //セルの再利用
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifer];
    
    if(cell == nil){
        //セルの初期化とスタイルの決定
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifer];
    }
    
    //cell.textLabel.text = [NSString stringWithFormat:@"行番号=%d",indexPath.row];
    
    //cell.textLabel.text = _coffeeArray[indexPath.row][@"name"];
    cell.textLabel.text = _useArray[indexPath.row][@"name"];
    
    return cell;
}

//何か行が押された時DetailViewControllerに画面遷移する
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"Tap:%d",indexPath.row);
    
    //遷移先画面のカプセル化（インスタンス化）
    DetailViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    
    
    //押された行数ではなく、お気に入りもそうでないものも全て入ってるリストから番号を検索する
    
    //UserDefaultからデータを取り出す
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray *coffeeTmp;
    
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

    int index = 0;
    BOOL checkFlag = NO;
    for (NSDictionary *coffeeArray_each in coffeeTmp) {
        NSString *name = coffeeArray_each[@"name"];
        
        //名前が同じモノが存在した場合、検索処理を中止する
        if ([name isEqualToString:_useArray[indexPath.row][@"name"]]) {
            checkFlag = YES;
            dvc.select_button_num = 1;
            break;
        }
        
        index++;
    }
    
    //珈琲に存在しない場合、フードを検索する
    if (!checkFlag) {
        
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
        
        index = 0;
        checkFlag = NO;
        for (NSDictionary *foodArray_each in foodTmp) {
            NSString *name = foodArray_each[@"name"];
            
            //名前が同じモノが存在した場合、検索処理を中止する
            if ([name isEqualToString:_useArray[indexPath.row][@"name"]]) {
                checkFlag = YES;
                dvc.select_button_num = 2;
                break;
            }
            
            index++;
        }

    }
    
    //検索処理結果の番号を遷移先の画面に渡す
    dvc.select_num = index;
    
    //ナビゲーションコントローラーの機能で画面遷移
    [[self navigationController] pushViewController:dvc animated:YES];
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

@end

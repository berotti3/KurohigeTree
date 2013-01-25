//
//  MainViewController.m
//  KurohigeTree
//
//  Created by Sayuri Anbe on 12/10/31.
//  Copyright (c) 2012年 Sayuri Anbe. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

UIButton *selectIcon1;
UIButton *selectIcon2;
UIButton *selectIcon3;
UIButton *selectIcon4;
UIButton *selectIcon5;
UIButton *selectIcon6;

@implementation MainViewController

int starCount;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //アイコンプレートの生成
    
    
    selectIcon1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    selectIcon2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    selectIcon3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    selectIcon4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    selectIcon5 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    selectIcon6 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    selectIcon1.frame = CGRectMake(0, 0, 40, 40);
    selectIcon2.frame = CGRectMake(0, 40, 40, 40);
    selectIcon3.frame = CGRectMake(0, 80, 40, 40);
    selectIcon4.frame = CGRectMake(0, 120, 40, 40);
    selectIcon5.frame = CGRectMake(40, 0, 40, 40);
    selectIcon6.frame = CGRectMake(40, 40, 40, 40);
    [selectIcon1 addTarget:self action:@selector(selectIcon1:) forControlEvents:UIControlEventTouchDown];
    [selectIcon2 addTarget:self action:@selector(selectIcon2:) forControlEvents:UIControlEventTouchDown];
    [selectIcon3 addTarget:self action:@selector(selectIcon3:) forControlEvents:UIControlEventTouchDown];
    [selectIcon4 addTarget:self action:@selector(selectIcon4:) forControlEvents:UIControlEventTouchDown];
    [selectIcon5 addTarget:self action:@selector(selectIcon5:) forControlEvents:UIControlEventTouchDown];
    [selectIcon6 addTarget:self action:@selector(selectIcon6:) forControlEvents:UIControlEventTouchDown];
    selectIcon1.tag = 3;
    selectIcon2.tag = 3;
    selectIcon3.tag = 3;
    selectIcon4.tag = 3;
    selectIcon5.tag = 3;
    selectIcon6.tag = 3;
    [selectIcon1 setImage:[UIImage imageNamed:@"icon1.png"] forState:UIControlStateNormal];
    [selectIcon2 setImage:[UIImage imageNamed:@"icon2.png"] forState:UIControlStateNormal];
    [selectIcon3 setImage:[UIImage imageNamed:@"icon3.png"] forState:UIControlStateNormal];
    [selectIcon4 setImage:[UIImage imageNamed:@"icon4.png"] forState:UIControlStateNormal];
    [selectIcon5 setImage:[UIImage imageNamed:@"icon5.png"] forState:UIControlStateNormal];
    [selectIcon6 setImage:[UIImage imageNamed:@"icon6.png"] forState:UIControlStateNormal];

    
    UIImage *im1 = [UIImage imageNamed:@"bomb1.png"];
    UIImage *im2 = [UIImage imageNamed:@"bomb2.png"];
    UIImage *im3 = [UIImage imageNamed:@"bomb3.png"];
    UIImage *im4 = [UIImage imageNamed:@"bomb4.png"];
    UIImage *im5 = [UIImage imageNamed:@"bomb5.png"];
    UIImage *im6 = [UIImage imageNamed:@"bomb6.png"];
    UIImage *im7 = [UIImage imageNamed:@"bomb7.png"];
    UIImage *im8 = [UIImage imageNamed:@"bomb8.png"];
    UIImage *im9 = [UIImage imageNamed:@"bomb9.png"];
    UIImage *im10 = [UIImage imageNamed:@"bomb10.png"];
    UIImage *im11 = [UIImage imageNamed:@"bomb11.png"];
    bombview = [[UIImageView alloc]init];
    bombview.frame = CGRectMake(30, 80, 250, 280);
    bombview.animationImages = [NSArray arrayWithObjects:im1, im2, im3, im4, im5, im6, im7, im8, im9, im10, im11, nil];
    bombview.animationDuration = 1.2;
    bombview.animationRepeatCount = 1;

    [self makeStart];
    
    [self.view addSubview:selectIcon1];
    [self.view addSubview:selectIcon2];
    [self.view addSubview:selectIcon3];
    [self.view addSubview:selectIcon4];
    [self.view addSubview:selectIcon5];
    [self.view addSubview:selectIcon6];
    
    //初期状態
    selectedIcon = [UIImage imageNamed:@"icon1.png"];
    selectIcon1.enabled = false;
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    UITouch *touch = [touches anyObject];
    pickPos = [touch locationInView:self.view];

    //配置可能か確認
    if( [self checkTree:pickPos.x Y:pickPos.y] == true && [self checkIcon:pickPos.x Y:pickPos.y] == true){
        UIImage *img = selectedIcon;
        UIImageView *star = [[UIImageView alloc] initWithImage:img];
        star.center = CGPointMake(pickPos.x, pickPos.y);
        star.tag = 2;
        [self.view addSubview:star];
        starCount++;
    }
    NSLog(@"%f,%f",pickPos.x,pickPos.y);
}

- (void) makeStart {
    //☆の数初期化
    starCount = 0;
    //爆弾配置
    float bombx = rand() % 320, bomby = rand() % 460;
    while ([self checkTree:bombx Y:bomby] == false) {
        bombx=rand()%320,bomby=rand()%460;}
    NSLog(@"bomb%f,%f",bombx,bomby);
    UIButton *bomb = [UIButton buttonWithType:UIButtonTypeCustom];
    bomb.frame = CGRectMake(bombx-50, bomby-50, 100, 100);
    [bomb addTarget:self action:@selector(touchBomb:) forControlEvents:UIControlEventTouchDown];
    bomb.tag = 1;
    [self.view addSubview:bomb];
    
    //木の配置
    UIImageView *treeImage = [[UIImageView alloc] init];
    treeImage.image = [UIImage imageNamed:@"017106 2.jpg"];
    treeImage.frame = CGRectMake( 0, 0, 320, 460);
    treeImage.tag = 1;
    [self.view addSubview:treeImage];

    //ボタンを前面に持ってくる
     for (UIView *view in [self.view subviews]) {
         if(view.tag == 3 ){
             [self.view bringSubviewToFront:view];
         }
     }
}

- (void)selectIcon1:(UIButton*)button{
    selectedIcon = [UIImage imageNamed:@"icon1.png"];
    selectIcon1.highlighted = true;
    selectIcon1.enabled = false;
    
    selectIcon2.highlighted = false;
    selectIcon2.enabled = true;
    selectIcon3.highlighted = false;
    selectIcon3.enabled = true;
    selectIcon4.highlighted = false;
    selectIcon4.enabled = true;
    selectIcon5.highlighted = false;
    selectIcon5.enabled = true;
    selectIcon6.highlighted = false;
    selectIcon6.enabled = true;
}
- (void)selectIcon2:(UIButton*)button{
    selectedIcon = [UIImage imageNamed:@"icon2.png"];
    selectIcon2.highlighted = true;
    selectIcon2.enabled = false;
    
    //はずす
    selectIcon1.highlighted = false;
    selectIcon1.enabled = true;
    selectIcon3.highlighted = false;
    selectIcon3.enabled = true;
    selectIcon4.highlighted = false;
    selectIcon4.enabled = true;
    selectIcon5.highlighted = false;
    selectIcon5.enabled = true;
    selectIcon6.highlighted = false;
    selectIcon6.enabled = true;
}
- (void)selectIcon3:(UIButton*)button{
    selectedIcon = [UIImage imageNamed:@"icon3.png"];
    selectIcon3.highlighted = true;
    selectIcon3.enabled = false;
    
    selectIcon1.highlighted = false;
    selectIcon1.enabled = true;
    selectIcon2.highlighted = false;
    selectIcon2.enabled = true;
    selectIcon4.highlighted = false;
    selectIcon4.enabled = true;
    selectIcon5.highlighted = false;
    selectIcon5.enabled = true;
    selectIcon6.highlighted = false;
    selectIcon6.enabled = true;
}
- (void)selectIcon4:(UIButton*)button{
    selectedIcon = [UIImage imageNamed:@"icon4.png"];
    selectIcon4.highlighted = true;
    selectIcon4.enabled = false;
    
    selectIcon1.highlighted = false;
    selectIcon1.enabled = true;
    selectIcon3.highlighted = false;
    selectIcon3.enabled = true;
    selectIcon2.highlighted = false;
    selectIcon2.enabled = true;
    selectIcon5.highlighted = false;
    selectIcon5.enabled = true;
    selectIcon6.highlighted = false;
    selectIcon6.enabled = true;
}

- (void)selectIcon5:(UIButton*)button{
    selectedIcon = [UIImage imageNamed:@"icon5.png"];
    selectIcon3.highlighted = true;
    selectIcon3.enabled = false;
    
    selectIcon1.highlighted = false;
    selectIcon1.enabled = true;
    selectIcon2.highlighted = false;
    selectIcon2.enabled = true;
    selectIcon4.highlighted = false;
    selectIcon4.enabled = true;
    selectIcon3.highlighted = false;
    selectIcon3.enabled = true;
    selectIcon6.highlighted = false;
    selectIcon6.enabled = true;
}
- (void)selectIcon6:(UIButton*)button{
    selectedIcon = [UIImage imageNamed:@"icon6.png"];
    selectIcon6.highlighted = true;
    selectIcon6.enabled = false;
    
    selectIcon1.highlighted = false;
    selectIcon1.enabled = true;
    selectIcon3.highlighted = false;
    selectIcon3.enabled = true;
    selectIcon2.highlighted = false;
    selectIcon2.enabled = true;
    selectIcon5.highlighted = false;
    selectIcon5.enabled = true;
    selectIcon4.highlighted = false;
    selectIcon4.enabled = true;
}

-(void)touchBomb:(UIButton*)button{
    //ツイート用画像取得
    UIView *outputView = self.view;
    UIGraphicsBeginImageContext(self.view.frame.size);
    [outputView.layer renderInContext:UIGraphicsGetCurrentContext()];
    Tweetimage = UIGraphicsGetImageFromCurrentImageContext();
    
   //消す
   for (UIView *view in [self.view subviews]) {
       if(view.tag==1 || view.tag == 2){
        [view removeFromSuperview];
       }
    }
    
    //アラート
    NSLog(@"アウト！");
    NSString *outmessage = [NSString stringWithFormat:@"%d個装飾したよ☆",starCount];
    UIAlertView *alert =
    [[UIAlertView alloc] initWithTitle:@"アウト！" message:outmessage
                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"つぶやく",nil];
    
    //爆発アニメーションとアラートの表示
    [self.view addSubview:bombview];
    [bombview startAnimating];
    [alert show];
}

-(void)alertView:(UIAlertView*)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if(buttonIndex==1){//つぶやく
        [self tweet];
    }
    [self makeStart];
}

-(void) tweet{
    // ビューコントローラの初期化
    TWTweetComposeViewController *tweetViewController = [[TWTweetComposeViewController alloc] init];
    
    // 送信文字列を設定
    [tweetViewController setInitialText:[NSString stringWithFormat:@"%d個装飾したよ☆ #リア充爆発 #KurohigeTree",starCount]];
    [tweetViewController addImage:Tweetimage];
    tweetViewController.completionHandler = ^(TWTweetComposeViewControllerResult res) {
        if (res == TWTweetComposeViewControllerResultCancelled) {
            NSLog(@"キャンセル");
        }
        else if (res == TWTweetComposeViewControllerResultDone) {
            NSLog(@"成功");
        }
        [self dismissModalViewControllerAnimated:YES];
    };
    
    // 送信View表示
    [self presentModalViewController:tweetViewController animated:YES];
}

//木の上に乗ってるかどうかを確認する関数
- (BOOL) checkTree:(float)x Y:(float)y {
    if( ((2*x+y)>320) && ((2*x-y)<320) && y>70 && y<400){
        return true;
    }else{
        return false;
    }

}
//アイコン同士がぶつかるかどうかを確認する関数
- (BOOL) checkIcon:(float)x Y:(float)y{
    
    for (UIView *view in [self.view subviews]) {
        if(view.tag == 2 ){//星
            if ((x-30) < view.center.x && view.center.x < (x+30) && ((y-30) < view.center.y && view.center.y < (y+30))) {
                NSLog(@"%fとぶつかった",view.center.x);
            return false;
            }
        }
    }
    return true;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

@end

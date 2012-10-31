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

@implementation MainViewController
@synthesize treeImage;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self putBomb];
}

- (void)viewDidUnload
{
    [self setTreeImage:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    UITouch *touch = [touches anyObject];
    pickPos = [touch locationInView:self.view];

    //木の上かどうかを確認
    if( [self checkTree:pickPos.x Y:pickPos.y] == true ){
    UIImage *img = [UIImage imageNamed:@"star.png"];
    UIImageView *star = [[UIImageView alloc] initWithImage:img];
    star.center = CGPointMake(pickPos.x, pickPos.y);
    [self.view addSubview:star];
    }
    NSLog(@"%f,%f",pickPos.x,pickPos.y);
}

- (void) putBomb {
    float bombx = rand() % 320, bomby = rand() % 460;
    while ([self checkTree:bombx Y:bomby] == false) {
     bombx=rand()%320,bomby=rand()%460;
    }
    NSLog(@"bomb%f,%f",bombx,bomby);
    UIButton *bomb = [UIButton buttonWithType:UIButtonTypeCustom];
    bomb.frame = CGRectMake(bombx-40, bomby-40, 80, 80);
    [bomb addTarget:self action:@selector(touchBomb:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:bomb];
}

-(void)touchBomb:(UIButton*)button{
    //アラート表示
    NSLog(@"アウト！");
    
    
}
//木の上に乗ってるかどうかを確認する関数
- (BOOL) checkTree:(float)x Y:(float)y {
    int a;
    
    if( ((2*x+y)>320) && ((2*x-y)<320) && y>70 && y<400 )
    {a=true; NSLog(@"true");}else{a=false;}
    
    return a;
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

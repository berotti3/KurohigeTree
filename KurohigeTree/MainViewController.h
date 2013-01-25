//
//  MainViewController.h
//  KurohigeTree
//
//  Created by Sayuri Anbe on 12/10/31.
//  Copyright (c) 2012年 Sayuri Anbe. All rights reserved.
//

#import "FlipsideViewController.h"

#import <CoreData/CoreData.h>
#import <Twitter/Twitter.h>
#import <QuartzCore/QuartzCore.h>

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate>{
    CGPoint pickPos;
    UIImageView *bombview;
    UIImage *Tweetimage;
    UIImage *selectedIcon;
}

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

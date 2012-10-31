//
//  MainViewController.h
//  KurohigeTree
//
//  Created by Sayuri Anbe on 12/10/31.
//  Copyright (c) 2012年 Sayuri Anbe. All rights reserved.
//

#import "FlipsideViewController.h"

#import <CoreData/CoreData.h>

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

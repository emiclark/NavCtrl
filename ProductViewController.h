//
//  ProductViewController.h
//  NavCtrl
//ASSIGNMENT2
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewController.h"

@interface ProductViewController : UITableViewController

@property (nonatomic, strong) WebViewController    *myWebViewCtlr;
@property (nonatomic, retain) NSMutableArray *products;

@end

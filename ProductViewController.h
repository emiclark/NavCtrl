//
//  ProductViewController.h
//  NavCtrl
//  ASSIGNMENT3
//
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewController.h"
#import "CompanyViewController.h"

@interface ProductViewController : UITableViewController


@property (nonatomic, strong) WebViewController    *myWebViewCtlr;
@property (nonatomic) NSInteger currentCompany;
@property (nonatomic, retain) NSMutableArray *currentProducts;

@end

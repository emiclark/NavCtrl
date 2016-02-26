//
//  ProductViewController.h
//  NavCtrl
//
//  Assignment2
//Add Company+products + WKWebView+delete+moveRow
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
@property (nonatomic, retain) NSMutableArray *appleProducts;
@property (nonatomic, retain) NSMutableArray *samsungProducts;
@property (nonatomic, retain) NSMutableArray *asusProducts;
@property (nonatomic, retain) NSMutableArray *microsoftProducts;
@property (nonatomic,retain) NSString *currentCompany;
@property (nonatomic, retain) NSMutableArray *currentProducts;

@end

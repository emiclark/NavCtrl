//
//  ProductViewController.h
//  NavCtrl
//  ASSIGNMENT4
//  DAO refactored: Add/Edit Company+Product, + reorder+delete rows
//
//  Created by Emiko Clark on 3/4/16.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewController.h"
#import "DAO.h"
#import "Product.h"
@class EditProductViewController;

@interface ProductViewController : UITableViewController

@property (retain, nonatomic) EditProductViewController *editProductViewController;

@property (nonatomic, retain) WebViewController    *myWebViewCtlr;
@property ( nonatomic,retain) NSString *titleOfCompany;
@property (nonatomic,retain) Company *currentCompany;
@property ( nonatomic, retain) DAO  *dao;

-(void) addButton:(id)sender;
@end

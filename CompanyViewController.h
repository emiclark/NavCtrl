//  CompanyViewController.h
//  NavCtrl
//  ASSIGNMENT4
//  DAO refactored: Add/Edit Company+Product, + reorder+delete rows
//
//  Created by Emiko Clark on 2/24/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ProductViewController.h"
#import "EditCompanyViewController.h"
#import "DAO.h"

@class ProductViewController;
@class EditCompanyViewController;

@interface CompanyViewController : UITableViewController

@property ( nonatomic, retain) IBOutlet ProductViewController *productViewController;
@property ( nonatomic, retain)  EditCompanyViewController *editCompanyViewController;
@property ( nonatomic, retain) DAO  *dao;

- (void) addNewCompany;
@end
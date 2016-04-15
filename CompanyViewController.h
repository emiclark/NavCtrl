//  CompanyViewController.h
//  NavCtrl
// Assignment8
// CoreData
//
//  Created by Emiko Clark on 2/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ProductViewController.h"
#import "EditCompanyViewController.h"
#import "DAO.h"
//#import "sqlite3.h"
#import "coreDataMethods.h"
#import "Company.h"
#import "Product.h"
//#import "SQLMethods.h"

@class ProductViewController;
@class EditCompanyViewController;

@interface CompanyViewController : UITableViewController

@property ( nonatomic, retain) DAO  *dao;
@property ( nonatomic, retain) IBOutlet ProductViewController *productViewController;
@property ( nonatomic, retain) EditCompanyViewController *editCompanyViewController;
@property ( nonatomic, retain) Company   *currentCompany;
@property ( nonatomic, strong) NSArray *stockPrices;

-(void) updateStockPrices;
-(void) addNewCompany;
-(void) undoCompany;
-(void) saveButtonTapped;

@end
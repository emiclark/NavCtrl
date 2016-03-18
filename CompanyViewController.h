//  CompanyViewController.h
//  NavCtrl
// Assignment6-SQL
// Integrate SQL
//
//  Created by Emiko Clark on 2/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ProductViewController.h"
#import "EditCompanyViewController.h"
#import "DAO.h"
#import "sqlite3.h"


@class ProductViewController;
@class EditCompanyViewController;

@interface CompanyViewController : UITableViewController

@property ( nonatomic, retain) IBOutlet ProductViewController *productViewController;
@property ( nonatomic, retain)  EditCompanyViewController *editCompanyViewController;
@property ( nonatomic, retain) DAO  *dao;

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, retain) NSMutableString *query;
@property (nonatomic, strong) NSURL *dataURL;

@property (nonatomic, strong) NSArray *stockPrices;

- (void) addNewCompany;

@end
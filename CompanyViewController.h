//  CompanyViewController.h
//  NavCtrl
//  ASSIGNMENT4
//  DAO ADD Company + Product
//
//  Created by Emiko Clark on 2/24/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//
//

#import <UIKit/UIKit.h>
#import "ProductViewController.h"
#import "AddCompanyViewController.h"
#import "DAO.h"

@class ProductViewController;

@interface CompanyViewController : UITableViewController

@property ( nonatomic, retain) IBOutlet ProductViewController *productViewController;
@property ( nonatomic, retain)  AddCompanyViewController *addNewItemViewController;
@property ( nonatomic, retain) DAO  *dao;

- (void) addNewCompany;
@end
//  CompanyViewController.h
//  NavCtrl
//  ASSIGNMENT3
//  DAO
//
//  Created by Aditya Narayan on 2/24/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//
//

#import <UIKit/UIKit.h>
#import "ProductViewController.h"
#import "Company.h"
#import "Product.h"
#import "DAO.h"

@class ProductViewController;

@interface CompanyViewController : UITableViewController


@property ( nonatomic, retain) IBOutlet ProductViewController *productViewController;
@property ( nonatomic, retain) DAO  *dao;

@end

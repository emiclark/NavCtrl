//  CompanyViewController.h
//  NavCtrl
//  ASSIGNMENT3
//
//  Created by Aditya Narayan on 2/24/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//
//

#import <UIKit/UIKit.h>
#import "ProductViewController.h"
#import "Company.h"

@class ProductViewController;

@interface CompanyViewController : UITableViewController


@property ( nonatomic,strong) IBOutlet ProductViewController *productViewController;
@property (nonatomic, retain) NSMutableArray *companyList;
@property (nonatomic) Company currentCompany;

@end

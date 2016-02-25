//  CompanyViewController.h
//  NavCtrl
//ASSIGNMENT2

//  Created by Aditya Narayan on 2/24/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//
//

#import <UIKit/UIKit.h>
#import "ProductViewController.h"

@class ProductViewController;

@interface CompanyViewController : UITableViewController

@property (retain, nonatomic) IBOutlet ProductViewController *productViewController;
@property (nonatomic, retain) NSMutableArray *companyList;
@property (nonatomic) int companyNumber;

@end

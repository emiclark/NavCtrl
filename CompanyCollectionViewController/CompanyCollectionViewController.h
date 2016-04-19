//
//  CompanyCollectionViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 4/18/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAO.h"
#import "Company.h"
#import "EditCompanyViewController.h"

@interface CompanyCollectionViewController : UICollectionViewController

@property ( nonatomic, retain) EditCompanyViewController *editCompanyViewController;
@property ( nonatomic, retain) Company   *currentCompany;
@property ( nonatomic, strong) NSArray *stockPrices;

@property ( nonatomic, retain) IBOutlet ProductViewController  *productViewController;

@end

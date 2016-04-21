//
//  CompanyCollectionViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 4/18/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditCompanyViewController.h"
#import "ProductCollectionViewController.h"


@class ProductCollectionViewController;
@class EditCompanyViewController;

@interface CompanyCollectionViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property ( nonatomic, retain) DAO *dao;
@property ( nonatomic, retain) Company   *currentCompany;
@property ( nonatomic, strong) NSArray *stockPrices;
@property ( nonatomic, retain) ProductCollectionViewController *productCollectionViewController;
@property ( nonatomic, retain) EditCompanyViewController *editCompanyViewController;

#pragma mark Company CRUD Methods
-(void) addNewCompany;
-(void) deleteItem:(UIButton *)sender;
-(void) saveButtonTapped;
-(void) undoCompany;
@end

//
//  CompanyCollectionViewController.h
//  NavCtrl
// Assignment10
// CoreData + AFNetworking to retrieve StockPrices
//
//  Created by Aditya Narayan on 4/18/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditCompanyViewController.h"
#import "ProductCollectionViewController.h"


@class ProductCollectionViewController;
@class EditCompanyViewController;
@class DAO;
@interface CompanyCollectionViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property ( nonatomic, retain) Company   *currentCompany;
@property ( nonatomic, retain) ProductCollectionViewController *productCollectionViewController;
@property ( nonatomic, retain) EditCompanyViewController *editCompanyViewController;

// Company CRUD Methods
-(void) addNewCompany;
-(void) deleteItem:(UIButton *)sender;
-(void) saveButtonTapped;
-(void) undoCompany;

// Misc Utility Methods
-(void) setEditMode;
-(void) getStockPrices;

    
@end

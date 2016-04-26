//
//  ProductCollectionViewController.h
//  NavCtrl
// Assignment10
// CoreData + AFNetworking to retrieve StockPrices
//
//  Created by Emiko Clark on 4/19/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewController.h"
#import "DAO.h"
#import "Product.h"
#import "EditProductViewController.h"

@class EditProductViewController;

@interface ProductCollectionViewController : UICollectionViewController

@property (nonatomic, retain) EditProductViewController *editProductViewController;
@property (nonatomic, retain) ProductCollectionViewController *productCollectionViewController;

@property (nonatomic, retain) WebViewController *myWebViewCtlr;
@property ( nonatomic,retain) NSString *titleOfCompany;
@property ( nonatomic,retain)  Company *currentCompany;
@property ( nonatomic, retain) Product *currentProduct;

-(void) addButtonTapped:(id)sender;
-(void) saveButtonTapped:(id)sender;
-(void) undoButtonTapped:(id)sender;
-(void) setEditMode;

@end

//
//  ProductViewController.h
//  NavCtrl
// Assignment8
// CoreData
//
//  Created by Emiko Clark on 2/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewController.h"
#import "DAO.h"
#import "Product.h"

@class EditProductViewController;

@interface ProductViewController : UITableViewController

@property ( nonatomic, retain) DAO  *dao;
@property (retain, nonatomic) EditProductViewController *editProductViewController;
@property (nonatomic, retain) WebViewController *myWebViewCtlr;
@property ( nonatomic,retain) NSString *titleOfCompany;
@property ( nonatomic,retain)  Company *currentCompany;
@property ( nonatomic, retain) Product *currentProduct;

// Product CRUD Methods
-(void) addButtonTapped:(id)sender;
-(void) undoButtonTapped:(id)sender;
-(void) saveButtonTapped:(id)sender;
@end

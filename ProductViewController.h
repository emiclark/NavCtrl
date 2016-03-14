//
//  ProductViewController.h
//  NavCtrl
//  ASSIGNMENT 5
//  Use Yahoo finance API to get stock prices
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

@property (retain, nonatomic) EditProductViewController *editProductViewController;

@property (nonatomic, retain) WebViewController    *myWebViewCtlr;
@property ( nonatomic,retain) NSString *titleOfCompany;
@property (nonatomic,retain) Company *currentCompany;
@property ( nonatomic, retain) DAO  *dao;

-(void) addButton:(id)sender;
@end

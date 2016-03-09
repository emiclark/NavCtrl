//
//  ProductViewController.h
//  NavCtrl
//  ASSIGNMENT4
//  DAO ADD Company + Product
//
//
//  Created by Emiko Clark on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewController.h"
#import "DAO.h"
#import "editProductViewController.h"
#import "Product.h"

@interface ProductViewController : UITableViewController

@property (retain, nonatomic) EditProductViewController *editProductViewController;

@property (nonatomic, retain) WebViewController    *myWebViewCtlr;
@property ( nonatomic,retain) NSString *titleOfCompany;
@property (nonatomic,retain) Company *currentCompany;
@property ( nonatomic, retain) DAO  *dao;

-(void) addButton:(id)sender;
@end

//
//  EditProductViewController.h
//  NavCtrl
//  ASSIGNMENT 5
//  Use Yahoo finance API to get stock prices
//
//  Created by Emiko Clark on 2/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "Company.h"
#import "DAO.h"
#import "ProductViewController.h"
#import "CompanyViewController.h"
@class ProductViewController;

@interface EditProductViewController : UIViewController

@property (retain, nonatomic) IBOutlet UILabel *productViewTitle;
@property (retain, nonatomic) IBOutlet UITextField *productName;
@property (retain, nonatomic) IBOutlet UITextField *productURL;
@property (retain, nonatomic) IBOutlet UITextField *productLogo;

@property (strong, nonatomic) ProductViewController * productVC;
@property (strong, nonatomic) CompanyViewController * companyVC;

@property (retain, nonatomic) IBOutlet UIButton *saveProductButton;

@property (retain,nonatomic) Product *productToEdit;
@property  (retain,nonatomic) DAO *dao;

- (IBAction)saveProductButtonTapped:(UIButton *)sender;

@end

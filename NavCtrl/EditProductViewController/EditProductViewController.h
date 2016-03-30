//
//  EditProductViewController.h
//  NavCtrl
// Assignment6-SQL
// Integrate SQL
//
//  Created by Emiko Clark on 2/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAO.h"
#import "Company.h"
#import "Product.h"
#import "CompanyViewController.h"
#import "ProductViewController.h"

@class ProductViewController;

@interface EditProductViewController : UIViewController

@property  (retain,nonatomic) DAO *dao;
@property (retain,nonatomic )Company *currentCompany;
@property (retain,nonatomic) Product *currentProduct;
@property (nonatomic) NSInteger currentRow;

@property (retain, nonatomic) IBOutlet UILabel *productViewTitle;
@property (retain, nonatomic) IBOutlet UITextField *name;
@property (retain, nonatomic) IBOutlet UITextField *url;
@property (retain, nonatomic) IBOutlet UITextField *logo;

@property (strong, nonatomic) ProductViewController * productVC;
@property (strong, nonatomic) CompanyViewController * companyVC;

@property (retain, nonatomic) IBOutlet UIButton *saveProductButton;


- (IBAction)saveProductButtonTapped:(UIButton *)sender;

@end

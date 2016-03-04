//
//  AddProductViewController.h
//  NavCtrl
//  ASSIGNMENT4
//  DAO ADD Company + Product
//
//  Created by Emiko Clark on 2/24/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompanyViewController.h"
#import "AddProductViewController.h"
#import "CompanyViewController.h"
#import "Company.h"
#import "Product.h"
#import "DAO.h"

@interface AddProductViewController : UIViewController
@property (nonatomic,retain) AddProductViewController *addProductViewController;

@property (retain, nonatomic) IBOutlet UITextField *addProductName;
@property (retain, nonatomic) IBOutlet UITextField *addProductURL;
@property (retain, nonatomic) IBOutlet UITextField *addProductLogo;
@property (retain, nonatomic)  DAO *dao;

@end

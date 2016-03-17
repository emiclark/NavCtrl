//
//  EditCompanyViewController.h
//  NavCtrl
//  ASSIGNMENT 5
//  Use Yahoo finance API to get stock prices
//
//  Created by Emiko Clark on 2/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAO.h"
#import "Company.h"
#import "CompanyViewController.h"
@class CompanyViewController;

@interface EditCompanyViewController : UIViewController

@property (retain,nonatomic) DAO *dao;
@property (retain, nonatomic) Company *companyToEdit;
@property (retain, nonatomic) Company *companyToAdd;

@property (retain, nonatomic) CompanyViewController *companyViewController;

@property (retain, nonatomic) IBOutlet UILabel *addEditCompanyLabel;
@property (retain, nonatomic) IBOutlet UITextField *editCompanyName;
@property (retain, nonatomic) IBOutlet UITextField *editCompanyLogo;
@property (retain, nonatomic) IBOutlet UIButton *saveButton;

- (IBAction)SaveButtonTapped:(UIButton *)sender;

@end

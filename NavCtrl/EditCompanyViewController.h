//
//  EditCompanyViewController.h
//  NavCtrl
// Assignment10
// CoreData + AFNetworking to retrieve StockPrices
//
//  Created by Emiko Clark on 2/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"
#import "CompanyCollectionViewController.h"

@class CompanyCollectionViewController;

@interface EditCompanyViewController : UIViewController

@property (retain, nonatomic) Company *currentCompany;
@property (nonatomic) NSInteger currentRow;
@property (retain, nonatomic) CompanyCollectionViewController *companyCollectionViewController;

@property (retain, nonatomic) IBOutlet UILabel *label;
@property (retain, nonatomic) IBOutlet UITextField *name;
@property (retain, nonatomic) IBOutlet UITextField *stockSymbol;
@property (retain, nonatomic) IBOutlet UITextField *logo;
@property (retain, nonatomic) IBOutlet UIButton *saveButton;

-(IBAction)SaveButtonTapped:(UIButton *)sender;

@end

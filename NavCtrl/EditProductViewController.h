//
//  EditProductViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 3/7/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "Company.h"
#import "DAO.h"

@interface EditProductViewController : UIViewController

@property (retain, nonatomic) IBOutlet UITextField *addEditProductLabel;
@property (retain, nonatomic) IBOutlet UITextField *productName;
@property (retain, nonatomic) IBOutlet UITextField *productURL;
@property (retain, nonatomic) IBOutlet UITextField *productLogo;
@property (retain, nonatomic) IBOutlet UIButton *saveButton;
@property (retain,nonatomic) Product *productToEdit;
@property (retain, nonatomic) Product *productToAdd;
@property  (retain,nonatomic) DAO *dao;

- (IBAction)addSaveButtonTapped:(UIButton *)sender;
@end

//
//  EditCompanyViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 3/7/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAO.h"
#import "Company.h"

@interface EditCompanyViewController : UIViewController

@property (retain,nonatomic) DAO *dao;

@property (retain, nonatomic) Company *companyToEdit;
@property (retain, nonatomic) IBOutlet UITextField *editCompanyName;
@property (retain, nonatomic) IBOutlet UITextField *editCompanyLogo;


- (IBAction)SaveButtonTapped:(UIButton *)sender;
@end

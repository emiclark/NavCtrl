//
//  AddCompanyViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 3/2/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAO.h"
//#import "Company.h"

@interface AddCompanyViewController : UIViewController
@property (nonatomic, retain) DAO *dao;
@property (nonatomic, retain) Company *addCompany;

@property (retain, nonatomic) IBOutlet UITextField *addCompanyName;
@property (retain, nonatomic) IBOutlet UITextField *addCompanyLogo;

- (IBAction)AddCompanyButtonTapped:(UIButton *)sender;

@end

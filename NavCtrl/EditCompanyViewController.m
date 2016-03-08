//
//  EditCompanyViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 3/7/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "EditCompanyViewController.h"
#import "DAO.h"
#import "Company.h"
#import "CompanyViewController.h"

@interface EditCompanyViewController ()

@end

@implementation EditCompanyViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.dao = [DAO sharedManager];
    
    self.editCompanyName.text = self.companyToEdit.name;
    self.editCompanyLogo.text = self.companyToEdit.logo;
    

}

- (IBAction)SaveButtonTapped:(UIButton *)sender {
    self.companyToEdit.name = self.editCompanyName.text;
    self.companyToEdit.logo = self.editCompanyLogo.text;
    
    //return to rootViewController
    CompanyViewController *companyViewController = [[CompanyViewController alloc] init];
    companyViewController = [[CompanyViewController alloc]initWithNibName:@"CompanyViewController" bundle:nil];
//    [self.navigationController popToRootViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [_editCompanyName release];
    [_editCompanyLogo release];
    [super dealloc];
}
@end

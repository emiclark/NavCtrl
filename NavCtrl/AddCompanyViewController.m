//
//  AddCompanyViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 3/2/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "AddCompanyViewController.h"
#import "AddProductViewController.h"
#import "CompanyViewController.h"
#import "DAO.h"
//#import "Company.h"

@interface AddCompanyViewController ()

@end

@implementation AddCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dao = [DAO sharedManager];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)CancelButtonTapped:(UIButton *)sender {
    // init AddCompanyViewController
    CompanyViewController *companyViewController = [[CompanyViewController alloc] init];
    companyViewController = [[CompanyViewController alloc]initWithNibName:@"CompanyViewController" bundle:nil];
    [self.navigationController pushViewController: companyViewController animated:YES];
    NSLog(@"back to company controller - worked   ");

}

- (IBAction)AddCompanyButtonTapped:(UIButton *)sender {
    self.title = @"Add A Company";
    
    self.addCompany = [[Company alloc] initWithName:self.addCompanyName.text andLogo:self.addCompanyLogo.text];

    if ([self.addCompany.name isEqualToString:@""]){
        self.addCompany.name = @"UNNamed Company";
    }
    [self.dao.companyList addObject: self.addCompany ];
    
    
    NSLog(@"-----add company button tapped CL:%@, name:%@, logo:%@", self.dao.companyList, self.addCompany.name, self.addCompany.logo );
    
    // init AddProductViewController
    AddProductViewController *addProductViewController = [[AddProductViewController alloc] init];
    addProductViewController = [[AddProductViewController alloc]initWithNibName:@"AddProductViewController" bundle:nil];
    [self.navigationController pushViewController: addProductViewController animated:YES];
    NSLog(@"back to add product controller - worked   ");
    
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
    [_addCompany release];
    [_addCompanyName release];
    [_addCompanyLogo release];
    [super dealloc];
}

@end

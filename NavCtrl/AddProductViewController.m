//
//  AddProductViewController.m
//  NavCtrl
//  ASSIGNMENT4
//  DAO ADD Company + Product
//
//  Created by Emiko Clark on 2/24/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "AddProductViewController.h"
#import "CompanyViewController.h"
#import "Company.h"
#import "Product.h"
#import "DAO.h"

@interface AddProductViewController ()

@end

@implementation AddProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dao = [DAO sharedManager];
    // Do any additional setup after loading the view from its nib.
    
    
}
- (IBAction)AddProductButtonTapped:(UIButton *)sender {
    
    Product *product = [[Product alloc]init];
    
    product.name = self.addProductName.text;
    product.url = self.addProductURL.text;
    product.logo = self.addProductLogo.text;
    
    [self.dao.companyList.lastObject.productArray addObject: product];
    NSLog(@"product ADDED: %@",self.dao.companyList.lastObject.productArray);


}

- (IBAction)AddProductCancelButtonTapped:(UIButton *)sender {
    CompanyViewController *companyViewController = [[CompanyViewController alloc] init];
    companyViewController = [[CompanyViewController alloc]initWithNibName:@"CompanyViewController" bundle:nil];
    [self.navigationController pushViewController: companyViewController animated:YES];
    NSLog(@"back to company controller - worked   ");
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
     [_addProductName release];
     [super dealloc];
 }

@end

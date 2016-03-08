//
//  editProductViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 3/7/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "editProductViewController.h"
#import "ProductViewController.h"
#import "ProductViewController.h"
#import "DAO.h"

@interface editProductViewController ()

@end

@implementation editProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.productName.text = self.productToEdit.name;
    self.productURL.text = self.productToEdit.url;
    self.productLogo.text = self.productToEdit.logo;
    self.title = @"Update Product";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)UpdateProductButtonTapped:(UIButton *)sender {
    self.productToEdit.name = self.productName.text;
    self.productToEdit.url = self.productURL.text;
    self.productToEdit.logo = self.productLogo.text;

    ProductViewController *productViewController = [[ProductViewController alloc] init];
    productViewController = [[ProductViewController alloc]initWithNibName:@"ProductViewController" bundle:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
    //    [self.navigationController popToRootViewControllerAnimated:YES];

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
    [_productName release];
    [_productURL release];
    [_productLogo release];
    [super dealloc];
}
@end

//
//  EditProductViewController.m
//  NavCtrl
// Assignment6-SQL
// Integrate SQL
//
//  Created by Emiko Clark on 2/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "EditProductViewController.h"

@interface EditProductViewController ()
@end

@implementation EditProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dao = [DAO sharedManager];
    
    // Do any additional setup after loading the view from its nib.
    if (self.currentProduct) {

        //edit mode
        self.productViewTitle.text = [NSString stringWithFormat:@"Update %@",self.currentProduct.name];
        self.logo.text = self.currentProduct.name;
        self.url.text = self.currentProduct.url;
        self.logo.text = self.currentProduct.logo;
        [self.saveProductButton setTitle:@"Update Product" forState:UIControlStateNormal];
        
    } else {
        
        //add product mode
        self.productViewTitle.text = @"Add New Product";
        
        // set focus
        [self.name performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0];
        // set default text
        [self.saveProductButton setTitle:@"Save Product" forState:UIControlStateNormal];

    }
}



- (IBAction)saveProductButtonTapped:(UIButton *)sender {
    self.dao = [DAO sharedManager];
    
    
    if (self.currentProduct.productID != (int) nil) {
        //edit product mode
        _currentProduct.name = self.name.text;
        _currentProduct.url = self.url.text;
        _currentProduct.logo = self.logo.text;

    } else {
        Product *currentProduct = [[Product alloc]init];
        //add product mode
        currentProduct.name = self.name.text;
        currentProduct.url = self.url.text;
        currentProduct.logo = self.logo.text;
        
        //save new product
        [self.dao saveProduct:currentProduct];
    }
    [self.productVC.tableView reloadData];
    [self.navigationController popViewControllerAnimated:YES];
    
    [self.currentProduct release];
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
    
    [_productViewTitle release];
    [_name release];
    [_url release];
    [_logo release];
    [_saveProductButton release];
    [super dealloc];
}
@end

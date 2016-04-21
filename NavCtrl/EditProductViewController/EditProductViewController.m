//
//  EditProductViewController.m
//  NavCtrl
// Assignment8
// CoreData
//
//  Created by Emiko Clark on 2/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "EditProductViewController.h"

@interface EditProductViewController ()
@end

@implementation EditProductViewController

#pragma mark View Methods
-(void)viewDidLoad {
    [super viewDidLoad];
    self.dao = [DAO sharedManager];
    
    // Do any additional setup after loading the view from its nib.
    if (self.currentProduct) {
        //edit mode
        self.productViewTitle.text = [NSString stringWithFormat:@"Update %@",self.currentProduct.name];
        self.name.text = self.currentProduct.name;
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

#pragma mark Save Product Method
-(IBAction)saveProductButtonTapped:(UIButton *)sender {
    
    if (self.currentProduct.productID !=  0) {
        //edit product mode
        self.currentProduct.name = self.name.text;
        self.currentProduct.url = self.url.text;
        self.currentProduct.logo = self.logo.text;
        self.currentProduct.row = self.currentRow;
        [DAO updateProduct:self.currentProduct];
//        [DAO save];
    } else {

        //add product mode
        self.currentProduct = [[[Product alloc]init] autorelease];
        self.currentProduct.companyID = self.currentCompany.companyID;
        self.currentProduct.productID = self.dao.newProductID;
        self.currentProduct.name = self.name.text;
        self.currentProduct.url = self.url.text;
        self.currentProduct.logo = self.logo.text;

        //get row number for newproduct
        self.currentProduct.row = [DAO getNewProductRowNumber];

        //add new product and save
        self.dao.currentProduct = self.currentProduct;
        [self.dao addProduct: self.currentProduct];
    }

    [DAO save];
    [self.productVC.collectionView reloadData];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark Misc Methods
-(void)didReceiveMemoryWarning {
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

-(void)dealloc {
    
    [_productViewTitle release];
    [_name release];
    [_url release];
    [_logo release];
    [_saveProductButton release];
    [super dealloc];
}
@end

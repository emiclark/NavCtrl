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
#import "ProductViewController.h"
#import "CompanyViewController.h"
#import "DAO.h"

@interface EditProductViewController ()
@end

@implementation EditProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dao = [DAO sharedManager];
    
    // Do any additional setup after loading the view from its nib.
    if (self.productToEdit) {

        //edit mode
//        self.title = self.productVC.currentCompany.name;
        self.productViewTitle.text = [NSString stringWithFormat:@"Update %@",self.productToEdit.name];
        self.productName.text = self.productToEdit.name;
        self.productURL.text = self.productToEdit.url;
        self.productLogo.text = self.productToEdit.logo;
        [self.saveProductButton setTitle:@"Update Product" forState:UIControlStateNormal];
    } else {
        //add product mode
        self.productViewTitle.text = @"Add New Product";
        
        // set focus
        [self.productName performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0];
        // set default text
        [self.saveProductButton setTitle:@"Save Product" forState:UIControlStateNormal];

    }
}



- (IBAction)saveProductButtonTapped:(UIButton *)sender {

    Product *productToAdd = [[Product alloc]init];
    
    if (self.productToEdit) {
        //edit product mode
        self.productToEdit.name = self.productName.text;
        self.productToEdit.url = self.productURL.text;
        self.productToEdit.logo = self.productLogo.text;
//        self.productVC.title = self.productToEdit.name;

    } else {
        //add product mode
        
        if ([self.productName.text isEqual:@""]) {
            productToAdd.name = @"Undefined Product Name";
        } else {
            productToAdd.name = self.productName.text;
        }
        
        //set default url to http://www.google.com
        if ([self.productURL.text isEqual:@""]) {
            productToAdd.url = @"http://www.google.com";
        } else {
            productToAdd.url = self.productURL.text;
        }
        
        //set default logo
        if ([self.productLogo.text isEqual:@""]) {
            productToAdd.logo = @"Sunflower.gif";
        } else {
            productToAdd.logo = self.productLogo.text;
        }
        
        //save new product
        [[self.dao.companyList objectAtIndex:self.dao.companyNo].productArray  addObject: productToAdd];
    }
    [self.productVC.tableView reloadData];
    [self.navigationController popViewControllerAnimated:YES];
    
    [productToAdd release];
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
    [_productName release];
    [_productURL release];
    [_productLogo release];
    [_saveProductButton release];
    [super dealloc];
}
@end

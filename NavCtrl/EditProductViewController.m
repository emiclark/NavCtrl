//
//  EditProductViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 3/7/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "EditProductViewController.h"
#import "ProductViewController.h"

@interface EditProductViewController ()

@end

@implementation EditProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dao = [DAO sharedManager];
    
    // Do any additional setup after loading the view from its nib.
    if (self.productToEdit) {
        //edit mode
        self.addEditProductLabel.text = [NSString stringWithFormat:@"Update %@",self.productToEdit.name];
        self.productName.text = self.productToEdit.name;
        self.productURL.text = self.productToEdit.url;
        self.productLogo.text = self.productToEdit.logo;
        self.saveButton.titleLabel.text = @"Update Product";
    } else {
        //add product mode
        self.productToAdd = [[Product alloc]init];
        self.addEditProductLabel.text = @"Add New Product";
        
        // set focus
        [self.productName performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0];
        // set default text
        self.saveButton.titleLabel.text  = @"Save Product";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addSaveButtonTapped:(UIButton *)sender {
    if (self.productToEdit) {
        //edit product mode
        self.productToEdit.name = self.productName.text;
        self.productToEdit.url = self.productURL.text;
        self.productToEdit.logo = self.productLogo.text;
    } else {
        //add product mode
        if ([self.productName.text isEqual:@""]) {
            self.productToAdd.name = @"Undefined Product Name";
        } else {
            self.productToAdd.name = self.productName.text;
        }
        
        //set default url to http://www.google.com
        if ([self.productURL.text isEqual:@""]) {
            self.productToAdd.url = @"http://www.google.com";
        } else {
            self.productToAdd.url = self.productURL.text;
        }
        
        //set default logo
        if ([self.productLogo.text isEqual:@""]) {
            self.productToAdd.logo = @"Sunflower.gif";
        } else {
            self.productToAdd.logo = self.productLogo.text;
        }
        
        //save new product
        [self.dao.companyList.lastObject.productArray addObject: self.productToAdd];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

//- (IBAction)addSaveProductButtonTapped:(UIButton *)sender {
//    if (self.productToEdit) {
//        //edit product mode
//        self.productToEdit.name = self.productName.text;
//        self.productToEdit.url = self.productURL.text;
//        self.productToEdit.logo = self.productLogo.text;
//    } else {
//        //add product mode
//        if ([self.productName.text isEqual:@""]) {
//            self.productToAdd.name = @"Undefined Product Name";
//        } else {
//            self.productToAdd.name = self.productName.text;
//        }
//        
//        //set default url to http://www.google.com
//        if ([self.productURL.text isEqual:@""]) {
//            self.productToAdd.url = @"http://www.google.com";
//        } else {
//            self.productToAdd.url = self.productURL.text;
//        }
//        
//        //set default logo
//        if ([self.productLogo.text isEqual:@""]) {
//            self.productToAdd.logo = @"Sunflower.gif";
//        } else {
//            self.productToAdd.logo = self.productLogo.text;
//        }
//        
//        //save new product
//        [self.dao.companyList.lastObject.productArray addObject: self.productToAdd];
//    }
//
//        [self.navigationController popViewControllerAnimated:YES];
//}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)dealloc {

    [_addEditProductLabel release];
    [_productName release];
    [_productURL release];
    [_productLogo release];
    [_saveButton release];
    [_productName release];
    [_productURL release];
    [_productLogo release];
    [_addEditProductLabel release];
    [super dealloc];
}
@end


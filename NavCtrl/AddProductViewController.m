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
    
    //add Done button on RHS
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]init];
    doneButton.action = @selector(DoneButtonTapped);
    doneButton.title = @"Done";
    doneButton.target = self;
    self.navigationItem.rightBarButtonItem = doneButton;
    
    // set focus to textfield
    [self.addProductName performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0];
    
    
}

- (IBAction)AddProductButtonTapped:(UIButton *)sender {
    
    Product *product = [[Product alloc]init];
    
    product.name = self.addProductName.text;
    product.url = self.addProductURL.text;
    product.logo = self.addProductLogo.text;

    //ensure product name is filled
    if ([self.addProductName.text isEqualToString:@""]) {
        //reset focus on text field
        [self.addProductName performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0];
    }
    //add default url
    if ([self.addProductURL.text isEqualToString:@""]){
        product.url  = @"http://www.google.com";
    }
    //add default logo image
    if ([self.addProductLogo.text isEqualToString:@""]){
        product.logo = @"Sunflower.gif";
    }
    
    //save product info to DAO
    [self.dao.companyList.lastObject.productArray addObject: product];
    
    //create string with product information
    NSString  *string = [NSString stringWithFormat:@"SAVED: Product:%@, URL:%@, Logo:%@",product.name, product.url,product.logo];
    
    //display validation text in uilabel
    [self.savedProductValidation setText:string];
    
    //clear out input fields
    self.addProductName.text = @"";
    self.addProductURL.text = @"";
    self.addProductLogo.text = @"";

    //set focus on first text field
    [self.addProductName performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0];

    NSLog(@"product ADDED: %@",self.dao.companyList.lastObject.productArray);


}

- (void)DoneButtonTapped {
    CompanyViewController *companyViewController = [[CompanyViewController alloc] init];
    companyViewController = [[CompanyViewController alloc]initWithNibName:@"CompanyViewController" bundle:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
//    [self.navigationController popViewControllerAnimated:YES];
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
     [_savedProductValidation release];
     [super dealloc];
 }

@end

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
    
    //add Done button on RHS
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]init];
    doneButton.action = @selector(DoneButtonTapped);
    doneButton.title = @"Done";
    doneButton.target = self;
    self.navigationItem.rightBarButtonItem = doneButton;
}

//- (IBAction)CancelButtonTapped:(UIButton *)sender {
//    // init AddCompanyViewController
//    CompanyViewController *companyViewController = [[CompanyViewController alloc] init];
//    companyViewController = [[CompanyViewController alloc]initWithNibName:@"CompanyViewController" bundle:nil];
//    [self.navigationController  popToViewController:companyViewController animated:YES];
//}

- (void)DoneButtonTapped {
    CompanyViewController *companyViewController = [[CompanyViewController alloc] init];
    companyViewController = [[CompanyViewController alloc]initWithNibName:@"CompanyViewController" bundle:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
    //    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)AddCompanyButtonTapped:(UIButton *)sender {
    // set focus to textfield
    [self.addCompanyName performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0];
    self.addCompany = [[Company alloc] initWithName:self.addCompanyName.text andLogo:self.addCompanyLogo.text];

    //add default company name
    if ([self.addCompany.name isEqualToString:@""]) {
        //reset focus on text field
        [self.addCompanyName performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0];
    }
    //add default logo image
    if ([self.addCompany.logo isEqualToString:@""]){
        self.addCompany.logo = @"Sunflower.gif";
    }
    [self.dao.companyList addObject: self.addCompany ];
    
    // init AddProductViewController
    AddProductViewController *addProductViewController = [[AddProductViewController alloc] init];
    addProductViewController = [[AddProductViewController alloc]initWithNibName:@"AddProductViewController" bundle:nil];
    [self.navigationController pushViewController: addProductViewController animated:YES];
    
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

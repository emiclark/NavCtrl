//
//  AddCompanyViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 3/2/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "AddCompanyViewController.h"
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
    self.addCompany = [[Company alloc]init];
    
    //error if field is empty
    if ([self.addCompanyName.text isEqualToString: @""] ){
        self.addCompanyName.text = @"Company name cannot be empty.";
    } else {
        self.addCompany.logo = _addCompanyLogo.text;
    }
    
    self.addCompany.name = _addCompanyName.text;
    //add default logo if logo field is empty
    if ([_addCompanyLogo.text isEqualToString: @""] ){
        self.addCompany.logo = @"sunflower.gif";
    } else {
        self.addCompany.logo = _addCompanyLogo.text;
    }
    
    //add company to dao if name field is !empty
    if (![self.addCompanyName.text isEqualToString: @""]) {
        [self.dao.companyList addObject: self.addCompany ];
    }
    self.title = @"Add A Company";
    
    NSLog(@"-----add company button tapped CL:%@, name:%@, logo:%@", self.dao.companyList, self.addCompany.name, self.addCompany.logo );
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

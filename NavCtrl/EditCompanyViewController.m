//
//  EditCompanyViewController.m
//  NavCtrl
// Assignment6-SQL
// Integrate SQL
//
//  Created by Emiko Clark on 2/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "EditCompanyViewController.h"
#import "CompanyViewController.h"
#import "ProductViewController.h"

@interface EditCompanyViewController ()

@end

@implementation EditCompanyViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.dao = [DAO sharedManager];
    
    //check if add or edit and set label
    if (self.companyToEdit) {
        //edit mode
        //set label title
        self.addEditCompanyLabel.text = [NSString stringWithFormat: @"Edit %@",self.companyToEdit.name];
        self.editCompanyName.text = self.companyToEdit.name;
        self.editCompanyLogo.text = self.companyToEdit.logo;
        //set text of save button
        self.saveButton.titleLabel.text = @"Update Company";
    } else {
        //add mode
        self.companyToAdd = [[Company alloc]init];
        //set label title
        self.addEditCompanyLabel.text = @"Add Company";

        //set focus
        [self.editCompanyName performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0];
        
        //set default image for logo
        if ([self.editCompanyLogo.text  isEqual: @""]){
            self.companyToAdd.logo = @"Sunflower.gif";
        }
        //set text of save button
        self.saveButton.titleLabel.text = @"Save Company";
    }

}



- (void)viewWillAppear:(BOOL)animated {
    // Pass the selected object to the new view controller.
    
    [super viewWillAppear:animated];
    [self.companyViewController.tableView reloadData];
    [self setEditing: NO animated: NO];
}

- (IBAction)SaveButtonTapped:(UIButton *)sender {

    //edit mode - companytoEdit not nil
    if (self.companyToEdit) {
        self.companyToEdit.name = self.editCompanyName.text;
        self.companyToEdit.logo = self.editCompanyLogo.text;
    } else {
    //add mode
        self.companyToAdd.name = self.editCompanyName.text;
        self.companyToAdd.logo = self.editCompanyLogo.text;
        
        //set company name
        if (self.companyToAdd.name) {
            self.companyToAdd.name =  self.editCompanyName.text;
        } else {
            self.companyToAdd.name = @"Undefined Company";
        }
        
        //set default image for logo
        if ([self.editCompanyLogo.text  isEqual: @""]){
            self.companyToAdd.logo = @"Sunflower.gif";
        }
        //allocate productArray
        self.companyToAdd.productArray = [[NSMutableArray alloc]init];
        //add new company to companyList
        [self.dao.companyList addObject:self.companyToAdd];
    }
    
    //return to rootViewController
    [self.navigationController popToRootViewControllerAnimated:YES];
    //[self.navigationController popViewControllerAnimated:YES];
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
    [_editCompanyName release];
    [_editCompanyLogo release];
    [_addEditCompanyLabel release];
    [_saveButton release];
    [super dealloc];
}
@end

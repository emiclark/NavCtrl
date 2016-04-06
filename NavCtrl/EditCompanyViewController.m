//
//  EditCompanyViewController.m
//  NavCtrl
// Assignment7-MMM
// Manual Memory Management
//
//  Created by Emiko Clark on 2/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.

#import "EditCompanyViewController.h"
#import "CompanyViewController.h"
#import "ProductViewController.h"

@interface EditCompanyViewController ()

@end

@implementation EditCompanyViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.dao = [DAO sharedManager];
    //    self.currentCompany = self.dao.currentCompany;
    
    //check if add or edit and set label
    if (self.currentCompany.companyID != 0) {
        //edit mode
        //set label title
        self.label.text = [NSString stringWithFormat: @"Edit %@",self.currentCompany.name];
        self.name.text = self.currentCompany.name;
        self.stockSymbol.text = self.currentCompany.stockSymbol;
        self.logo.text = self.currentCompany.logo;
        //set text of save button
        self.saveButton.titleLabel.text = @"Update Company";
    } else {
        //add mode
        self.currentCompany = [[[Company alloc]init] autorelease];
        //set label title
        self.label.text = @"Add Company";
        self.currentCompany.companyID = self.dao.newCompanyID;
        //set focus
        [self.name performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0];
        
        //set default image for logo
        if ([self.logo.text  isEqual: @""]){
            self.currentCompany.logo = @"Sunflower.gif";
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
    //    Company *currentCompany = self.dao.currentCompany;
    
    NSLog(@"save:currentCompany%@",self.currentCompany);
    //edit mode - companytoEdit not nil
    if (self.currentCompany.companyID < self.dao.newCompanyID) {
        self.currentCompany.name = self.name.text;
        self.currentCompany.stockSymbol = self.stockSymbol.text;
        self.currentCompany.logo = self.logo.text;
        [self.dao  updateCompany:self.currentCompany AtIndex: (long)self.currentRow];
    } else  {
        //add mode
        self.currentCompany.productArray = [[[NSMutableArray alloc]init] autorelease];
        self.currentCompany.name = self.name.text;
        self.currentCompany.companyID = self.dao.newCompanyID++;
        self.currentCompany.stockSymbol = self.stockSymbol.text;
        self.currentCompany.logo = self.logo.text;
        
        long indexOfLastElement = self.dao.companyList.count-1;
        if (indexOfLastElement < 0 ) {
            self.currentCompany.row =  1.0;
        } else {
            self.currentCompany.row = [(Company*)[self.dao.companyList objectAtIndex:indexOfLastElement] row];
            self.currentCompany.row = self.currentCompany.row +1;
            NSLog(@" CC:%ld, %ld",(long)self.currentCompany.row,(long)[(Company*)[self.dao.companyList objectAtIndex:indexOfLastElement] row]);
        }
        
        NSLog(@"%@",self.currentCompany);
        
        //save currentCompany to DAO/SQL
        [self.dao addCompany:self.currentCompany];
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
    [_name release];
    [_logo release];
    [_label release];
    [_saveButton release];
    [_stockSymbol release];
    [super dealloc];
}
@end

//
//  ProductViewController.m
//  NavCtrl
//  ASSIGNMENT 5
//  Use Yahoo finance API to get stock prices
//
//  Created by Emiko Clark on 2/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//
#import "ProductViewController.h"
#import "EditProductViewController.h"

#import "DAO.h"

@interface ProductViewController ()
@end

@implementation ProductViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dao = [DAO sharedManager];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Add New Product /"
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                  action:@selector(addButton:)];
    
    NSArray *buttons = [[NSArray alloc]initWithObjects: self.editButtonItem, addButton, nil];
    self.navigationItem.rightBarButtonItems = buttons;
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    [self.tableView setAllowsSelectionDuringEditing:YES];
    [self.tableView reloadData];
    
}

- (void)viewWillAppear:(BOOL)animated {
    // Pass the selected object to the new view controller.
    
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    [self setEditing: NO animated: NO];
}

-(void)addButton:(id)sender {
    self.editProductViewController = [[EditProductViewController alloc]initWithNibName:@"EditProductViewController" bundle:nil];
    self.editProductViewController.productVC = self;
    [self.navigationController pushViewController: self.editProductViewController animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.currentCompany.productArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    
    Product *tempProduct = [self.currentCompany.productArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = tempProduct.name;
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Delete the row from the data source
        [self.currentCompany.productArray removeObjectAtIndex:indexPath.row];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    [tableView reloadData];
}


 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
     Product *productToMove = [self.currentCompany.productArray  objectAtIndex:fromIndexPath.row];
     [self.currentCompany.productArray removeObjectAtIndex:fromIndexPath.row];
     [self.currentCompany.productArray  insertObject:productToMove atIndex:toIndexPath.row];
 }

 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }



#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (self.tableView.editing == YES){
        //edit mode - edit product

        //initialize EditProductViewController for editing
        self.editProductViewController = [[EditProductViewController alloc]initWithNibName:@"EditProductViewController" bundle:nil];
        NSString *tempStr   = [[[self.dao.companyList objectAtIndex:self.dao.currentCompanyIndex].productArray objectAtIndex:indexPath.row ] name];

        self.titleOfCompany = tempStr;
        self.editProductViewController.currentProduct = [self.currentCompany.productArray objectAtIndex:indexPath.row];
        
        //set title of EditProductViewController
        self.editProductViewController.title = self.editProductViewController.currentProduct.name;

        self.editProductViewController.productVC = self;
        [self.navigationController pushViewController: self.editProductViewController animated:YES];
        

    } else {
        //initialize webkit view controller to show url of product
        Product *tempProduct = [self.currentCompany.productArray objectAtIndex:indexPath.row];
        
        // Create the next view controller.
        self.myWebViewCtlr = [[WebViewController alloc]init];
        self.myWebViewCtlr.productURL = tempProduct.url;
        self.myWebViewCtlr.title = tempProduct.name;
        
        [self.navigationController pushViewController:self.myWebViewCtlr animated:YES];
    }
}


@end

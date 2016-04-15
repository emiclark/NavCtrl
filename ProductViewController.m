//
//  ProductViewController.m
//  NavCtrl
// Assignment8
// CoreData
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
    
    UIBarButtonItem *addButton = [[[UIBarButtonItem alloc]
                                   initWithTitle:@" / Add New Product"
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(addButtonTapped:)]autorelease];
    
    
    UIBarButtonItem *undoButton = [[[UIBarButtonItem alloc]
                                   initWithTitle:@"Undo /"
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                    action:@selector(undoButtonTapped:)]autorelease];
    
    UIBarButtonItem *saveButton = [[[UIBarButtonItem alloc]
                                    initWithTitle:@"Save /"
                                    style:UIBarButtonItemStyleBordered
                                    target:self
                                    action:@selector(SaveButtonTapped:)]autorelease];
    
    // Display an Edit 'Add New Product' and Undo button on the RHS navigation bar for this view controller.
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:self.editButtonItem, undoButton, saveButton, nil];
    
    // Display an Back and Save button on the LHS navigation bar for this view controller.
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects: addButton, nil];
    self.navigationItem.leftItemsSupplementBackButton = YES;
    
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

-(void)addButtonTapped:(id)sender {
    
    self.editProductViewController = [[[EditProductViewController alloc]initWithNibName:@"EditProductViewController" bundle:nil] autorelease];
    self.editProductViewController.currentCompany = self.currentCompany;
    self.editProductViewController.productVC = self;
    [self.navigationController pushViewController: self.editProductViewController animated:YES];
    
}

-(void)undoButtonTapped:(id)sender {
    [DAO undoProductforCompany];
}

-(void)SaveButtonTapped:(id)sender {
    [DAO save];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier] ;
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    // Configure the cell...
    
    Product *tempProduct = [self.currentCompany.productArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = tempProduct.name;
    return cell;
    [tempProduct release];
    [CellIdentifier release];
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.editProductViewController.currentRow = indexPath.row;
    self.editProductViewController.currentProduct =  [self.dao.currentCompany.productArray objectAtIndex:indexPath.row];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dao deleteProduct:[self.currentCompany.productArray objectAtIndex:indexPath.row] atRow:indexPath.row ];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    [tableView reloadData];
}


// Override to support rearranging the table view.
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    self.currentProduct = [self.currentCompany.productArray objectAtIndex:sourceIndexPath.row];

    if (self.currentCompany.productArray.count > 0){
        
        //more than 1 element
        if (destinationIndexPath.row == self.currentCompany.productArray.count-1) {
            //move to bottom, increment row +1.0 of last product and assign to currentProduct
            
            self.currentProduct.row = [self.currentCompany.productArray objectAtIndex: destinationIndexPath.row].row + 1.0;
        } else if (destinationIndexPath.row == 0){
            //move to top, divide/2 the product.row index in position 1 and set to currentProduct.row
            self.currentProduct.row = [self.currentCompany.productArray objectAtIndex:destinationIndexPath.row].row / 2.0;
        
        } else if (sourceIndexPath.row > destinationIndexPath.row){
            // move up
            float rowBefore =[self.currentCompany.productArray objectAtIndex:destinationIndexPath.row-1].row;
            float rowAfter = [self.currentCompany.productArray objectAtIndex:destinationIndexPath.row].row;
            self.currentProduct.row = (rowBefore + rowAfter) / 2.0;
        
        } else if (sourceIndexPath.row < destinationIndexPath.row){
            //move down
            float rowBefore =[self.currentCompany.productArray objectAtIndex:destinationIndexPath.row].row;
            float rowAfter = [self.currentCompany.productArray objectAtIndex:destinationIndexPath.row+1].row;
            self.currentProduct.row = (rowBefore + rowAfter) / 2.0;
        }
    } else {
        //add 1st product for company
        self.currentProduct.row = 1.0;
    }
    
    [DAO updateProduct:self.currentProduct];
    
    [self.currentCompany.productArray removeObjectAtIndex:sourceIndexPath.row];
    [self.currentCompany.productArray insertObject:self.currentProduct atIndex:destinationIndexPath.row];
    [self.tableView reloadData];
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
    self.dao.currentProduct = [self.dao.currentCompany.productArray objectAtIndex:indexPath.row];
    self.editProductViewController.currentCompany = self.dao.currentCompany;
    
    //edit mode - edit product
    if (self.tableView.editing == YES){
        //initialize EditProductViewController for editing
        self.editProductViewController = [[[EditProductViewController alloc]initWithNibName:@"EditProductViewController" bundle:nil] autorelease];
        self.editProductViewController.currentRow = indexPath.row;
        self.editProductViewController.currentProduct.row = indexPath.row;
        self.editProductViewController.currentProduct = [[self currentCompany].productArray objectAtIndex:indexPath.row];
        
        self.titleOfCompany =  self.currentProduct.name;
        //set title of EditProductViewController
        self.editProductViewController.title = self.editProductViewController.currentProduct.name;
        self.editProductViewController.productVC = self;
        [self.navigationController pushViewController: self.editProductViewController animated:YES];
        
    } else {
        //initialize webkit view controller to show url of product
        Product *tempProduct = [self.currentCompany.productArray objectAtIndex:indexPath.row];
        
        // Create the next view controller.
        self.myWebViewCtlr = [[[WebViewController alloc]init] autorelease];
        self.myWebViewCtlr.productURL = tempProduct.url;
        self.myWebViewCtlr.title = tempProduct.name;
        
        [self.navigationController pushViewController:self.myWebViewCtlr animated:YES];
    }
}


@end

//
//  CompanyViewController.m
//  NavCtrl
//  ASSIGNMENT3
//
//
//  Created by Aditya Narayan on 10/22/13.

#import "ProductViewController.h"
#import "CompanyViewController.h"
#import "Company.h"
#import "Product.h"
#import "DAO.h"

@interface CompanyViewController ()
{
    Company *apple;
    Company *microsoft;
    Company *asus;
    Company *samsung;
    
    Product *appleiPad;
    Product *appleiPod;
    Product *appleiPhone;
   
    Product *samsungS4;
    Product *samsungTab;
    Product *samsungNote;

    Product *asusZen;
    Product *asusEee;
    Product *asusPad;

    Product *microsoftLumina;
    Product *microsoftLenovo;
    Product *microsoftSurface;
    
}
@end

@implementation CompanyViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dao = [[DAO alloc]init];
    self.dao = [DAO sharedManager];
    
    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
 
    self.productViewController = [[ProductViewController alloc] init];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;

    self.title = @"Mobile device makers";
    
    
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
    return [self.dao.companyList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = [[self.dao.companyList objectAtIndex:[indexPath row]] name];
    
    //add company logos
    cell.imageView.image  = [UIImage imageNamed:[[self.dao.companyList objectAtIndex:[indexPath row]] logo]];
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        // Delete the company row from the data source
        [self.dao.companyList removeObjectAtIndex:indexPath.row];
        //self.productViewController.currentCompany = @"";

    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    [tableView reloadData];
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

//    if ([[self.companyList objectAtIndex: indexPath.row] isEqualToString:@"Apple"]){
//        self.productViewController.title = @"Apple mobile devices";
//        //self.productViewController.currentCompany = apple.name;
//    } else if ([[self.companyList objectAtIndex: indexPath.row] isEqualToString:@"Samsung"]) {
//        self.productViewController.title = @"Samsung mobile devices";
//        //self.productViewController.currentCompany = samsung.name;
//    } else if ([[self.companyList objectAtIndex: indexPath.row] isEqualToString:@"Asus"]) {
//        self.productViewController.title = @"Asus mobile devices";
//        //self.productViewController.currentCompany = asus.name;
//    } else if ([[self.companyList objectAtIndex: indexPath.row] isEqualToString:@"Microsoft"]) {
//        self.productViewController.title = @"Microsoft mobile devices";
//        //self.productViewController.currentCompany = microsoft.name;
//    }
    self.productViewController.currentCompany = indexPath.row;
    [self.navigationController pushViewController:self.productViewController animated:YES];
}
 
- (void)dealloc {
    [_productViewController release];
    [super dealloc];
}
@end

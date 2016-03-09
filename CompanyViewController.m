//
//  CompanyViewController.m
//  NavCtrl
//  ASSIGNMENT4
//  DAO ADD Company + Product
//
//  Created by Emiko Clark on 10/22/13.

#import "CompanyViewController.h"
#import "EditCompanyViewController.h"
#import "Company.h"
#import "DAO.h"

@interface CompanyViewController ()

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

-(void) viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dao = [DAO sharedManager];
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    
    self.productViewController = [[ProductViewController alloc] init];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //add button on LHS
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]init];
    addButton.action = @selector(addNewCompany);
    addButton.title = @"Add New Company";
    addButton.target = self;
    self.navigationItem.leftBarButtonItem = addButton;
    
    self.title = @"Mobile device makers";
    
    [self.tableView reloadData];

}

- (void) addNewCompany {
    
    self.editCompanyViewController = [[EditCompanyViewController alloc]initWithNibName:@"EditCompanyViewController" bundle:nil];
    [self.navigationController pushViewController: self.editCompanyViewController animated:YES];
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
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view

    }
    [tableView reloadData];
}



 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
     Company *companyToMove = [self.dao.companyList objectAtIndex:fromIndexPath.row];
     [self.dao.companyList removeObjectAtIndex:fromIndexPath.row];
     [self.dao.companyList insertObject:companyToMove atIndex:toIndexPath.row];
 
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
    if (self.tableView.editing == YES) {
        //edit mode - edit company
        //set new viewcontroller to editCompanyViewController
        self.editCompanyViewController = [[EditCompanyViewController alloc]initWithNibName:@"EditCompanyViewController" bundle:nil];
        
        //pass in pointer of company selected to ediCompanyViewController.companyToedit
        self.editCompanyViewController.companyToEdit = [self.dao.companyList objectAtIndex: indexPath.row];
        [self.navigationController pushViewController:self.editCompanyViewController animated:YES  ];
        
    } else {
        //not in editing mode - show product details
        self.productViewController.currentCompany = [self.dao.companyList objectAtIndex:indexPath.row];
        self.productViewController.titleOfCompany = [[self.dao.companyList objectAtIndex:indexPath.row] name];
        [self.navigationController pushViewController:self.productViewController animated:YES];
    }
}


- (void)dealloc {
    [_productViewController release];
    [super dealloc];
}
@end

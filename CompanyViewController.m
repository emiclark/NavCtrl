//
//  CompanyViewController.m
//  NavCtrl
//
//  Assignment2
//Add Company+products + WKWebView+delete+moveRow
//
//  Created by Aditya Narayan on 10/22/13.

#import "ProductViewController.h"
#import "CompanyViewController.h"

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    
    self.productViewController = [[ProductViewController alloc] init];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.companyList = [[NSMutableArray alloc]initWithObjects:@"Apple mobile devices",@"Samsung mobile devices",@"Asus mobile devices",@"Microsoft mobile devices",nil];

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
    return [self.companyList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = [self.companyList objectAtIndex:[indexPath row]];
    
    //add company logos
    if ([cell.textLabel.text isEqualToString:@"Apple mobile devices"]) {
        [[cell imageView ] setImage:[UIImage imageNamed:@"apple.png"]];
    } else if ([cell.textLabel.text isEqualToString:@"Samsung mobile devices"]) {
        [[cell imageView ] setImage:[UIImage imageNamed:@"samsung.png"]];
    } else if ([cell.textLabel.text isEqualToString: @"Asus mobile devices"] ) {
        [[cell imageView] setImage: [UIImage imageNamed: @"asus.png" ]];
    } else if ([cell.textLabel.text isEqualToString: @"Microsoft mobile devices"]){
        [[cell imageView] setImage: [UIImage imageNamed: @"microsoft.png"]];
    }
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
        
        
        //remove corresponding products array
        if ([self.productViewController.currentCompany isEqualToString:@"Apple"]) {
            [self.productViewController.appleProducts removeAllObjects];
            [self.productViewController.appleProducts release];
        } else if ([self.productViewController.currentCompany isEqualToString:@"Samsung"]) {
            [self.productViewController.samsungProducts removeAllObjects];
            [self.productViewController.samsungProducts release];
        } else if ([self.productViewController.currentCompany isEqualToString:@"Asus"]) {
            [self.productViewController.asusProducts removeAllObjects];
            [self.productViewController.asusProducts release];
        } else if ([self.productViewController.currentCompany isEqualToString:@"Microsoft"]) {
            [self.productViewController.microsoftProducts removeAllObjects];
            [self.productViewController.microsoftProducts release];
        }
        // Delete the company row from the data source
        [self.companyList removeObjectAtIndex:indexPath.row];
        self.productViewController.currentCompany = @"";

    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    [tableView reloadData];
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSString *stringToMove = self.companyList[sourceIndexPath.row];
    [self.companyList removeObjectAtIndex:sourceIndexPath.row];
    [self.companyList insertObject:stringToMove atIndex:destinationIndexPath.row];
}


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if ([[self.companyList objectAtIndex: indexPath.row] isEqualToString:@"Apple mobile devices"]){
        self.productViewController.title = @"Apple mobile devices";
        self.productViewController.currentCompany = @"Apple";
    } else if ([[self.companyList objectAtIndex: indexPath.row] isEqualToString:@"Samsung mobile devices"]) {
        self.productViewController.title = @"Samsung mobile devices";
        self.productViewController.currentCompany = @"Samsung";
    } else if ([[self.companyList objectAtIndex: indexPath.row] isEqualToString:@"Asus mobile devices"]) {
        self.productViewController.title = @"Asus mobile devices";
        self.productViewController.currentCompany = @"Asus";
    } else if ([[self.companyList objectAtIndex: indexPath.row] isEqualToString:@"Microsoft mobile devices"]) {
        self.productViewController.title = @"Microsoft mobile devices";
        self.productViewController.currentCompany = @"Microsoft";
    }
    
    [self.navigationController pushViewController:self.productViewController animated:YES];
}

- (void)dealloc {
    [_productViewController release];
    [super dealloc];
}
@end

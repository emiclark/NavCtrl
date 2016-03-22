//
//  CompanyViewController.m
//  NavCtrl
// Assignment6-SQL
// Integrate SQL
//
//  Created by Emiko Clark on 2/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.

#import "CompanyViewController.h"
#import "EditCompanyViewController.h"
#import "Company.h"
#import "Product.h"
#import "sqlite3.h"
#import "DAO.h"

@interface CompanyViewController () <NSURLSessionDelegate, NSURLSessionDownloadDelegate>
{
//    sqlite3 *sqliteDB;
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

-(void) viewWillAppear:(BOOL)animated{
    self.dao = [DAO sharedManager];
    
    // request for stock prices using Yahoo API
    
    //create query string
    self.query = [[NSMutableString alloc]initWithString:@"http://finance.yahoo.com/d/quotes.csv?s="];
   
    NSString *temp = [[NSString alloc] initWithString: [[self.dao.companyList objectAtIndex:0] stockSymbol ]];
    NSLog(@"%ld, %@",self.dao.companyList.count, temp);
    
    for (int i=0; i<self.dao.companyList.count-1; i++) {
        //concatenate symbol names to end of url
        [self.query appendString:self.dao.companyList[i].stockSymbol];
        [self.query appendString:@"+"];
    }

    int lastItem = (int)self.dao.companyList.count-1;
    
    [self.query appendString:[self.dao.companyList objectAtIndex:lastItem].stockSymbol];
     [self.query appendString:@"&f=l1"];
     NSLog(@"query: %@",self.query);
     
     //create url from query string
     self.dataURL = [NSURL URLWithString:self.query];
     NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
               dataTaskWithURL:self.dataURL
               completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                   
                       // *price has stock prices in csv format
                       NSString *price =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                       //stockPrices is an array of stock Prices
                       self.stockPrices = [price componentsSeparatedByString: @"\n"];
                       
                       NSLog(@"%@",self.stockPrices);
                       //update the UI on the main thread
                       dispatch_async(dispatch_get_main_queue(), ^(void){
                       Company *tempCo = [[Company alloc]init];
                       
                       // set company prices in company class
                       for (int i = 0; i< self.dao.companyList.count; i++) {
                           tempCo = [self.dao.companyList objectAtIndex:i];
                           tempCo.stockPrice = self.stockPrices[i];
                       }
                       
                       [self.tableView reloadData];
                       });
               }];
     [downloadTask resume];
     
     [super viewWillAppear:animated];
     [self.tableView reloadData];
     [self setEditing: NO animated: NO];
     
     
     }

 - (void)viewDidLoad
{
    [super viewDidLoad];
    self.dao = [DAO sharedManager];
    self.stockPrices = [[NSArray alloc]init];

    //check documents directory to see if dao.db exists,
    //if so, populate arrays,
    //if not, copy dao.db from resource folder in main bundle and ,
    //finally, populate arrays
    
    [self.dao createOrOpenDB];
    [self.dao populateCompany];

    //create a config session
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    // declare this method as the delegate
    [NSURLSession sessionWithConfiguration:sessionConfig
                                  delegate: self
                             delegateQueue:nil];
    
    
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    
    // Configure the cell...
    //add company logos
    cell.imageView.image  = [UIImage imageNamed:[[self.dao.companyList objectAtIndex:[indexPath row]] logo]];
    
    
    //format tableview with company name + stockprices
    cell.textLabel.text = [[self.dao.companyList objectAtIndex:indexPath.row] name];
    cell.detailTextLabel.text = [[self.dao.companyList objectAtIndex:indexPath.row] stockPrice];
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
        
        self.dao.companyNo = indexPath.row;
        
        if (self.tableView.editing == YES) {
            //edit mode - edit company
            //set new viewcontroller to editCompanyViewController
            self.editCompanyViewController = [[EditCompanyViewController alloc]initWithNibName:@"EditCompanyViewController" bundle:nil];
            
            //set title of view controller
            self.productViewController.currentCompany = [self.dao.companyList objectAtIndex:indexPath.row];
            self.productViewController.titleOfCompany = [[self.dao.companyList objectAtIndex:indexPath.row] name];
            
            //pass in pointer of company selected to ediCompanyViewController.companyToedit
            self.editCompanyViewController.companyToEdit = [self.dao.companyList objectAtIndex: indexPath.row];
            [self.navigationController pushViewController:self.editCompanyViewController animated:YES  ];
            
        } else {
            //not in editing mode - show product details
            self.productViewController.currentCompany = [self.dao.companyList objectAtIndex:indexPath.row];
            self.productViewController.titleOfCompany = [[self.dao.companyList objectAtIndex:indexPath.row] name];
            self.productViewController.title = self.productViewController.titleOfCompany;
            [self.navigationController pushViewController:self.productViewController animated:YES];
        }
    }
     
     
     - (void)dealloc {
         [_productViewController release];
         [super dealloc];
     }


-(void) URLSession:(NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(nonnull NSURL *)location {
    
}

-(void) NSURLSessionDownloadDelegate {
    
}

@end

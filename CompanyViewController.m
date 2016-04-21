////
////  CompanyViewController.m
////  NavCtrl
//// Assignment8
//// CoreData
////
////  Created by Emiko Clark on 2/29/16.
////  Copyright © 2016 Aditya Narayan. All rights reserved.
//
//#import "CompanyViewController.h"
//#import "coreDataMethods.h"
//
//
//@interface CompanyViewController () <NSURLSessionDelegate, NSURLSessionDownloadDelegate>
//{
//}
//@end
//
//@implementation CompanyViewController
//
//#pragma mark default functions
//-(void)viewDidLoad
//{
//    [super viewDidLoad];
//    self.dao = [DAO sharedManager];
//    [DAO initializeDAO];
//
//    [self.tableView reloadData];
//    
//    self.stockPrices = [[[NSArray alloc]init]autorelease];
//    
//    //create a config session
//    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
//    
//    // declare this method as the delegate
//    [NSURLSession sessionWithConfiguration:sessionConfig
//                                  delegate: self
//                             delegateQueue:nil];
//    
//    self.clearsSelectionOnViewWillAppear = NO;
//    
//    self.productViewController = [[[ProductViewController alloc] init] autorelease];
//    
//    //add Add New Company button on LHS
//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]init];
//    addButton.action = @selector(addNewCompany);
//    addButton.title = @"Add New Company";
//    addButton.target = self;
//    self.navigationItem.leftBarButtonItem = addButton;
//
//    //add Save button on LHS
//    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]init];
//    saveButton.action = @selector(saveButtonTapped);
//    saveButton.title = @"Save /";
//    saveButton.target = self;
//    self.navigationItem.leftBarButtonItem = saveButton;
//    
//    //add Undo button RHS
//    UIBarButtonItem *undoButton = [[UIBarButtonItem alloc]init];
//    undoButton.action = @selector(undoCompany);
//    undoButton.title = @"Undo /";
//    undoButton.target = self;
//    
//    // Display an 'Add New Company' and Save button on the LHS navigation bar for this view controller.
//    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:addButton, nil];
//    
//    // Display an Edit and Undo button on the RHS navigation bar for this view controller.
////    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:self.editButtonItem, undoButton, nil];
//    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:self.editButtonItem, undoButton, saveButton, nil];
//    
//    
//    self.title = @"Mobile device makers";
//
//    [self.tableView reloadData];
//}
//
//
//-(id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}
//
//-(void) viewWillAppear:(BOOL)animated{
//    
//    [super viewWillAppear:animated];
////    [self updateStockPrices];
//    [self.tableView reloadData];
//    [self setEditing: NO animated: NO];
//}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//#pragma mark Company Methods
//-(void)updateStockPrices {
//    
//    // request for stock prices using Yahoo API
//    //create query string
//    NSMutableString *query = [[[NSMutableString alloc]initWithString:@"http://finance.yahoo.com/d/quotes.csv?s="]autorelease];
//    
//    for (int i=0; i < self.dao.companyList.count-1; i++) {
//        //concatenate symbol names to end of url
//        [query appendString:[(Company*)self.dao.companyList[i] stockSymbol]];
//        [query appendString:@"+"];
//    }
//    
//    int lastItem = (int)self.dao.companyList.count-1;
//    
//    [query appendString:[(Company*)[self.dao.companyList objectAtIndex:lastItem] stockSymbol]];
//    [query appendString:@"&f=l1"];
//    NSLog(@"query: %@",query);
//    
//    //create url from query string
//    NSURL *dataURL = [NSURL URLWithString:query];
//    NSURLSessionDataTask *downloadTask =
//    [[NSURLSession sharedSession]
//     dataTaskWithURL:dataURL
//     completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//         
//         // *price has stock prices in csv format
//         NSString *price =[[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding] autorelease];
//         //stockPrices is an array of stock Prices
//         self.stockPrices = [price componentsSeparatedByString: @"\n"];
//         
//         NSLog(@"%@",self.stockPrices);
//         //update the UI on the main thread
//         dispatch_async(dispatch_get_main_queue(), ^(void){
//             self.currentCompany = [[[Company alloc]init] autorelease];
//             // set company prices in company class
//             for (int i = 0; i< self.dao.companyList.count; i++) {
//                 self.currentCompany = [self.dao.companyList objectAtIndex:i];
//                 self.currentCompany.stockPrice = self.stockPrices[i];
//             }
//             
//             [self.tableView reloadData];
//         });
//     }];
//    [downloadTask resume];
//    [self.tableView reloadData];
//}
//
//
//-(void) addNewCompany {
//    self.editCompanyViewController = [[[EditCompanyViewController alloc]initWithNibName:@"EditCompanyViewController" bundle:nil] autorelease];
//    self.editCompanyViewController.currentCompany = [[[Company alloc]init]autorelease];
//    [self.navigationController pushViewController: self.editCompanyViewController animated:YES];
//}
//
//
//-(void) undoCompany {
//    [DAO undoCompany];
//    [self.tableView reloadData];
//}
//
//-(void) saveButtonTapped {
//    [DAO save];
//    [self.tableView reloadData];
//}
//
//#pragma mark - Table view data source
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    // Return the number of sections.
//    return 1;
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    // Return the number of rows in the section.
//    return [self.dao.companyList count];
//}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"CompanyCollectionViewCell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier]autorelease];
//    }
//    
//    // Configure the cell...
//    //add company logos
//    cell.imageView.image  = [UIImage imageNamed:[[self.dao.companyList objectAtIndex:[indexPath row]] logo]];
//    
//    //format tableview with company name + stockprices
//    cell.textLabel.text = [[self.dao.companyList objectAtIndex:indexPath.row] name];
//    cell.detailTextLabel.text = [[self.dao.companyList objectAtIndex:indexPath.row] stockPrice];
//    return cell;
//}
//
//// Override to support conditional editing of the table view.
//-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}
//
//// Override to support editing the table view.
//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        self.currentCompany = [self.dao.companyList objectAtIndex:indexPath.row];
//        [self.dao deleteCompany:self.currentCompany atRow: indexPath.row ];
//    }
//    else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        
//    }
//    [tableView reloadData];
//}
//
//// Override to support rearranging the table view.
//-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
//    
//    Company *itemToMove;
//    itemToMove = (Company*)[self.dao.companyList objectAtIndex:sourceIndexPath.row];
//    [itemToMove retain];
//    [self.dao.companyList removeObjectAtIndex:sourceIndexPath.row];
//    [self.dao.companyList insertObject:itemToMove atIndex:destinationIndexPath.row];
//    
//    for (int i = 0; i < self.dao.companyList.count; i++){
//        Company *company = self.dao.companyList[i];
//        company.row = (float)i;
//        [DAO moveCompany:company];
//    }
//    [self.tableView reloadData];
//    [itemToMove release];
//
//}
//
//
//// Override to support conditional rearranging of the table view.
//-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the item to be re-orderable.
//    return YES;
//}
//
//
//
//#pragma mark - Table view delegate
//
//// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    self.dao.currentCompany = [self.dao.companyList objectAtIndex:indexPath.row];
//    self.currentCompany = self.dao.currentCompany;
//    //    self.editCompanyViewController.currentCompany = self.currentCompany;
//    
//    if (self.tableView.editing == YES) {
//        //edit mode - edit company
//        //set new viewcontroller to editCompanyViewController
//        self.editCompanyViewController = [[[EditCompanyViewController alloc]initWithNibName:@"EditCompanyViewController" bundle:nil]autorelease];
//        
//        //set title of view controller
//        self.productViewController.currentCompany = [self.dao.companyList objectAtIndex:indexPath.row] ;
//        self.productViewController.titleOfCompany = [[self.dao.companyList objectAtIndex:indexPath.row] name] ;
//        
//        //pass in pointer of company selected to ediCompanyViewController.companyToedit
//        self.editCompanyViewController.currentCompany = [self.dao.companyList objectAtIndex: indexPath.row];
//        [self.navigationController pushViewController:self.editCompanyViewController animated:YES  ];
//        
//    } else {
//        //show product details
//        self.productViewController.currentCompany = [[[Company alloc]init] autorelease];
//        self.productViewController.currentCompany = [self.dao.companyList objectAtIndex:indexPath.row];
//        self.productViewController.titleOfCompany = self.currentCompany.name;
//        self.productViewController.title = self.productViewController.titleOfCompany;
//        [self.navigationController pushViewController:self.productViewController animated:YES];
//    }
//}
//
//
//#pragma mark NSRULSession delegate functions 
//-(void) URLSession:(NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(nonnull NSURL *)location {
//}
//
//
//-(void) NSURLSessionDownloadDelegate {
//}
//
//#pragma mark Misc Methods
//-(void)dealloc {
//    [super dealloc];
//}
//@end

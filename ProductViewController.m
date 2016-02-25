//
//  ProductViewController.m
//  NavCtrl
//
//  Assignment2.3
//  Delete Feature
//
//
//  Created by Aditya Narayan on 2/22/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//
#import "ProductViewController.h"

@interface ProductViewController ()

@end

@implementation ProductViewController

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
    
//    self.myCompanyViewCtlr = [[CompanyViewController alloc] init];
    
    //initialize product and url arrays
    self.appleProducts = [[NSMutableArray alloc] initWithObjects:@"iPad", @"iPod Touch",@"iPhone", nil];
    self.myWebViewCtlr.appleProductURLs = [[NSMutableArray alloc] initWithObjects:
                                      @"http://www.apple.com/ipad/",
                                      @"http://www.apple.com/ipod-touch/",
                                      @"http://www.apple.com/iphone/", nil];

    self.samsungProducts = [[NSMutableArray alloc]initWithObjects: @"Galaxy S4", @"Galaxy Note", @"Galaxy Tab",nil];
    self.myWebViewCtlr.samsungProductURLs = [[NSMutableArray alloc] initWithObjects:
                                      @"http://www.samsung.com/global/microsite/galaxys4/",
                                      @"http://www.samsung.com/global/microsite/galaxynote/note/index.html?type=find",
                                      @"http://www.samsung.com/us/mobile/galaxy-tab/", nil];

    self.asusProducts = [[NSMutableArray alloc]initWithObjects: @"ZenFone 2E", @"Padfone Infinity", @"Eee Slate", nil];
    self.myWebViewCtlr.asusProductURLs =  [[NSMutableArray alloc] initWithObjects:
                                           @"http://www.asus.com/us/Phone/ZenFone-2E-US-ATT-exclusive/",
                                           @"http://www.asus.com/Phone/PadFone-A80/",
                                           @"http://www.asus.com/Tablets/Eee_Slate_EP121/",nil];
    
    self.microsoftProducts = [[NSMutableArray alloc]initWithObjects: @"Lumia 950 XL", @"Lenovo ideapad MIIX 700", @"Surface Pro 4", nil];
    self.myWebViewCtlr.microsoftProductURLs =  [[NSMutableArray alloc] initWithObjects:
                                      @"https://www.microsoft.com/en-us/mobile/phone/lumia950-xl-dual-sim/",
                                      @"http://shop.lenovo.com/us/en/tablets/ideapad/miix/miix-700/",
                                      @"http://www.microsoft.com/surface/en-us/devices/surface-pro-4",nil];
    
    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {

    switch (self.companyNumber) {
        case 0:
            self.currentProducts = self.appleProducts;
            break;
            
        case 1:
            self.currentProducts = self.samsungProducts;
            break;
        
        case 2:
            self.currentProducts = self.asusProducts;
            break;
            
        case 3:
            self.currentProducts = self.microsoftProducts;
            break;
            
        default:
            break;
    }

    [super viewWillAppear:animated];
    [self.tableView reloadData];
    

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
    
//    if (self.companyNumber == 0) {
//        return [self.appleProducts count];
//    } else if (self.companyNumber == 1) {
//        return [self.samsungProducts count];
//    } else if (self.companyNumber == 2) {
//        return [self.asusProducts count];
//    } else if (self.companyNumber == 3) {
//        return [self.microsoftProducts count];
//    }
//    NSLog(@"companyNumber %lu",self.companyNumber);
    return self.currentProducts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
//    if (self.companyNumber == 0) {
//        cell.textLabel.text = [self.appleProducts objectAtIndex:[indexPath row]];
//    } else if (self.companyNumber == 1) {
//        cell.textLabel.text = [self.samsungProducts objectAtIndex:[indexPath row]];
//    } else if (self.companyNumber == 2) {
//        cell.textLabel.text = [self.asusProducts objectAtIndex:[indexPath row]];
//    } else if (indexPath.row == 3) {
//        cell.textLabel.text = [self.microsoftProducts objectAtIndex:[indexPath row]];
//    }

    cell.textLabel.text = [self.currentProducts objectAtIndex:[indexPath row]];
    
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
//        if (self.companyNumber == 0) {
//            [self.appleProducts removeObjectAtIndex:indexPath.row];
//        } else if (self.companyNumber == 1) {
//            [self.samsungProducts removeObjectAtIndex:indexPath.row];
//        } else if (self.companyNumber == 2) {
//            [self.asusProducts removeObjectAtIndex:indexPath.row];
//        } else if (self.companyNumber == 3) {
//            [self.microsoftProducts removeObjectAtIndex:indexPath.row];
//        }
        [self.currentProducts removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation: UITableViewRowAnimationFade];
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
    // Navigation logic may go here, for example:
    // Create the next view controller.
//    self.myWebViewCtlr = [[WebViewController alloc]initWithNibName:@"WebViewController" bundle:nil];
        self.myWebViewCtlr = [[WebViewController alloc]init];

    // Pass the selected object to the new view controller.
   
    if ([[self.appleProducts objectAtIndex: indexPath.row]  isEqualToString:@"iPad"]) {
        self.myWebViewCtlr.productURL = @"http://www.apple.com/ipad/";
    } else if ([[self.appleProducts objectAtIndex: indexPath.row]  isEqualToString:@"iPod Touch"]){
        self.myWebViewCtlr.productURL = @"http://www.apple.com/ipod-touch/";
    } else if ([[self.appleProducts objectAtIndex: indexPath.row]  isEqualToString:@"iPhone"]) {
        self.myWebViewCtlr.productURL = @"http://www.apple.com/iphone/";
    } else if ([[self.samsungProducts objectAtIndex: indexPath.row]  isEqualToString:@"Galaxy S4"]) {
        self.myWebViewCtlr.productURL = @"http://www.samsung.com/global/microsite/galaxys4/";
    } else if ([[self.samsungProducts objectAtIndex: indexPath.row]  isEqualToString:@"Galaxy Note"]) {
        self.myWebViewCtlr.productURL = @"http://www.samsung.com/global/microsite/galaxynote/note/index.html?type=find";
    } else if ([[self.samsungProducts objectAtIndex: indexPath.row]  isEqualToString: @"Galaxy Tab"]) {
        self.myWebViewCtlr.productURL = @"http://www.samsung.com/us/mobile/galaxy-tab/";
    } else if ([[self.microsoftProducts objectAtIndex: indexPath.row]  isEqualToString: @"Lumia 950 XL"]) {
        self.myWebViewCtlr.productURL = @"https://www.microsoft.com/en-us/mobile/phone/lumia950-xl-dual-sim/";
    } else if ([[self.microsoftProducts objectAtIndex: indexPath.row]  isEqualToString: @"Lenovo ideapad MIIX 700"]) {
        self.myWebViewCtlr.productURL = @"http://shop.lenovo.com/us/en/tablets/ideapad/miix/miix-700/";
    } else if ([[self.microsoftProducts objectAtIndex: indexPath.row]  isEqualToString: @"Surface Pro 4"]) {
        self.myWebViewCtlr.productURL = @"http://www.microsoft.com/surface/en-us/devices/surface-pro-4";
    } else if ([[self.asusProducts objectAtIndex: indexPath.row]  isEqualToString:@"ZenFone 2E"]) {
        self.myWebViewCtlr.productURL = @"http://www.asus.com/us/Phone/ZenFone-2E-US-ATT-exclusive/";
    } else if ([[self.asusProducts objectAtIndex: indexPath.row]  isEqualToString: @"Padfone Infinity"]) {
        self.myWebViewCtlr.productURL =  @"http://www.asus.com/Phone/PadFone-A80/";
    } else if ([[self.asusProducts objectAtIndex: indexPath.row]  isEqualToString: @"Eee Slate"]) {
        self.myWebViewCtlr.productURL = @"http://www.asus.com/Tablets/Eee_Slate_EP121/";
    }
    
    //set webview title based on product
    if (self.companyNumber == 0) {
        self.myWebViewCtlr.title = [self.appleProducts objectAtIndex: indexPath.row];
    } else if (self.companyNumber == 1) {
        self.myWebViewCtlr.title = [self.samsungProducts objectAtIndex:indexPath.row];
    } else if (self.companyNumber == 2) {
        self.myWebViewCtlr.title = [self.asusProducts objectAtIndex:indexPath.row];
    } else if (self.companyNumber == 3) {
        self.myWebViewCtlr.title = [self.microsoftProducts objectAtIndex:indexPath.row];
    }
    // Push the view controller.   
    [self.navigationController pushViewController:self.myWebViewCtlr animated:YES];
    
}
 

@end

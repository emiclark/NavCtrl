//
//  ProductViewController.m
//  NavCtrl
//ASSIGNMENT2
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
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
    
    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    if ([self.title isEqualToString:@"Apple mobile devices"]) {
        self.products = [[NSMutableArray alloc] initWithObjects: @"iPad", @"iPod Touch",@"iPhone", nil];
    } else if ([self.title isEqualToString:@"Samsung mobile devices"]) {
        self.products = [[NSMutableArray alloc] initWithObjects:@"Galaxy S4", @"Galaxy Note", @"Galaxy Tab", nil];
    } else if ([self.title isEqualToString:@"Asus mobile devices"]) {
        self.products = [[NSMutableArray alloc] initWithObjects:@"ZenFone 2E", @"Padfone Infinity", @"Eee Slate", nil];
    } else if ([self.title isEqualToString:@"Microsoft mobile devices"]) {
        self.products  = [[NSMutableArray alloc] initWithObjects:@"Lumia 950 XL", @"Lenovo ideapad MIIX 700", @"Surface Pro 4", nil];
    }
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
    return [self.products count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    cell.textLabel.text = [self.products objectAtIndex:[indexPath row]];
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
        
        
        
        [self.products removeObjectAtIndex:indexPath.row];
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
    self.myWebViewCtlr = [[WebViewController alloc]initWithNibName:@"WebViewController" bundle:nil];
    // Pass the selected object to the new view controller.
   
    if ([[self.products objectAtIndex: indexPath.row]  isEqualToString:@"iPad"]) {
        self.myWebViewCtlr.productURL = @"http://www.apple.com/ipad/";
    } else if ([[self.products objectAtIndex: indexPath.row]  isEqualToString:@"iPod Touch"]){
        self.myWebViewCtlr.productURL = @"http://www.apple.com/ipod-touch/";
    } else if ([[self.products objectAtIndex: indexPath.row]  isEqualToString:@"iPhone"]) {
        self.myWebViewCtlr.productURL = @"http://www.apple.com/iphone/";
    } else if ([[self.products objectAtIndex: indexPath.row]  isEqualToString:@"Galaxy S4"]) {
        self.myWebViewCtlr.productURL = @"http://www.samsung.com/global/microsite/galaxys4/";
    } else if ([[self.products objectAtIndex: indexPath.row]  isEqualToString:@"Galaxy Note"]) {
        self.myWebViewCtlr.productURL = @"http://www.samsung.com/global/microsite/galaxynote/note/index.html?type=find";
    } else if ([[self.products objectAtIndex: indexPath.row]  isEqualToString: @"Galaxy Tab"]) {
        self.myWebViewCtlr.productURL = @"http://www.samsung.com/us/mobile/galaxy-tab/";
    } else if ([[self.products objectAtIndex: indexPath.row]  isEqualToString: @"Lumia 950 XL"]) {
        self.myWebViewCtlr.productURL = @"https://www.microsoft.com/en-us/mobile/phone/lumia950-xl-dual-sim/";
    } else if ([[self.products objectAtIndex: indexPath.row]  isEqualToString: @"Lenovo ideapad MIIX 700"]) {
        self.myWebViewCtlr.productURL = @"http://shop.lenovo.com/us/en/tablets/ideapad/miix/miix-700/";
    } else if ([[self.products objectAtIndex: indexPath.row]  isEqualToString: @"Surface Pro 4"]) {
        self.myWebViewCtlr.productURL = @"http://www.microsoft.com/surface/en-us/devices/surface-pro-4";
    } else if ([[self.products objectAtIndex: indexPath.row]  isEqualToString:@"ZenFone 2E"]) {
        self.myWebViewCtlr.productURL = @"http://www.asus.com/us/Phone/ZenFone-2E-US-ATT-exclusive/";
    } else if ([[self.products objectAtIndex: indexPath.row]  isEqualToString: @"Padfone Infinity"]) {
        self.myWebViewCtlr.productURL =  @"http://www.asus.com/Phone/PadFone-A80/";
    } else if ([[self.products objectAtIndex: indexPath.row]  isEqualToString: @"Eee Slate"]) {
        self.myWebViewCtlr.productURL = @"http://www.asus.com/Tablets/Eee_Slate_EP121/";
    }
    
    // Push the view controller.
    self.myWebViewCtlr.title = [self.products objectAtIndex: indexPath.row];
   
    [self.navigationController pushViewController:self.myWebViewCtlr animated:YES];
    
}
 

@end

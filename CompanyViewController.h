//
//  CompanyViewController.h
//  NavCtrl
//
//  Assignment2.1
//  Replaced UIWebView with WKWebView
//
//
//  Created by Aditya Narayan on 10/22/13.


#import <UIKit/UIKit.h>

@class ProductViewController;

@interface CompanyViewController : UITableViewController

@property (nonatomic, retain) IBOutlet  ProductViewController * productViewController;
@property (nonatomic, retain) NSMutableArray *companyList;

@end

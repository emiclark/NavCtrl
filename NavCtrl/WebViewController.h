//
//  WebViewController.m
//  NavCtrl
// Assignment7-MMM
// Manual Memory Management
//
//  Created by Emiko Clark on 2/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "DAO.h"

@interface WebViewController : UIViewController <UIWebViewDelegate, WKNavigationDelegate>
@property (nonatomic, retain) NSString *productURL;

@end
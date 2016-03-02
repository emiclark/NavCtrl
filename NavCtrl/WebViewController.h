//
//  WebViewController.m
//  NavCtrl
//  ASSIGNMENT4
//  DAO ADD Company + Product
//
//
//  Created by Aditya Narayan on 2/22/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "DAO.h"

@interface WebViewController : UIViewController <UIWebViewDelegate, WKNavigationDelegate>
@property (nonatomic, retain) NSString *productURL;

@end
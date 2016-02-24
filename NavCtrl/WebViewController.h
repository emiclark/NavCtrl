//
//  WebViewController.m
//  NavCtrl
//  Assignment2.1
//  Replaced UIWebView with WKWebView
//
//  Created by Aditya Narayan on 2/22/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate, WKNavigationDelegate>

@property (nonatomic, strong) NSString *productURL;
@end
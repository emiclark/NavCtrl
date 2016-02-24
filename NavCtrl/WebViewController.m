//
//  WebViewController.m
//  NavCtrl
//  Assignment2.1
//  Replaced UIWebView with WKWebView
//
//  Created by Aditya Narayan on 2/22/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "WebViewController.h"
#import "ProductViewController.h"
#import <WebKit/WebKit.h>

@interface WebViewController ()

@property (retain, nonatomic) WKWebView *myWebView;
@property (retain, nonatomic)  WKWebViewConfiguration *myWebViewConfiguration;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"product url:%@", self.productURL);
    
    //init WKWebView
    self.myWebView = [[WKWebView alloc] initWithFrame:self.view.frame];
    
    //convert NSString productURL to a valid URL
    NSURL *url  = [NSURL URLWithString:self.productURL];
    
    //create url request
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    //send url request
    [self.myWebView loadRequest:urlRequest];
    
    //assign view to WKWebView
    self.myWebView.frame = self.view.frame;

//    send request to WKWebView
//    [self.myWebView loadRequest:urlRequest];

    //add webview to view
    [self.view addSubview:self.myWebView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)dealloc {
    [_myWebView release];
    [super dealloc];
}
@end

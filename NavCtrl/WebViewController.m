//
//  WebViewController.m
//  NavCtrl
// Assignment6-SQL
// Integrate SQL
//
//  Created by Emiko Clark on 2/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "WebViewController.h"


@interface WebViewController ()

@property (retain, nonatomic) WKWebView *myWebView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //init WKWebView
    self.myWebView = [[WKWebView alloc] initWithFrame:self.view.frame];
    
    NSURL *url  = [NSURL URLWithString:self.productURL];
    
    //create url request
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    //send url request
    [self.myWebView loadRequest:urlRequest];
    
    //assign view to WKWebView
    self.myWebView.frame = self.view.frame;
    
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

//
//  WebViewController.m
//  NavCtrl
//  ASSIGNMENT3
//
//
//  Created by Aditya Narayan on 2/22/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "WebViewController.h"
#import "ProductViewController.h"
#import <WebKit/WebKit.h>

@interface WebViewController ()

@property (retain, nonatomic) WKWebView *myWebView;
//@property (retain, nonatomic)  WKWebViewConfiguration *myWebViewConfiguration;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //initialize url array for products
    self.appleProductURLs = [[NSMutableArray alloc] initWithObjects:
                                       @"http://www.apple.com/ipad/",
                                       @"http://www.apple.com/ipod-touch/",
                                       @"http://www.apple.com/iphone/", nil];
    
    self.samsungProductURLs = [[NSMutableArray alloc] initWithObjects:
                                         @"http://www.samsung.com/global/microsite/galaxys4/",
                                         @"http://www.samsung.com/global/microsite/galaxynote/note/index.html?type=find",
                                         @"http://www.samsung.com/us/mobile/galaxy-tab/", nil];
    
    self.asusProductURLs =  [[NSMutableArray alloc] initWithObjects:
                                       @"http://www.asus.com/us/Phone/ZenFone-2E-US-ATT-exclusive/",
                                       @"http://www.asus.com/Phone/PadFone-A80/",
                                       @"http://www.asus.com/Tablets/Eee_Slate_EP121/",nil];
    
    self.microsoftProductURLs =  [[NSMutableArray alloc] initWithObjects:
                                        @"https://www.microsoft.com/en-us/mobile/phone/lumia950-xl-dual-sim/",
                                        @"http://shop.lenovo.com/us/en/tablets/ideapad/miix/miix-700/",
                                        @"http://www.microsoft.com/surface/en-us/devices/surface-pro-4",nil];

    NSLog(@"WVC::viewDidLoad: product url:%@, title:%@", self.productURL, self.title);
    
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

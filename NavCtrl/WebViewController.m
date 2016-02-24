//
//  WebViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 2/22/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "WebViewController.h"
#import "ProductViewController.h"

@interface WebViewController ()
@property (retain, nonatomic) IBOutlet UIWebView *myWebView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"product url:%@", self.productURL);
    // Do any additional setup after loading the view.
    //    CGRect screenRect = [[UIScreen mainScreen] bounds];
    //    CGFloat screenHeight = screenRect.size.height;
    //    CGFloat screenWidth = screenRect.size.width;
    //    self.myWebView = [[UIWebView alloc]initWithFrame:screenRect];
    
    //initialize urls arrays for each company's products
    
    //get which product user selected and then dispay web page
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat width = CGRectGetWidth(screen);
    CGFloat height = CGRectGetHeight(screen);
    
    self.myWebView  = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    NSURL *url  = [NSURL URLWithString:self.productURL];
    NSURLRequest *urlRrequest = [[NSURLRequest alloc] initWithURL:url];
    [self.myWebView loadRequest:urlRrequest];
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

@end

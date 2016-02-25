//
//  WebViewController.m
//  NavCtrl
//
//  Assignment2.3
//  Delete Feature
//
//
//  Created by Aditya Narayan on 2/22/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate, WKNavigationDelegate>

@property (nonatomic, strong) NSString *productURL;
@property (nonatomic, strong) NSMutableArray *appleProductURLs;
@property (nonatomic, strong) NSMutableArray *samsungProductURLs;
@property (nonatomic, strong) NSMutableArray *asusProductURLs;
@property (nonatomic, strong) NSMutableArray *microsoftProductURLs;

@end
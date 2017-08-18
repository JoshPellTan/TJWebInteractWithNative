//
//  ViewController.m
//  APPAndH5OrderEachother
//
//  Created by TanJian on 2017/8/18.
//  Copyright © 2017年 Joshpell. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation ViewController

-(UIWebView *)webView{
    
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 50)];
        _webView.delegate = self;
    }
    
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
    NSString * path = [[NSBundle mainBundle] bundlePath];
    NSURL * baseURL = [NSURL fileURLWithPath:path];
    NSString * htmlFile = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSString * htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:(NSUTF8StringEncoding) error:nil];
    [self.webView loadHTMLString:htmlString baseURL:baseURL];
    
    UIButton *addLineBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(_webView.bounds), 80, 50)];
    [addLineBtn addTarget:self action:@selector(addLineAction) forControlEvents:UIControlEventTouchUpInside];
    [addLineBtn setTitle:@"增加一行" forState:UIControlStateNormal];
    [addLineBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:addLineBtn];
    
}

-(void)addLineAction{
    NSString * js = @" var p = document.createElement('p'); p.innerText = 'new Line';document.body.appendChild(p);";
    [self.webView stringByEvaluatingJavaScriptFromString:js];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL * url = [request URL];
    if ([[url scheme] isEqualToString:@"test"]) {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"test" message:[url absoluteString] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        return NO;
    }
    
    return YES;
}

@end

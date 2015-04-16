//
//  P2WebViewController.m
//  WHTGED4U
//
//  Created by Pedro fp on 3/07/13.
//  Copyright (c) 2013 Pedro fp. All rights reserved.
//

#import "P2WebViewController.h"

@interface P2WebViewController ()

@property (strong, nonatomic) NSURLRequest* urlRequest;

@end

@implementation P2WebViewController

- (void)setInfoURLWithString:(NSString*)urlString
{
	[self setUrlRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	[[self webView] loadRequest:[self urlRequest]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tappedActionButton:(id)sender
{
	
}

@end

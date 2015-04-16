//
//  P2AboutViewController.m
//  WHTGED4U
//
//  Created by Pedro fp on 27/06/13.
//  Copyright (c) 2013 Pedro fp. All rights reserved.
//

#import "P2AboutViewController.h"

@interface P2AboutViewController ()

@end

@implementation P2AboutViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
	NSString* urlString = [NSString stringWithFormat:@"%@/about.html", resourcePath];
	NSURL* aboutUrl = [NSURL fileURLWithPath:urlString];
	[[self webView] loadRequest:[NSURLRequest requestWithURL:aboutUrl]];
}

- (IBAction)tappedCloseButton:(id)sender
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType;
{
	if (navigationType != UIWebViewNavigationTypeLinkClicked)
		return YES;
	return ![[UIApplication sharedApplication] openURL:[request URL]];
}

@end

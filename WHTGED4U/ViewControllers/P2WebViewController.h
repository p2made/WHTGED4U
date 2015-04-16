//
//  P2WebViewController.h
//  WHTGED4U
//
//  Created by Pedro fp on 3/07/13.
//  Copyright (c) 2013 Pedro fp. All rights reserved.
//

@interface P2WebViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;

- (void)setInfoURLWithString:(NSString*)urlString;

- (IBAction)tappedActionButton:(id)sender;

@end

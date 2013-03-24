//
//  webViewViewController.h
//  Irregular Verbs
//
//  Created by ZaaB Alonso on 11/18/12.
//
//

#import <UIKit/UIKit.h>

@interface webViewViewController : UIViewController <UIWebViewDelegate>{
    IBOutlet UIWebView *webView;
}
@property (nonatomic,retain)IBOutlet UIWebView *webView;

@end

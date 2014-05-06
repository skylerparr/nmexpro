#include <AD.h>
#import <UIKit/UIKit.h>
#import "include/GADBannerView.h"
#import "include/GADInterstitial.h"
#import "include/GADInterstitialDelegate.h"

namespace nmeExtensions {
    extern "C" void nme_extensions_interstitial_callback();
}

@interface InterstitialDelegate : NSObject <GADInterstitialDelegate>
@end

@implementation InterstitialDelegate

- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
    NSLog(@"received interstitial ad");
}

- (void)interstitial:(GADInterstitial *)ad
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"error: %@", error);
}

- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad {
    NSLog(@"closed interstitial ad");
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)ad {
    NSLog(@"closed interstitial ad");
    nmeExtensions::requestInterstitial();
}

- (void)interstitialWillDismissScreen:(GADInterstitial *)ad {
    NSLog(@"closing interstitial ad");
    nmeExtensions::nme_extensions_interstitial_callback();
}
@end

namespace nmeExtensions {
    extern "C" void nme_extensions_interstitial_callback();
	
    static GADBannerView *bannerView_;
	UIViewController *root;
    static GADInterstitial *interstitial;
    UIViewController *interstitialRoot;
    InterstitialDelegate *interstitalDelegate;
    NSString *interstitalADID;
    
	void initAd(const char *ID,int x, int y, int sizeType=0){
		
		root = [[[UIApplication sharedApplication] keyWindow] rootViewController];
		
		NSString *GADID = [[NSString alloc] initWithUTF8String:ID];
		
		bannerView_ = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait
													 origin:CGPointMake(x,y)];
		bannerView_.adUnitID = GADID;
        
		
		bannerView_.rootViewController = root;
		[bannerView_ loadRequest:[GADRequest request]];
	}
    
    void showAd(){
		[root.view addSubview:bannerView_];
    }
    
    void hideAd(){
		[bannerView_ removeFromSuperview];
    }
    
	void refreshAd(){
		[bannerView_ loadRequest:[GADRequest request]];
	}
    
    void showInterstitial() {
        if([interstitial isReady]) {
            [interstitial presentFromRootViewController:interstitialRoot];
        } else {
            nmeExtensions::nme_extensions_interstitial_callback();
        }
    }
    
    void initInterstitial(const char *ID) {
        interstitalDelegate = [InterstitialDelegate alloc];
        
        interstitialRoot = [[[UIApplication sharedApplication] keyWindow] rootViewController];
        interstitalADID = [[NSString alloc] initWithUTF8String:ID];
        requestInterstitial();
    }
    
    void requestInterstitial() {
        if(interstitial != nil) {
            [interstitial dealloc];
            interstitial = nil;
        }
        interstitial = [[GADInterstitial alloc] init];
        
        interstitial.adUnitID = interstitalADID;
        interstitial.delegate = interstitalDelegate;
        [interstitial loadRequest:[GADRequest request]];
    }
}

phunware-ios-mraid-sdk v0.9 - end user


Requirements:
●	iOS 9.0+
●	Xcode 8.1+
●	Swift 3.0.1+ or Objective-C


Installation:

●CocoaPods
To integrate phunware-ios-mraid-sdk into your Xcode project using CocoaPods, 
Update with instructions

●Carthage
To integrate phunware-ios-mraid-sdk into your Xcode project using Carthage,  
Update with instructions

●Manually
Installation of phunware-ios-sdk can be done manually by building and copying the framework into your project.

Usage:

Usage
Requesting Single Placement
To request a placement, you can build an instance of PlacementRequestConfig and specify the attributes you want to send:

●Retrieving a banner:

Width and height are optional here.  Most of the time the width and height will come from the zone in your Phunware configuration but if that is not set, you may want to set a fallback here.

    let config = PlacementRequestConfig(accountId: 174812, zoneId: 335387, width:320, height:50, customExtras:nil)
        Phunware.requestPlacement(with: config) { response in
            switch response {
            case .success(_ , let placements):
                guard placements.count == 1 else {
                    // error
                    return
                }
                guard placements[0].isValid else {
                    // error
                    return
                    
                    
                }
                self.banner = PWBanner(placement:placements[0], parentViewController:self, position:Positions.BOTTOM_CENTER)
            case .badRequest(let statusCode, let responseBody):
                return
            case .invalidJson(let responseBody):
                return
            case .requestError(let error):
                return
            }
        }

   

●Interstitials:
Your view controller  will need to implement the PWInterstitialDelegate interface to retrieve event information.

These methods are:

    func interstitialReady(_ interstitial: PWInterstitial) {
         print("ready");
    }
    
    func interstitialFailedToLoad(_ interstitial: PWInterstitial) {
        print("failed");
    }
    
    func interstitialClosed(_ interstitial: PWInterstitial) {
        print("close");
    }
    
    func interstitialStartLoad(_ interstitial: PWInterstitial) {
        print("start load");
    }


●Retrieving an interstitial:
  
    let config = PlacementRequestConfig(accountId: 174812, zoneId: 335348, width:nil, height:nil, customExtras:nil)
        Phunware.requestPlacement(with: config) { response in
            switch response {
            case .success(_ , let placements):
                guard placements.count == 1 else {
                    return  // interstitials should currently only return a single ad
                }
                guard placements[0].isValid else {
                    return
                }
                if(placements[0].body != nil && placements[0].body != ""){
                    self.interstitial = PWInterstitial(placement:placements[0], parentViewController:self, delegate:self, respectSafeAreaLayoutGuide:true)
                }
            default:
                return
            }
        }


●Creating an interstitial with 
PWInterstitial(placement, parentViewController, delegate, respectSafeAreaLayoutGuide)
-	placement (as with banners, currently only one placement will be returned from Phunware)
-	parentViewController (The view controller which will contain the interstitial, typically the same controller that retrieves the interstitial placement)
-	delegate (A class that implements the PWInterstitialDelegate interface.  Typically the view controller which retrieves the interstitial)
-	respectSafeAreaLayoutGuide (Some apps may choose to have their layout take into account the safe area layout guide in order to have the status bar showing.  If your app does this, then this setting will tell the interstitial to do the same)

Once retrieved, the interstitialReady function will be called.  After this point you can display the interstitial at any time with:

    interstitial.display();

The interstitial can only been displayed once, after which you must retrieve another one.


●Handling the Response:
Placement(s) request will accept a completion block that is handed an instance of Response, which is a Swift enum that will indicate success or other status for the request.

    Phunware.requestPlacements(with: configs) { response in 
      switch response {  
      case .success(let responseStatus, let placements): // ... 
      case .badRequest(let httpStatusCode, let responseBody): //...
      case .invalidJson(let responseStr): //...
      case .requestError(let error): //..
      }
    }



Handle each case as appropriate for your application. In the case of .success you are given a list of Placement that contains each placement requested.

●Request Pixel:
You can request a pixel simply by giving the URL:
let url: URL

    Phunware.requestPixel(with: url)


●Record Impression:
When you have a Placement, you can record impression by:

    let placement: Placement
    placement.recordImpression()
    
The best practice for recording impressions is to do so when the placement is visible on the screen / has been seen by the user.

●Record Click:
Similarly, you can record click for a Placement:


    let placement: Placement
    placement.recordClick()
    
    
A Note About Objective-C

●An additional alternative callback-based method is provided for Objective-C projects. If you're using this SDK from an Objective-C project, you can request placements like this:


    PlacementRequestConfig *config = [[PlacementRequestConfig alloc] initWithAccountId:174812 zoneId:335342 width:300 height:250 keywords:@[@"sample2"] click:nil];
    [Phunware requestPlacementWithConfig:config success:^(NSString * _Nonnull status, NSArray<Placement *> * _Nonnull placements) {
    // :)
    } failure:^(NSNumber * _Nullable statusCode, NSString * _Nullable responseBody, NSError * _Nullable error) {
    // :(
    }];


●Sample Projects:

Please check out the Swift Sample and ObjC Sample projects inside this repository to see more sample code about how to use this SDK.
License
This SDK is released under the Apache 2.0 license. See LICENSE for more information.

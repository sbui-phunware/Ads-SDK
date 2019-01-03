//
//  ViewController.swift
//  Swift Sample
//

//  Copyright © 2018 Phunware. All rights reserved.
//

import UIKit
import Phunware

class ViewController: UIViewController {
    @IBAction func requestPlacementTapped(_ sender: Any) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let config = PlacementRequestConfig(accountId: 174812, zoneId: 335342, width: 300, height: 250, keywords: ["sample2"])
        Phunware.requestPlacement(with: config) { response in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch response {
            case .success(let status, let placements):
                print(status.rawValue)
                print(placements.map({ $0.debugString }))
                
                guard placements.count == 1 else {
                    return
                }
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                placements[0].getImageView { imageView in
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    var imageViewFrame = imageView.frame
                    imageViewFrame.origin.y = self.view.frame.height - imageViewFrame.size.height - 10
                    imageViewFrame.origin.x = (self.view.frame.width - imageViewFrame.size.width) / 2
                    imageView.frame = imageViewFrame
                    self.view.addSubview(imageView)
                    placements[0].recordImpression()
                }
            case .badRequest(let statusCode, let responseBody):
                print(statusCode ?? -1)
                print(responseBody ?? "<no body>")
            case .invalidJson(let responseBody):
                print(responseBody ?? "<no body>")
            case .requestError(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func requestPlacementsTapped(_ sender: Any) {
        let configs: [PlacementRequestConfig] = [
            PlacementRequestConfig(accountId: 174812, zoneId: 335342, width: 300, height: 250),
            PlacementRequestConfig(accountId: 174812, zoneId: 335342, width: 300, height: 250, keywords: ["sample2"]),
        ]
        Phunware.requestPlacements(with: configs) { response in
            switch response {
            case .success(let status, let placements):
                print(status.rawValue)
                print(placements.map({ $0.debugString }))
            case .badRequest(let statusCode, let responseBody):
                print(statusCode ?? -1)
                print(responseBody ?? "<no body>")
            case .invalidJson(let responseBody):
                print(responseBody ?? "<no body>")
            case .requestError(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func requestPixelTapped(_ sender: Any) {
        guard let url = URL(string: "https://ssp-r.phunware.com/default_banner.gif") else {
            print("Failed in getting a url")
            return
        }
        Phunware.requestPixel(with: url)
    }
    
    @IBAction func recordImpressionTapped(_ sender: Any) {
        let placement = getSamplePlacement()
        placement.recordImpression()
    }
    
    @IBAction func recordClickTapped(_ sender: Any) {
        let placement = getSamplePlacement()
        placement.recordClick()
    }
    
    private func getSamplePlacement() -> Placement {
        return Placement(
            bannerId: 519407754,
            redirectUrl: "https://ssp-r.phunware.com/redirect.spark?MID=153105&plid=550986&setID=214764&channelID=0&CID=0&banID=519407754&PID=0&textadID=0&tc=1&mt=1480778998606477&hc=534448fb7fb5835eaca37f949e61a363d8237324&location=",
            imageUrl: "http://ssp-r.phunware.com/default_banner.gif",
            width: 300,
            height: 250,
            altText: "",
            target: "_blank",
            trackingPixel: "http://ssp-r.phunware.com/default_banner.gif?foo=bar&demo=fakepixel",
            accupixelUrl: "https://ssp-r.phunware.com/adserve.ibs/;ID=153105;size=1x1;type=pixel;setID=214764;plid=550986;BID=519407754;wt=1480779008;rnd=90858")
    }
}

extension Placement {
    var debugString: String {
        return "bannerId: \(bannerId), redirectUrl: \(redirectUrl), imageUrl: \(imageUrl), width: \(width), height: \(height), altText: \(altText), target: \(target), trackingPixel: \(trackingPixel), accupixelUrl: \(accupixelUrl), refreshUrl: \(refreshUrl), refreshTime: \(refreshTime), body: \(body)"
    }
}


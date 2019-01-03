//
//  Placement+Records.swift
//  Phunware
//
//  Copyright © 2018 Phunware. All rights reserved.
//

import Foundation

public extension Placement {
    /// Sends request to record impression for this `Placement`.
    public func recordImpression() {
        if let accupixelUrl = self.accupixelUrl.flatMap({ URL(string: $0) }) {
            Phunware.requestPixel(with: accupixelUrl)
        }
        if let trackingPixel = self.trackingPixel.flatMap({ URL(string: $0) }) {
            Phunware.requestPixel(with: trackingPixel)
        }
    }
    
    /// Sends request to record click for this `Placement`.
    public func recordClick() {
        if let redirectUrl = self.redirectUrl.flatMap({ URL(string: $0) }) {
            Phunware.requestPixel(with: redirectUrl)
        } else {
            print("Cannot construct a valid redirect URL.")
        }
    }
}

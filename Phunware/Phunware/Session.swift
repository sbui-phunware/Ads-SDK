//
//  Session.swift
//  Phunware
//
//  Copyright © 2018 Phunware. All rights reserved.
//

import Foundation

struct Session {
    let urlSession: URLSession
    
    init() {
        let sessionConfig = URLSessionConfiguration.ephemeral
        sessionConfig.httpAdditionalHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "User-Agent": "Phunware/\(PhunwareVersionNumber) (\(UIDevice.deviceModel); \(UIDevice.osVersion))"
        ]
        urlSession = URLSession(configuration: sessionConfig)
    }
}

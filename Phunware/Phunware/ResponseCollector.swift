//
//  ResponseCollector.swift
//  Phunware
//
//  Copyright © 2018 Phunware. All rights reserved.
//

import Foundation

protocol ResponseCollector {
    var responses: [Response] { get }
    var complete: (Response) -> Void { get }
}

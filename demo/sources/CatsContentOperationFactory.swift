//
//  CatsContentOperationFactory.swift
//  HubFrameworkDemo
//
//  Created by krris on 23/10/16.
//  Copyright © 2016 Spotify. All rights reserved.
//

import Foundation
import HubFramework

class CatsContentOperationFactory: NSObject, HUBContentOperationFactory {

    func createContentOperations(forViewURI viewURI: URL) -> [HUBContentOperation] {
        return [CatsContentOperation()]
    }
}

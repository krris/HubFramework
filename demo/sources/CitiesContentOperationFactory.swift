//
//  CitiesContentOperationFactory.swift
//  HubFrameworkDemo
//
//  Created by Krzysztof Werys on 10/11/16.
//  Copyright © 2016 Spotify. All rights reserved.
//

import Foundation
import HubFramework

class CitiesContentOperationFactory: NSObject, HUBContentOperationFactory {

    func createContentOperations(forViewURI viewURI: URL) -> [HUBContentOperation] {
        return [CitiesContentOperation()]
    }
}

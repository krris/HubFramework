//
//  CitiesComponentFactory.swift
//  HubFrameworkDemo
//
//  Created by Krzysztof Werys on 10/11/16.
//  Copyright © 2016 Spotify. All rights reserved.
//

import Foundation
import HubFramework

class CitiesComponentFactory: NSObject, HUBComponentFactory {

    func createComponent(forName name: String) -> HUBComponent? {
        switch name {
        case "row":
            return CitiesRowComponent()
        default:
            return nil
        }
    }
}

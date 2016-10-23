//
//  CatAction.swift
//  HubFrameworkDemo
//
//  Created by krris on 23/10/16.
//  Copyright © 2016 Spotify. All rights reserved.
//

import Foundation
import HubFramework

class CatAction: NSObject, HUBAction {
    static let name = "catAction"
    func perform(with context: HUBActionContext) -> Bool {
        return true
    }
}

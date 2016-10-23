//
//  ActionFactory.swift
//  HubFrameworkDemo
//
//  Created by krris on 23/10/16.
//  Copyright © 2016 Spotify. All rights reserved.
//

import Foundation
import HubFramework

class ActionFactory: NSObject, HUBActionFactory {

    static let namespace = "ActionNamespace"

    public func createAction(forName name: String) -> HUBAction? {
        switch name {
        case CatAction.name:
            return CatAction()
        default:
            return nil
        }
    }
}

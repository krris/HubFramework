//
//  CatsContentOperation.swift
//  HubFrameworkDemo
//
//  Created by krris on 23/10/16.
//  Copyright © 2016 Spotify. All rights reserved.
//

import Foundation
import HubFramework

class CatsContentOperation: NSObject, HUBContentOperation {

    weak var delegate: HUBContentOperationDelegate?

    func perform(forViewURI viewURI: URL,
                 featureInfo: HUBFeatureInfo,
                 connectivityState: HUBConnectivityState,
                 viewModelBuilder: HUBViewModelBuilder,
                 previousError: Error?) {
        viewModelBuilder.navigationBarTitle = "Crazy cats are coming!"

        let cats = ["Pusheen", "Garfield", "Koteczek"]


        for cat in cats {
            let builder = viewModelBuilder.builderForBodyComponentModel(withIdentifier: "cat-\(cat)")
            builder.title = cat
        }

        delegate?.contentOperationDidFinish(self)
    }
}

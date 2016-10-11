//
//  CitiesContentOperation.swift
//  HubFrameworkDemo
//
//  Created by Krzysztof Werys on 10/10/16.
//  Copyright © 2016 Spotify. All rights reserved.
//

import Foundation
import HubFramework

class CitiesContentOperation: NSObject, HUBContentOperation {

    weak var delegate: HUBContentOperationDelegate?

    func perform(forViewURI viewURI: URL,
                 featureInfo: HUBFeatureInfo,
                 connectivityState: HUBConnectivityState,
                 viewModelBuilder: HUBViewModelBuilder,
                 previousError: Error?) {
        // here we create content
        viewModelBuilder.navigationBarTitle = featureInfo.title

        delegate?.contentOperationDidFinish(self)
    }
}

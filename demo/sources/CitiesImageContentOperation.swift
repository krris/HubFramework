//
//  CitiesImageContentOperation.swift
//  HubFrameworkDemo
//
//  Created by Krzysztof Werys on 10/11/16.
//  Copyright © 2016 Spotify. All rights reserved.
//

import Foundation
import HubFramework

class CitiesImageContentOperation: NSObject, HUBContentOperation {
    weak var delegate: HUBContentOperationDelegate?
    
    func perform(forViewURI viewURI: URL, featureInfo: HUBFeatureInfo, connectivityState: HUBConnectivityState, viewModelBuilder: HUBViewModelBuilder, previousError: Error?) {
        guard let jsonURL = Bundle.main.url(forResource: "city-images", withExtension: "json") else { return }
        guard let jsonData = NSData(contentsOf: jsonURL) as? Data else { return }
        viewModelBuilder.addJSONData(jsonData)

        delegate?.contentOperationDidFinish(self)
    }
}

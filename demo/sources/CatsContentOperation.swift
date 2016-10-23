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
    /**
     *  Sent to a content operation whenever an action was performed in the view that it is being used in
     *
     *  @param context The contextual object that the action was performed with
     *  @param viewURI The URI of the view that the action was performed in
     *  @param featureInfo The information for the feature that the action was performed in
     *  @param connectivityState The current connectivity state of the application
     *
     *  The Hub Framework will call this method on your content operation every time that an action was performed
     *  in the view that it is being used in, including both default selection actions & custom ones. You can
     *  use this method to mutate a content operation's state, and then reschedule it to be able to manipulate the
     *  content that is being displayed in the view.
     */
    public func actionPerformed(with context: HUBActionContext, viewURI: URL, featureInfo: HUBFeatureInfo, connectivityState: HUBConnectivityState) {
        
    }


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
            builder.targetBuilder.addAction(withNamespace: ActionFactory.namespace, name: CatAction.name)
            builder.title = cat
        }

        delegate?.contentOperationDidFinish(self)
    }
}

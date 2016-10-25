import Foundation
import HubFramework

class ActionPlaygroundContentOperation: NSObject, HUBContentOperation {
    weak var delegate: HUBContentOperationDelegate?

    func perform(forViewURI viewURI: URL,
                 featureInfo: HUBFeatureInfo,
                 connectivityState: HUBConnectivityState,
                 viewModelBuilder: HUBViewModelBuilder,
                 previousError: Error?) {

        viewModelBuilder.navigationBarTitle = "Action Playground"

        let imageBuilder = viewModelBuilder.builderForBodyComponentModel(withIdentifier: "picture")
        imageBuilder.componentName = DefaultComponentNames.image
        imageBuilder.mainImageURL = URL(string: "https://spotify.github.io/HubFramework/resources/getting-started-zurich.jpg")
        imageBuilder.customData = [ImageComponentCustomDataKeys.fullWidth: true]

        let row = viewModelBuilder.builderForBodyComponentModel(withIdentifier: "row")
        row.componentName = DefaultComponentNames.row
        row.title = "Click me!"

        delegate?.contentOperationDidFinish(self)
    }
}

import Foundation
import HubFramework


struct ActionPlaygroundActionNames {
    static var ping: String { return "ping" }
}

class ActionPlaygroundActionFactory: NSObject, HUBActionFactory {
    static var namespace: String { return "ping-namespace" }

    func createAction(forName name: String) -> HUBAction? {
        // Create an action matching `name`, or return nil if the name is unknown
        if name == ActionPlaygroundActionNames.ping {
            return ActionPlaygroundPingAction()
        }
        return nil
    }
}

import Foundation
import HubFramework

class ActionPlaygroundPingAction: NSObject, HUBAction {
    func perform(with context: HUBActionContext) -> Bool {
        // Perform the action, and return a BOOL indicating whether it was performed or not
        return true
    }
}

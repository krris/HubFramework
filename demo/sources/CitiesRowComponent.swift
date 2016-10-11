//
//  CitiesRowComponent.swift
//  HubFrameworkDemo
//
//  Created by Krzysztof Werys on 10/11/16.
//  Copyright © 2016 Spotify. All rights reserved.
//

import Foundation
import HubFramework

class CitiesRowComponent: NSObject, HUBComponent {
    var view: UIView?

    func loadView() {
        view = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
    }

    var layoutTraits: Set<HUBComponentLayoutTrait> {
        return [.fullWidth, .stackable]
    }

    func preferredViewSize(forDisplaying model: HUBComponentModel, containerViewSize: CGSize) -> CGSize {
        return CGSize(width: containerViewSize.width, height: 50)
    }

    func prepareViewForReuse() {
        guard let cell = view as? UITableViewCell else { return }
        cell.prepareForReuse()
    }

    func configureView(with model: HUBComponentModel, containerViewSize: CGSize) {
        guard let cell = view as? UITableViewCell else { return }
        cell.textLabel?.text = model.title
        cell.detailTextLabel?.text = model.subtitle
    }
}

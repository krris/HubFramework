//
//  CitiesImageComponent.swift
//  HubFrameworkDemo
//
//  Created by Krzysztof Werys on 10/11/16.
//  Copyright © 2016 Spotify. All rights reserved.
//

import Foundation
import HubFramework

class CitiesImageComponent: NSObject, HUBComponentWithImageHandling {

    var view: UIView?

    private lazy var imageView = UIImageView()

    var layoutTraits: Set<HUBComponentLayoutTrait> {
        return [.compactWidth]
    }

    func loadView() {
        imageView.backgroundColor = .lightGray
        view = imageView
    }

    func preferredViewSize(forDisplaying model: HUBComponentModel, containerViewSize: CGSize) -> CGSize {
        let margin: CGFloat = 15
        let width = floor((containerViewSize.width - margin * 3) / 2)
        return CGSize(width: width, height: floor(width * 0.7))
    }

    func prepareViewForReuse() {
        imageView.image = nil
    }

    func configureView(with model: HUBComponentModel, containerViewSize: CGSize) {

    }


    func preferredSizeForImage(from imageData: HUBComponentImageData, model: HUBComponentModel, containerViewSize: CGSize) -> CGSize {
        return preferredViewSize(forDisplaying: model, containerViewSize: containerViewSize)
    }

    func updateView(forLoadedImage image: UIImage, from imageData: HUBComponentImageData, model: HUBComponentModel, animated: Bool) {
        imageView.image = image
    }
}

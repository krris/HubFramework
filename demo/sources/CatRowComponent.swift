//
//  CatRowComponent.swift
//  HubFrameworkDemo
//
//  Created by krris on 23/10/16.
//  Copyright © 2016 Spotify. All rights reserved.
//

import Foundation
import HubFramework

class CatRowComponent: NSObject, HUBComponent {

    var layoutTraits: Set<HUBComponentLayoutTrait> { return [.alwaysStackUpwards] }
    var view: UIView?
    private lazy var cell = UITableViewCell(style: .default, reuseIdentifier: nil)
    
    public func loadView() {
        cell.backgroundColor = UIColor.red
        
        view = cell
    }

    /**
     *  Return the size that the component prefers that it view gets resized to when used for a certain model
     *
     *  @param model The model that the view should reflect
     *  @param containerViewSize The size of the container in which the view will be displayed
     *
     *  The Hub Framework will use the size returned from this method into account when computing the final
     *  frame for the component's view. In most scenarios the size is fully respected, but might be adjusted
     *  depending on the component's `layoutTraits`.
     *
     *  To get notified when the component's view was resized, conform to `HUBComponentViewObserver`.
     */
    public func preferredViewSize(forDisplaying model: HUBComponentModel, containerViewSize: CGSize) -> CGSize {
        return CGSize(width: containerViewSize.width, height: 100)
    }

    /**
     *  Configure the component’s view for displaying data from a model
     *
     *  @param model The new model that the view should reflect
     *  @param containerViewSize The size of the container in which the view will be displayed
     *
     *  This message will also be sent to your component the very first time that is used. Once
     *  this method returns the Hub Framework expects the component to be ready to be displayed
     *  with suitable placeholders used for any remote images that are about to be downloaded.
     */
    public func configureView(with model: HUBComponentModel, containerViewSize: CGSize) {
        cell.textLabel?.text = model.title

    }

    /**
     *  Prepare the component’s view for reuse
     *
     *  The Hub Framework will send this message to your component when it’s about to be reused for
     *  displaying another model. This is the point in time where any state held in the components view
     *  (such as highlighting) should be reset.
     *
     *  Once the view has been prepared for reuse, the Hub Framework will send your component the
     *  `-configureViewForModel:` message, which should be used for data binding.
     */
    public func prepareViewForReuse() {
        cell.prepareForReuse()
    }
}

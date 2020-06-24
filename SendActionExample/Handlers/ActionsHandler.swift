//
//  ActionsHandler.swift
//  SendActionExample
//
//  Created by Dmytro Demchenko on 24.06.2020.
//  Copyright © 2020 Dmytro Demchenko. All rights reserved.
//

import Foundation

@objc protocol ActionsHandler {
    func onBundleVersionAction(_ provider: BundleVersionProvider)
}

@objc protocol BundleVersionProvider: AnyObject {
    var bundleVersion: String { get }
}

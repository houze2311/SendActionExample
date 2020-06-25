//
//  SettingsActionsHandler.swift
//  SendActionExample
//
//  Created by Dmytro Demchenko on 25.06.2020.
//  Copyright © 2020 Dmytro Demchenko. All rights reserved.
//

import Foundation

@objc protocol SettingsActionsHandler {
    func okaySettingsAction(_ provider: SettingsProvider)
    func cancelSettingsAction(_ provider: SettingsProvider)
}

@objc protocol SettingsProvider: AnyObject {
    var text: String { get }
}

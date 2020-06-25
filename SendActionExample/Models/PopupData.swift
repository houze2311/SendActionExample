//
//  PopupData.swift
//  SendActionExample
//
//  Created by Dmytro Demchenko on 25.06.2020.
//  Copyright © 2020 Dmytro Demchenko. All rights reserved.
//

import Foundation

struct PopupData {
    let action: Action
    let title: String
    let subtitle: String
}

extension PopupData {
    
    public enum Action: String {
        case ok, cancel
        
        var action: Selector {
            switch self {
            case .ok:
                return #selector(SettingsActionsHandler.okaySettingsAction)
            case .cancel:
                return #selector(SettingsActionsHandler.cancelSettingsAction)
            }
        }
    }
}

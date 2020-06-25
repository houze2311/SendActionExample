//
//  SettingsPresenter.swift
//  SendActionExample
//
//  Created by Dmytro Demchenko on 25.06.2020.
//  Copyright © 2020 Dmytro Demchenko. All rights reserved.
//

import Foundation

final class SettingsPresenter {
    
    // MARK: - Properties
    private weak var view: SettingsView!
    private var popupData: PopupData!
    
    // MARK: - Init / Deinit methods
    init(with view: SettingsView, popupData: PopupData) {
        self.view = view
        self.popupData = popupData
    }
    
    public func viewDidLoad() {
        view.setupViews(with: popupData)
    }
}

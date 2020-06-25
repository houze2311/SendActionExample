//
//  SettingsModule.swift
//  SendActionExample
//
//  Created by Dmytro Demchenko on 25.06.2020.
//  Copyright © 2020 Dmytro Demchenko. All rights reserved.
//

import Foundation
import UIKit.UIViewController

final class SettingsModule {
    
    // MARK: - Properties
    private let view: SettingsViewController
    private let presenter: SettingsPresenter
    
    // MARK: - Init / Deinit methods
    init(popupData: PopupData) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let identifier = SettingsViewController.identifier
        view = main.instantiateViewController(withIdentifier: identifier) as! SettingsViewController
        
        presenter = SettingsPresenter(with: view, popupData: popupData)
        view.presenter = presenter
    }
    
    // MARK: - Public methods
    func viewController() -> UIViewController {
        return view
    }
}

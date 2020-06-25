//
//  ViewController.swift
//  SendActionExample
//
//  Created by Dmytro Demchenko on 24.06.2020.
//  Copyright © 2020 Dmytro Demchenko. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var popupButton: UIButton!
    @IBOutlet private weak var mvpPopupButton: UIButton!
    @IBOutlet private weak var displayableTextLabel: UILabel!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popupButton.setTitle("MVC popup", for: .normal)
        mvpPopupButton.setTitle("MVP popup", for: .normal)
        
        [popupButton, mvpPopupButton].forEach { $0?.layer.cornerRadius = 2.0 }
    }
}

// MARK: - Private methods
extension ViewController {
    
    private func clearBundleVersion() {
        displayableTextLabel.backgroundColor = .clear
        displayableTextLabel.text = nil
    }
    
    private func popupMVC() -> PopupViewController {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let identifier = PopupViewController.identifier
        guard let popup = main.instantiateViewController(withIdentifier: identifier) as? PopupViewController else {
            preconditionFailure("Can't get PopupViewController")
        }
        
        popup.message = "Bundle version"
        return popup
    }
    
    private func settingsPopup() -> UIViewController {
        let popupData = PopupData(
            action: .ok,
            title: "MVP popup",
            subtitle: "You might be familiar with MVC: The most common application architecture pattern. Whether in mobile web or desktop applications. you can find it everywhere with its three main components (View, Controller, Model).")
    
        return SettingsModule(popupData: popupData).viewController()
    }
}

// MARK: - Actions
extension ViewController {
    
    @IBAction private func showPopupButtonTouchUp(_ sender: UIButton) {
        clearBundleVersion()
        
        var popup: UIViewController!
        
        switch sender {
        case popupButton:
            popup = popupMVC()
        case mvpPopupButton:
            popup = settingsPopup()
        default:
            preconditionFailure("Can't get popup's UIViewController")
        }
        
        present(popup, animated: true, completion: nil)
    }
}

// MARK: - ActionsHandler
extension ViewController: ActionsHandler {
    
    func onBundleVersionAction(_ provider: BundleVersionProvider) {
        displayableTextLabel.text = "bundle version: \(provider.bundleVersion)"
        displayableTextLabel.backgroundColor = .cyan
    }
}

extension ViewController: SettingsActionsHandler {
    
    func okaySettingsAction(_ provider: SettingsProvider) {
        displayableTextLabel.text = "Did tap OKAY: \(provider.text)"
        displayableTextLabel.backgroundColor = .green
    }
    
    func cancelSettingsAction(_ provider: SettingsProvider) {
        displayableTextLabel.text = "Did tap CANCEL: \(provider.text)"
        displayableTextLabel.backgroundColor = .systemRed
    }
}

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
    @IBOutlet private weak var displayableTextLabel: UILabel!
}

// MARK: - Private methods
extension ViewController {
    
    private func clearBundleVersion() {
        displayableTextLabel.backgroundColor = .clear
        displayableTextLabel.text = nil
    }
}

// MARK: - Actions
extension ViewController {
    
    @IBAction private func showPopupButtonTouchUp(_ sender: Any) {
        clearBundleVersion()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let identifier = PopupViewController.identifier
        guard let popup = main.instantiateViewController(withIdentifier: identifier) as? PopupViewController else {
            preconditionFailure("Can't get PopupViewController")
        }
        
        popup.message = "Bundle version"
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

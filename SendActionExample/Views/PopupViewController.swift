//
//  PopupViewController.swift
//  SendActionExample
//
//  Created by Dmytro Demchenko on 24.06.2020.
//  Copyright © 2020 Dmytro Demchenko. All rights reserved.
//

import UIKit

final class PopupViewController: UIViewController, BundleVersionProvider {
    
    // MARK: - Outlets
    @IBOutlet private weak var tapView: UIView!
    @IBOutlet private weak var aboutLabel: UILabel!
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var okayButton: UIButton!
    
    // MARK: - Properties
    public var message: String?
    static let identifier = String(describing: PopupViewController.self)
    private(set) var bundleVersion: String = ""
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        
        aboutLabel.text = message
        okayButton.setTitle("GET", for: .normal)
        
        setupGestureRecognizer()
    }
    
}

// MARK: - Private methods
extension PopupViewController {
    
    private func setupGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(PopupViewController.dismissViewController)
        )
        tapGestureRecognizer.delegate = self
        tapView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func getInfoVersion() {
        guard let bundle = Bundle.main.infoDictionary?[.shortBundleVersion] as? String else {
            preconditionFailure("Can't get bundle version in \(self)")
        }
        
        bundleVersion = bundle
    }
}

// MARK: - Actions
extension PopupViewController {
    
    @objc private func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction private func okayButtonTouchUp(_ sender: Any) {
        getInfoVersion()
        UIApplication.shared.sendAction(#selector(ActionsHandler.onBundleVersionAction),
                                        to: nil,
                                        from: self,
                                        for: nil)
        dismiss(animated: true, completion: nil)
    }
}

extension PopupViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

private extension String {
    static let shortBundleVersion: String = "CFBundleShortVersionString"
}

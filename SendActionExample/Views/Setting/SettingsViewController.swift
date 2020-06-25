//
//  SettingsViewController.swift
//  SendActionExample
//
//  Created by Dmytro Demchenko on 25.06.2020.
//  Copyright © 2020 Dmytro Demchenko. All rights reserved.
//

import UIKit

protocol SettingsView: AnyObject {
    func setupViews(with popupData: PopupData)
}

final class SettingsViewController: UIViewController, SettingsProvider {
    
    // MARK: - Outlets
    @IBOutlet private weak var tapView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var actionButton: UIButton!
    
    // MARK: - Properties
    
    // MARK: - Properties
    var presenter: SettingsPresenter!
    static let identifier = String(describing: SettingsViewController.self)
    private(set) var text: String = ""
    private var popupAction: PopupData.Action!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        
        presenter.viewDidLoad()
        setupGestureRecognizer()
    }
}

// MARK: - SettingsView
extension SettingsViewController: SettingsView {
    
    func setupViews(with popupData: PopupData) {
        titleLabel.text = popupData.title
        subtitleLabel.text = popupData.subtitle
        actionButton.setTitle(popupData.action.rawValue.capitalized, for: .normal)
        popupAction = popupData.action
    }
}

// MARK: - Private methods
extension SettingsViewController {
    
    private func setupGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(SettingsViewController.dismissViewController)
        )
        tapGestureRecognizer.delegate = self
        tapView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func setDisplayableText(for action: PopupData.Action) {
        switch popupAction {
        case .ok:
            text = "OKAY"
        case .cancel:
            text = "CANCEL"
        case .none:
            text = ""
        }
    }
}

// MARK: - Actions
extension SettingsViewController {
    
    @objc private func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction private func okayButtonTouchUp(_ sender: Any) {
        UIApplication.shared.sendAction(popupAction.action, to: nil, from: self, for: nil)
        dismiss(animated: true, completion: nil)
    }
}

extension SettingsViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

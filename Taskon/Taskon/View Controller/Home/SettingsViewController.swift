//
//  SettingsViewController.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 10/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit
import SnapKit


// Rows
enum SettingRow: Int, CaseIterable {
    case appInfo
    case photoSize
    case locationInterval
    case locationAccuracy
    case autoSyncInterval
    case autoSync
    case reminders
    case reminderInterval
    case reminderReitration
    case gadgetInfo
}

class SettingsViewController: AppTableViewController {
    
    
    // MARK: - Class Properties
    
    @IBOutlet private weak var appInfoLabel: UILabel!
    @IBOutlet private weak var locationIntervalTextField: UITextField!
    @IBOutlet private weak var locationAccuracyTextField: UITextField!
    @IBOutlet private weak var autoSynIntervalTextField: UITextField!
    @IBOutlet private weak var reminderIntervalTextField: UITextField!
    @IBOutlet private weak var reminderReitrationTextField: UITextField!
    @IBOutlet private weak var gadgetLabel: UILabel!
    private var settings: Settings = TOUserDefaults.settings.get() ?? Settings()
    
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupNavigationBar()
        setupViewController()
    }
}


// MARK: - Private Methods

extension SettingsViewController {
    
    private func setupNavigationBar() {
        navigationItem.title = "Settings"
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupViewController() {
        appInfoLabel.text = settings.appInfo
        locationIntervalTextField.text = "\(settings.locationCheckInterval)"
        locationAccuracyTextField.text = "\(settings.locationAccuracy)"
        autoSynIntervalTextField.text = "\(settings.autoSyncInterval)"
        reminderIntervalTextField.text = "\(settings.reminderInterval)"
        reminderReitrationTextField.text = "\(settings.reminderReitrationTime)"
        gadgetLabel.text = settings.gadgetId
    }
    
    private func updateSettings() {
        TOUserDefaults.settings.set(value: settings)
    }
    
}


// MARK: - TextField Methods
    
extension SettingsViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let text = textField.text
        
        if textField == locationIntervalTextField {
            settings.locationCheckInterval = Int(text ?? "") ?? settings.locationCheckInterval
            
        } else if textField == locationAccuracyTextField {
            settings.locationAccuracy = Int(text ?? "") ?? settings.locationAccuracy
            
        } else if textField == autoSynIntervalTextField {
            settings.autoSyncInterval = Int(text ?? "") ?? settings.autoSyncInterval
            
        } else if textField == reminderIntervalTextField {
            settings.reminderInterval = Int(text ?? "") ?? settings.reminderInterval
            
        } else if textField == reminderReitrationTextField {
            settings.reminderReitrationTime = Int(text ?? "") ?? settings.reminderReitrationTime
        }
        
        updateSettings()
    }
    
}


// MARK: - TableView Methods
    
extension SettingsViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if let row = SettingRow(rawValue: indexPath.row) {
            switch row {
            case .locationInterval: locationIntervalTextField.becomeFirstResponder()
            case .locationAccuracy: locationAccuracyTextField.becomeFirstResponder()
            case .autoSyncInterval: autoSynIntervalTextField.becomeFirstResponder()
            case .reminderInterval: reminderIntervalTextField.becomeFirstResponder()
            case .reminderReitration: reminderReitrationTextField.becomeFirstResponder()
            default: view.endEditing(true)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}

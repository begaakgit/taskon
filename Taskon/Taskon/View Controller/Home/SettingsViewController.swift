//
//  SettingsViewController.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 10/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit
import SnapKit
import SimpleCheckbox

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
    @IBOutlet private weak var vgaCheckBox: Checkbox!
    @IBOutlet private weak var hdCheckBox: Checkbox!
    @IBOutlet private weak var twoKCheckBox: Checkbox!
    @IBOutlet private weak var syncSwitch: UISwitch!
    @IBOutlet private weak var reminderSwitch: UISwitch!
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
        
        vgaCheckBox.borderCornerRadius = 3.0
        vgaCheckBox.borderLineWidth = 2.0
        vgaCheckBox.borderStyle = .square
        vgaCheckBox.checkmarkStyle = .tick
        vgaCheckBox.checkmarkColor = .mainBlue
        vgaCheckBox.checkmarkSize = 0.75
        vgaCheckBox.isChecked = false
        vgaCheckBox.addTarget(self, action: #selector(checkBoxSelected(_:)), for: .valueChanged)
        
        hdCheckBox.borderCornerRadius = 3.0
        hdCheckBox.borderLineWidth = 2.0
        hdCheckBox.borderStyle = .square
        hdCheckBox.checkmarkStyle = .tick
        hdCheckBox.checkmarkColor = .mainBlue
        hdCheckBox.checkmarkSize = 0.75
        hdCheckBox.isChecked = false
        hdCheckBox.addTarget(self, action: #selector(checkBoxSelected(_:)), for: .valueChanged)
        
        twoKCheckBox.borderCornerRadius = 3.0
        twoKCheckBox.borderLineWidth = 2.0
        twoKCheckBox.borderStyle = .square
        twoKCheckBox.checkmarkStyle = .tick
        twoKCheckBox.checkmarkColor = .mainBlue
        twoKCheckBox.checkmarkSize = 0.75
        twoKCheckBox.isChecked = false
        twoKCheckBox.addTarget(self, action: #selector(checkBoxSelected(_:)), for: .valueChanged)
        
        switch settings.size {
        case .vga: vgaCheckBox.isChecked = true
        case .hd: hdCheckBox.isChecked = true
        case .twoK: twoKCheckBox.isChecked = true
        }
        
        locationIntervalTextField.text = "\(settings.locationCheckInterval)"
        locationAccuracyTextField.text = "\(settings.locationAccuracy)"
        autoSynIntervalTextField.text = "\(settings.autoSyncInterval)"
        syncSwitch.isOn = settings.autoSync
        reminderIntervalTextField.text = "\(settings.reminderInterval)"
        reminderSwitch.isOn = settings.reminder
        reminderReitrationTextField.text = "\(settings.reminderReitrationTime)"
        gadgetLabel.text = settings.gadgetId
    }
    
    private func updateSettings() {
        TOUserDefaults.settings.set(value: settings)
    }
    
}


// MARK: - Action Methods

extension SettingsViewController {
    
    @IBAction private func switchValueChanged(_ sender: UISwitch) {
        if sender == syncSwitch {
            settings.autoSync = sender.isOn
            
        } else if sender == reminderSwitch {
            settings.reminder = sender.isOn
        }
        
        updateSettings()
    }
    
    @objc private func checkBoxSelected(_ sender: Checkbox) {
        if sender == vgaCheckBox {
            hdCheckBox.isChecked = false
            twoKCheckBox.isChecked = false
            settings.size = .vga
            
        } else if sender == hdCheckBox {
            vgaCheckBox.isChecked = false
            twoKCheckBox.isChecked = false
            settings.size = .hd
            
        } else if sender == twoKCheckBox {
            hdCheckBox.isChecked = false
            vgaCheckBox.isChecked = false
            settings.size = .twoK
        }
        
        updateSettings()
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

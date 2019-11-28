//
//  DatePickerViewController.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 09/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit
import JBDatePicker

class DatePickerViewController: AppViewController {
    
    
    // MARK: - Class Properties
    
    @IBOutlet weak var datePickerView: JBDatePickerView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet private weak var continueButton: UIButton!
    public var datePickerCompletion: DateCompletion? = nil
    
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupNavigationBar()
        setupViewController()
    }
}


// MARK: - Private Methods

extension DatePickerViewController {
    
    private func setupNavigationBar() {
        navigationItem.title = "Select Date"
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupViewController() {
        datePickerView.delegate = self
        updateTitleLabel()
        updateDateLabel()
    }
    
    private func updateTitleLabel() {
        let selectedMonth = datePickerView.presentedMonthView.monthDescription
        titleLabel.text = selectedMonth
    }
    
    private func updateDateLabel() {
        let selectedDate = datePickerView.selectedDateView.date ?? Date()
        dateLabel.text = selectedDate.getString(of: .normal)
    }
    
}


// MARK: - Action Methods
    
extension DatePickerViewController {
    
    @IBAction private func continueButtonTapped(_ sender: UIButton) {
        dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            let selectedDate = self.datePickerView.selectedDateView.date ?? Date()
            self.datePickerCompletion?(selectedDate)
        }
    }
}


// MARK: - JBDatePickerView Methods
    
extension DatePickerViewController: JBDatePickerViewDelegate {
    
    func didSelectDay(_ dayView: JBDatePickerDayView) {
        updateDateLabel()
    }
    
    func didPresentOtherMonth(_ monthView: JBDatePickerMonthView) {
        updateTitleLabel()
    }
    
    var shouldShowMonthOutDates: Bool { return false }
    
    var weekDaysViewHeightRatio: CGFloat { return 0.2 }
    
    var colorForDayLabelInMonth: UIColor { return .darkGray }
    
    var colorForDayLabelOutOfMonth: UIColor { return .darkGray }
    
    var colorForSelelectedDayLabel: UIColor { return .white }
    
    var colorForSelectionCircleForOtherDate: UIColor { return .mainBlue }
    
    var selectionShape: JBSelectionShape { return .circle }
    
    var colorForWeekDaysViewBackground: UIColor { return .mainBlue }

}

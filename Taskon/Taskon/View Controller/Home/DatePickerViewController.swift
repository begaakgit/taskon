//
//  DatePickerViewController.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 09/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit
import KDCalendar

class DatePickerViewController: AppViewController {
    
    
    // MARK: - Class Properties
    
    @IBOutlet weak var calendar: CalendarView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet private weak var continueButton: UIButton!
    public var datePickerCompletion: DateCompletion? = nil
    private var selectedDate: Date? = nil
    
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupNavigationBar()
        setupViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        calendar.selectDate(Date())
        calendar.setDisplayDate(Date(), animated: false)
    }
}


// MARK: - Private Methods

extension DatePickerViewController {
    
    private func setupNavigationBar() {
        navigationItem.title = "Select Date"
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupViewController() {
        let style = CalendarView.Style()
        style.cellShape = .round
        style.cellColorDefault = .clear
        style.cellColorToday = .red
        style.cellSelectedBorderColor = .mainBlue
        style.cellEventColor = .green
        style.headerTextColor = .clear
        style.cellTextColorDefault = .darkGray
        style.cellTextColorToday = .white
        style.cellTextColorWeekend = .red
        style.cellColorOutOfRange = .lightGray
        style.headerBackgroundColor = .clear
        style.weekdaysBackgroundColor = .clear
        style.firstWeekday = .monday
        style.locale = Locale.current
        style.timeZone = TimeZone.current
        style.cellFont = .toFront(ofSize: 20)
        style.headerFont = .toFront(ofSize: 22)
        style.weekdaysFont = .toFront(ofSize: 15)
        calendar.style = style
        
        calendar.dataSource = self
        calendar.delegate = self
        
        calendar.direction = .horizontal
        calendar.multipleSelectionEnable = false
        calendar.marksWeekends = true
        
        calendar.backgroundColor = .white
        
        dateLabel.text = Date().getString(of: .normal)
    }
    
}


// MARK: - Action Methods
    
extension DatePickerViewController {
    
    @IBAction private func continueButtonTapped(_ sender: UIButton) {
        dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            let selectedDate = self.selectedDate ?? Date()
            self.datePickerCompletion?(selectedDate)
        }
    }
}


// MARK: - JBDatePickerView Methods

extension DatePickerViewController: CalendarViewDataSource, CalendarViewDelegate {
    
    func startDate() -> Date {
        let today = Date()
        
        var dateComponents = DateComponents()
        dateComponents.year = -100
        let hundredYearsAgo = calendar.calendar.date(byAdding: dateComponents, to: today)
        
        return hundredYearsAgo ?? today
    }
    
    func endDate() -> Date {
        let today = Date()
        
        var dateComponents = DateComponents()
        dateComponents.year = 100
        let hundredYearsAfter = calendar.calendar.date(byAdding: dateComponents, to: today)
        
        return hundredYearsAfter ?? today
    }
    
    func headerString(_ date: Date) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let nameOfMonth = dateFormatter.string(from: date)
        titleLabel.text = nameOfMonth
        return nil
    }
    
    func calendar(_ calendar: CalendarView, didScrollToMonth date: Date) {
        debugPrint(date)
    }
    
    func calendar(_ calendar: CalendarView, didSelectDate date: Date, withEvents events: [CalendarEvent]) {
        selectedDate = date
        dateLabel.text = date.getString(of: .normal)
    }
    
    func calendar(_ calendar: CalendarView, canSelectDate date: Date) -> Bool {
        return true
    }
    
    func calendar(_ calendar: CalendarView, didDeselectDate date: Date) {
        //
    }
    
    func calendar(_ calendar: CalendarView, didLongPressDate date: Date, withEvents events: [CalendarEvent]?) {
        //
    }

}

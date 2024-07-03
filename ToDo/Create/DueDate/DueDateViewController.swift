//
//  DueDateViewController.swift
//  ToDo
//
//  Created by Bora Yang on 7/3/24.
//

import UIKit
import SnapKit

protocol DueDateViewControllerDelegate: AnyObject {
    func setDate(_ date: Date)
}

final class DueDateViewController: BaseViewController2 {
    let datePicker = UIDatePicker()

    weak var delegate: DueDateViewControllerDelegate?

    override func viewWillDisappear(_ animated: Bool) {
        delegate?.setDate(datePicker.date)
    }

    override func configureHierarchy() {
        view.addSubview(datePicker)
    }

    override func configureLayout() {
        datePicker.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }

    override func configureView() {
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
    }
}

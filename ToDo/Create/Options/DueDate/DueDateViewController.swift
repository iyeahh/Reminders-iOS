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

    let descriptionLabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textAlignment = .center
        return label
    }()

    weak var delegate: DueDateViewControllerDelegate?

    let viewModel = DueDateViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        viewModel.outputLable.bind { value in
            self.descriptionLabel.text = value
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        delegate?.setDate(datePicker.date)
    }

    override func configureHierarchy() {
        view.addSubview(datePicker)
        view.addSubview(descriptionLabel)
    }

    override func configureLayout() {
        datePicker.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(datePicker.snp.width)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(datePicker.snp.bottom).offset(10)
        }
    }

    override func configureView() {
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
    }

    @objc private func datePickerValueChanged(_ sender: UIDatePicker) {
        viewModel.inputDatePicker.value = sender.date
    }
}


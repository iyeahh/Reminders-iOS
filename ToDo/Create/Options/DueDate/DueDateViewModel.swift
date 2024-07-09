//
//  DueDateViewModel.swift
//  ToDo
//
//  Created by Bora Yang on 7/9/24.
//

import Foundation

final class DueDateViewModel {
    var inputDatePicker = Observable(Date())
    var outputLable = Observable("")

    init() {
        inputDatePicker.bind { value in
            self.convertDateToString()
        }
    }

    private func convertDateToString() {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier:"ko_KR")
        dateFormatter.dateFormat = "yyyy. MM. dd (E)"
        let str = dateFormatter.string(from: inputDatePicker.value)
        outputLable.value = str
    }
}

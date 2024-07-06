//
//  CellButton.swift
//  ToDo
//
//  Created by Bora Yang on 7/6/24.
//

import UIKit

struct CellButton {
    let color: UIColor
    let title: String
    let image: UIImage?

    static func setCellButton() -> [CellButton] {
        return [
            CellButton(color: .link, title: "오늘", image: UIImage(systemName: "bell.badge.circle.fill")),
            CellButton(color: .red, title: "예정", image: UIImage(systemName: "calendar.circle.fill")),
            CellButton(color: .black, title: "전체", image: UIImage(systemName: "tray.circle.fill")),
            CellButton(color: .orange, title: "깃발 표시", image: UIImage(systemName: "flag.circle.fill")),
            CellButton(color: .gray, title: "완료됨", image: UIImage(systemName: "checkmark.circle.fill"))
        ]
    }
}


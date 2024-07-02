//
//  GrayTextLabel.swift
//  ToDo
//
//  Created by Bora Yang on 7/2/24.
//

import UIKit

class GrayTextLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        font = .systemFont(ofSize: 12)
        numberOfLines = 1
        textColor = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

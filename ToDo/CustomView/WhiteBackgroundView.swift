//
//  WhiteBackgroundView.swift
//  ToDo
//
//  Created by Bora Yang on 7/2/24.
//

import UIKit

class WhiteBackgroundView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

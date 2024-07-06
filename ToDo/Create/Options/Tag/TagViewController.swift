//
//  TagViewController.swift
//  ToDo
//
//  Created by Bora Yang on 7/3/24.
//

import UIKit

protocol TagViewControllerDelegate: AnyObject {
    func setDate(_ text: String?)
}

final class TagViewController: BaseViewController2 {
    let textField = UITextField()

    weak var delegate: TagViewControllerDelegate?

    override func viewWillDisappear(_ animated: Bool) {
        delegate?.setDate(textField.text)
    }

    override func configureHierarchy() {
        view.addSubview(textField)
    }

    override func configureLayout() {
        textField.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(50)
        }
    }

    override func configureView() {
        textField.placeholder = "태그를 입력하세요"
        textField.borderStyle = .roundedRect
    }
}

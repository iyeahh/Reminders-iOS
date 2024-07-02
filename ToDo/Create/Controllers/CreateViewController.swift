//
//  CreateViewController.swift
//  ToDo
//
//  Created by Bora Yang on 7/2/24.
//

import UIKit

final class CreateViewController: BaseViewController {
    private let rootView = CreateRootView()

    override func loadView() {
        view = rootView
    }

    override func configureView() {
        navigationItem.title = "새로운 할 일"
        navigationController?.navigationBar.prefersLargeTitles = false

        let leftBarButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonTapped))

        let rightBarButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addButtonTapped))

        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
    }
}

extension CreateViewController {
    @objc private func cancelButtonTapped() {
        dismiss(animated: true)
    }

    @objc private func addButtonTapped() {
        
    }
}

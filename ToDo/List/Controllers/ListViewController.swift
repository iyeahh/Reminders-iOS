//
//  ListViewController.swift
//  ToDo
//
//  Created by Bora Yang on 7/2/24.
//

import UIKit

final class ListViewController: BaseViewController {
    private let rootView = ListRootView()

    override func loadView() {
        view = rootView
    }

    override func configureView() {
        let barButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonTapped))
        navigationItem.rightBarButtonItem = barButton
        navigationItem.title = "전체"
    }
}

extension ListViewController {
    @objc private func plusButtonTapped() {
        let createVC = UINavigationController(rootViewController: CreateViewController())
        navigationController?.present(createVC, animated: true)
    }
}

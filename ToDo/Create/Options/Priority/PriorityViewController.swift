//
//  PriorityViewController.swift
//  ToDo
//
//  Created by Bora Yang on 7/3/24.
//

import UIKit

protocol PriorityViewControllerDelegate: AnyObject {
    func setDate(_ index: Int)
}

final class PriorityViewController: BaseViewController2 {
    let segement = UISegmentedControl(items: ["높음", "보통", "낮음"])

    weak var delegate: PriorityViewControllerDelegate?

    override func viewWillDisappear(_ animated: Bool) {
        delegate?.setDate(segement.selectedSegmentIndex)
        print(segement.selectedSegmentIndex)
    }

    override func configureHierarchy() {
        view.addSubview(segement)
    }

    override func configureLayout() {
        segement.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(50)
        }
    }
}

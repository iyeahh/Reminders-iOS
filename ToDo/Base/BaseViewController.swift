//
//  BaseViewController.swift
//  ToDo
//
//  Created by Bora Yang on 7/2/24.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        configureView()
    }

    func configureView() { }
}

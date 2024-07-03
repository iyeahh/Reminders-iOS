//
//  CreateViewController.swift
//  ToDo
//
//  Created by Bora Yang on 7/2/24.
//

import UIKit

protocol CreateViewControllerDelegate: AnyObject {
    func createButtonTapped()
}

final class CreateViewController: BaseViewController {
    private let rootView = CreateRootView()

    weak var delegate: CreateViewControllerDelegate?

    override func loadView() {
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.titleTextField.delegate = self
        rootView.memoTextView.delegate = self
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
    }

    override func configureView() {
        navigationItem.title = "새로운 할 일"
        navigationController?.navigationBar.prefersLargeTitles = false

        let leftBarButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonTapped))

        let rightBarButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addButtonTapped))

        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
}

extension CreateViewController {
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }

    @objc func addButtonTapped() {
        let title = rootView.titleTextField.text

        ToDoManager.shared.createMemo(title: title!)
        delegate?.createButtonTapped()
        dismiss(animated: true)
    }
}

extension CreateViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else {
            navigationItem.rightBarButtonItem?.isEnabled = false
            return
        }
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
}

extension CreateViewController: UITextViewDelegate {

}

extension CreateViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CreateTableViewCell.identifier, for: indexPath) as? CreateTableViewCell else {
            return UITableViewCell()
        }

        cell.cellTitleLabel.text = "마감일"
        return cell
    }
}

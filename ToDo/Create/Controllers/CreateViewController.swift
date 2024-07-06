//
//  CreateViewController.swift
//  ToDo
//
//  Created by Bora Yang on 7/2/24.
//

import UIKit
import PhotosUI

protocol CreateViewControllerDelegate: AnyObject {
    func createButtonTapped()
}

final class CreateViewController: BaseViewController {
    private let rootView = CreateRootView()

    private let propertyList = ["마감일", "태그", "우선 순위", "이미지 추가"]

    weak var delegate: CreateViewControllerDelegate?

    var todoModel = ToDoTable(title: "", content: nil, dueDate: nil, tag: nil, priority: nil, isCompleted: false)

    var photo: UIImage?

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
        let content = rootView.memoTextView.text

        ToDoManager.shared.createMemo(
            title: title!,
            content: content,
            dueDate: todoModel.dueDate,
            tag: todoModel.tag,
            priority: todoModel.priority
        )

        guard let todoModelId = ToDoManager.shared.readMemo().last?.id else {
            return
        }

        if let photo = photo {
            saveImageToDocument(image: photo, filename: "\(todoModelId)")
        }

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
        return propertyList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CreateTableViewCell.identifier, for: indexPath) as? CreateTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.cellTitleLabel.text = propertyList[indexPath.row]
        if indexPath.row == 0 {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier:"ko_KR")
            dateFormatter.dateFormat = "yyyy. MM. dd (E)"
            if let date = todoModel.dueDate {
                let str = dateFormatter.string(from: date)
                cell.setDate(text: str, photo: nil)
            } else {
                cell.setDate(text: "", photo: nil)
            }
        } else if indexPath.row == 1 {
            if let tag = todoModel.tag, !tag.isEmpty {
                cell.setDate(text: "#" + tag, photo: nil)
            } else {
                cell.setDate(text: "", photo: nil)
            }
        } else if indexPath.row == 2 {
            if let priority = todoModel.priority {
                if priority == 0 {
                    cell.setDate(text: "높음", photo: nil)
                } else if priority == 1 {
                    cell.setDate(text: "보통", photo: nil)
                } else {
                    cell.setDate(text: "낮음", photo: nil)
                }
            } else {
                cell.setDate(text: "", photo: nil)
            }
        } else if indexPath.row == 3 {
            if let photo = photo {
                cell.setDate(text: "", photo: photo)
            } else {
                cell.setDate(text: "", photo: nil)
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = DueDateViewController()
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 1 {
            let vc = TagViewController()
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 2 {
            let vc = PriorityViewController()
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let picker = {
                var configuration = PHPickerConfiguration()
                configuration.selectionLimit = 1
                configuration.filter = .images
                let picker = PHPickerViewController(configuration: configuration)
                return picker
            }()
            picker.delegate = self
            present(picker, animated: true)
        }
    }
}

extension CreateViewController: DueDateViewControllerDelegate {
    func setDate(_ date: Date) {
        todoModel.dueDate = date
        rootView.tableView.reloadData()
    }
}

extension CreateViewController: TagViewControllerDelegate {
    func setDate(_ text: String?) {
        todoModel.tag = text
        rootView.tableView.reloadData()
    }
}

extension CreateViewController: PriorityViewControllerDelegate {
    func setDate(_ index: Int) {
        todoModel.priority = index
        rootView.tableView.reloadData()
    }
}

extension CreateViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {

        picker.dismiss(animated: true)

        if let itemProvider = results.first?.itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                DispatchQueue.main.async {
                    self.photo = image as? UIImage
                    self.rootView.tableView.reloadData()
                }
            }
        }
    }
}

//
//  DetailViewController.swift
//  ToDo
//
//  Created by Bora Yang on 7/6/24.
//

import UIKit

final class DetailViewController: BaseViewController {
    let rootView = DetailRootView()

    var todoModel: ToDoTable

    init(todo: ToDoTable) {
        self.todoModel = todo
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = false

        if todoModel.isCompleted {
            let barButton = UIBarButtonItem(image: UIImage(systemName: "checkmark.circle.fill"), style: .plain, target: nil, action: nil)
            navigationItem.rightBarButtonItem = barButton
        } else {
            let barButton = UIBarButtonItem(image: UIImage(systemName: "checkmark.circle"), style: .plain, target: nil, action: nil)
            navigationItem.rightBarButtonItem = barButton
        }

        rootView.titleLabel.text = todoModel.title
        rootView.contentLabel.text = todoModel.content
        rootView.dueDateLabel.text = todoModel.dueDate?.description
        rootView.tagLabel.text = todoModel.tag
        rootView.photoImageView.image = loadImageToDocument(filename: "\(todoModel.id)")

        if todoModel.priority == 0 {
            rootView.priorityLabel.text = "높음"
        } else if todoModel.priority == 1 {
            rootView.priorityLabel.text = "보통"
        } else {
            rootView.priorityLabel.text = "낮음"
        }
    }
}

extension DetailViewController: DetailRootViewDelegate {
    func editButtonTapped() {
        let vc = CreateViewController()
        vc.delegate = self
        vc.id = todoModel.id
        vc.todoModel = todoModel
        let navVC = UINavigationController(rootViewController: vc)
        navigationController?.present(navVC, animated: true)
    }
}

extension DetailViewController: CreateViewControllerDelegate {
    func createButtonTapped(todo: ToDoTable) {
        todoModel = todo
    }
}

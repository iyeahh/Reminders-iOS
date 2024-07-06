//
//  DetailViewController.swift
//  ToDo
//
//  Created by Bora Yang on 7/6/24.
//

import UIKit

final class DetailViewController: BaseViewController {
    let rootView = DetailRootView()

    var todo: ToDoTable

    init(todo: ToDoTable) {
        self.todo = todo
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

        if todo.isCompleted {
            let barButton = UIBarButtonItem(image: UIImage(systemName: "checkmark.circle.fill"), style: .plain, target: nil, action: nil)
            navigationItem.rightBarButtonItem = barButton
        } else {
            let barButton = UIBarButtonItem(image: UIImage(systemName: "checkmark.circle"), style: .plain, target: nil, action: nil)
            navigationItem.rightBarButtonItem = barButton
        }

        rootView.titleLabel.text = todo.title
        rootView.contentLabel.text = todo.content
        rootView.dueDateLabel.text = todo.dueDate?.description
        rootView.tagLabel.text = todo.tag
        rootView.photoImageView.image = loadImageToDocument(filename: "\(todo.id)")

        if todo.priority == 0 {
            rootView.priorityLabel.text = "높음"
        } else if todo.priority == 1 {
            rootView.priorityLabel.text = "보통"
        } else {
            rootView.priorityLabel.text = "낮음"
        }
    }
}

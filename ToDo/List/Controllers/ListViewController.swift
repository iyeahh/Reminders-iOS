//
//  ListViewController.swift
//  ToDo
//
//  Created by Bora Yang on 7/2/24.
//

import UIKit
import RealmSwift

final class ListViewController: BaseViewController {
    var todoList: Results<ToDoTable>!
    var filterdList: [ToDoTable] = []
    var naviTitle = ""

    private let rootView = ListRootView()

    override func loadView() {
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = naviTitle
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
        filterdList = Array(todoList)
    }

    override func configureView() {
        let barButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: nil)

        let dueDate = UIAction(title: "마감일 순으로 보기", handler: { _ in self.dueDateFilter()})
        let title = UIAction(title: "제목 순으로 보기", handler: { _ in self.titleFilter() })
        let priority = UIAction(title: "우선순위 높음만 보기", handler: { _ in self.priorityFilter() })
        let buttonMenu = UIMenu(title: "", children: [dueDate, title, priority])

        barButton.menu = buttonMenu
        navigationItem.rightBarButtonItem = barButton
    }

    func dueDateFilter() {
        let result = todoList.where {
            $0.dueDate != nil
        }.sorted {
            $0.dueDate!.description < $1.dueDate!.description
        }

        filterdList = result
        rootView.tableView.reloadData()
    }

    func titleFilter() {
        let result = todoList.sorted {
            $0.title < $1.title
        }

        filterdList = result
        rootView.tableView.reloadData()
    }

    func priorityFilter() {
        let result = todoList.where {
            $0.priority == 0
        }

        filterdList = Array(result)
        rootView.tableView.reloadData()
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterdList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else {
            return UITableViewCell()
        }

        let data = todoList[indexPath.row]
        let image = loadImageToDocument(filename: "\(data.id)")
        cell.callBackMehtod = {
            ToDoManager.shared.updateIsCompleted(data: data)
            tableView.reloadData()
        }
        let data1 = filterdList[indexPath.row]

        cell.setData(data1, image: image)
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ToDoManager.shared.deleteMemo(todoList[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

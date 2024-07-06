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
    var naviTitle = ""

    let realm = try! Realm()

    private let rootView = ListRootView()

    override func loadView() {
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = naviTitle
        todoList = ToDoManager.shared.readMemo()
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
    }

    override func configureView() {
        let barButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = barButton
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else {
            return UITableViewCell()
        }

        let data = todoList[indexPath.row]

        let image = loadImageToDocument(filename: "\(data.id)")
        print(data.id)
        cell.setData(data, image: image)
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ToDoManager.shared.deleteMemo(todoList[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

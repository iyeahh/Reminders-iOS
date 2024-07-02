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
    
    let realm = try! Realm()

    private let rootView = ListRootView()

    override func loadView() {
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        todoList = ToDoManager.shared.readMemo()
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
    }

    override func configureView() {
        let barButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonTapped))
        navigationItem.rightBarButtonItem = barButton
        navigationItem.title = "전체"
    }
}

extension ListViewController {
    @objc private func plusButtonTapped() {
        let vc = CreateViewController()
        vc.delegate = self
        let navVC = UINavigationController(rootViewController: vc)
        navigationController?.present(navVC, animated: true)
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

        cell.setData(data)
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ToDoManager.shared.deleteMemo(todoList[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension ListViewController: CreateViewControllerDelegate {
    func createButtonTapped() {
        todoList = ToDoManager.shared.readMemo()
        rootView.tableView.reloadData()
    }
}

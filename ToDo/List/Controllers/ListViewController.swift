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
        rootView.searchBar.delegate = self
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController(todo: filterdList[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let remove = UIContextualAction(style: .normal, title: "Remove") { [self] (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            ToDoManager.shared.deleteMemo(filterdList[indexPath.row])
            filterdList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            success(true)
        }
        remove.backgroundColor = UIColor.red
        remove.title = "삭제"

        return UISwipeActionsConfiguration(actions:[remove])
    }
}

extension ListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        // 대소문자 구분 없이
        let filter = todoList.where {
            $0.title.contains(searchText, options: .caseInsensitive)
        }

        // 서치바가 비어있을 땐 모든 데이터가 나오게
        let result = searchText.isEmpty ? todoList : filter

        filterdList = Array(result!)
        rootView.tableView.reloadData()
    }
}

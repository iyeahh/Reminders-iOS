//
//  SearchViewController.swift
//  ToDo
//
//  Created by Bora Yang on 7/8/24.
//

import UIKit
import SnapKit
import RealmSwift

final class SearchViewController: BaseViewController2 {
    let searchBar = UISearchBar()
    let tableView = UITableView()
    var list: Results<ToDoTable>!

    override func viewDidLoad() {
        super.viewDidLoad()
        list = ToDoTableRepository.shared.readMemo()
        configureDelegate()
    }

    override func configureHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
    }

    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(10)
            make.top.equalTo(view.safeAreaLayoutGuide)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    override func configureView() {
        navigationItem.title = "할 일 검색"
    }

    private func configureDelegate() {
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let filter = ToDoTableRepository.shared.readMemo().where {
            $0.title.contains(searchText, options: .caseInsensitive)
        }

        let result = searchText.isEmpty ? ToDoTableRepository.shared.readMemo() : filter

        list = result
        tableView.reloadData()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(list.count)
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let data = list[indexPath.row]
        cell.textLabel?.text = data.title + "(\(data.type.first?.name))"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = list[indexPath.row]
        ToDoTableRepository.shared.deleteMemo(data)
    }
}

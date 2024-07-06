//
//  ListRootView.swift
//  ToDo
//
//  Created by Bora Yang on 7/2/24.
//

import UIKit
import SnapKit

final class ListRootView: BaseView {
    let searchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()

    let tableView = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTableView()
    }

    override func configureHierarchy() {
        addSubview(searchBar)
        addSubview(tableView)
    }

    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalTo(safeAreaLayoutGuide)
        }

        tableView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(searchBar.snp.bottom)
        }
    }

    private func configureTableView() {
        tableView.rowHeight = 80
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
    }
}


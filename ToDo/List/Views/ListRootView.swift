//
//  ListRootView.swift
//  ToDo
//
//  Created by Bora Yang on 7/2/24.
//

import UIKit
import SnapKit

final class ListRootView: BaseView {
    let tableView = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTableView()
    }

    override func configureHierarchy() {
        addSubview(tableView)
    }

    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }

    private func configureTableView() {
        tableView.rowHeight = 80
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
    }
}


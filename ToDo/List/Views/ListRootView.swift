//
//  ListRootView.swift
//  ToDo
//
//  Created by Bora Yang on 7/2/24.
//

import UIKit
import SnapKit

final class ListRootView: BaseView {
    private let tableView = UITableView()

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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
    }
}

extension ListRootView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else {
            return UITableViewCell()
        }

        cell.todoTitleLabel.text = "제목"
        cell.memoLabel.text = "메모"
        cell.dueDateLabel.text = "2024. 2. 20."
        return cell
    }
}


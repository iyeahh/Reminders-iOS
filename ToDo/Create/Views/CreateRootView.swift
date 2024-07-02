//
//  CreateRootView.swift
//  ToDo
//
//  Created by Bora Yang on 7/2/24.
//

import UIKit
import SnapKit

final class CreateRootView: BaseView {
    let todoBackgroundView = WhiteBackgroundView()

    let titleTextField = {
        let tf = UITextField()
        tf.placeholder = "제목"
        tf.font = .systemFont(ofSize: 13)
        return tf
    }()

    let barView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        return view
    }()

    let memoTextView = {
        let tv = UITextView()
        tv.text = "메모"
        tv.textColor = .lightGray
        tv.font = .systemFont(ofSize: 13)
        return tv
    }()

    let tableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTableView()
    }

    override func configureView() {
        backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    }

    override func configureHierarchy() {
        addSubview(todoBackgroundView)
        addSubview(titleTextField)
        addSubview(barView)
        addSubview(memoTextView)
        addSubview(tableView)
    }

    override func configureLayout() {
        todoBackgroundView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(safeAreaLayoutGuide).inset(10)
            make.height.equalTo(200)
        }

        titleTextField.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(todoBackgroundView).inset(15)
            make.height.equalTo(20)
        }

        barView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalTo(todoBackgroundView).inset(10)
            make.top.equalTo(titleTextField.snp.bottom).offset(10)
        }

        memoTextView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(todoBackgroundView).inset(10)
            make.top.equalTo(barView.snp.bottom)
        }

        tableView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide).inset(10)
            make.top.equalTo(todoBackgroundView.snp.bottom).offset(10)
        }
    }

    private func configureTableView() {
        tableView.rowHeight = 50
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CreateTableViewCell.self, forCellReuseIdentifier: CreateTableViewCell.identifier)
    }
}

extension CreateRootView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CreateTableViewCell.identifier, for: indexPath) as? CreateTableViewCell else {
            return UITableViewCell()
        }

        cell.cellTitleLabel.text = "마감일"
        return cell
    }
}

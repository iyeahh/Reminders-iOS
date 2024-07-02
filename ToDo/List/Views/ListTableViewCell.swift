//
//  ListTableViewCell.swift
//  ToDo
//
//  Created by Bora Yang on 7/2/24.
//

import UIKit
import SnapKit

final class ListTableViewCell: BaseTableViewCell {
    let todoTitleLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()

    let memoLabel = GrayTextLabel()
    let dueDateLabel = GrayTextLabel()

    override func configureHierarchy() {
        contentView.addSubview(todoTitleLabel)
        contentView.addSubview(memoLabel)
        contentView.addSubview(dueDateLabel)
    }

    override func configureLayout() {
        todoTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(10)
        }

        memoLabel.snp.makeConstraints { make in
            make.top.equalTo(todoTitleLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(20)
        }

        dueDateLabel.snp.makeConstraints { make in
            make.top.equalTo(memoLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(20)
        }
    }
}

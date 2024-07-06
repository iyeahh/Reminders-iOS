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
    let descriptionLabel = GrayTextLabel()

    let photoImageView = UIImageView()

    override func configureHierarchy() {
        contentView.addSubview(todoTitleLabel)
        contentView.addSubview(memoLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(photoImageView)
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

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(memoLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(20)
        }

        photoImageView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(5)
            make.trailing.equalToSuperview().inset(10)
            make.width.equalTo(photoImageView.snp.height)
        }
    }

    func setData(_ data: ToDoTable, image: UIImage?) {
        todoTitleLabel.text = data.title
        memoLabel.text = data.content
        if let tag = data.tag, let dueDate = data.dueDate {
            descriptionLabel.text = dueDate.description + " #" + tag
        } else if let tag = data.tag {
            descriptionLabel.text = "#" + tag
        } else if let dueDate = data.dueDate {
            descriptionLabel.text = dueDate.description
        } else {
            descriptionLabel.text = ""
        }
        guard let image = image else { return }
        photoImageView.image = image
    }
}

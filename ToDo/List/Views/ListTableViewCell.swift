//
//  ListTableViewCell.swift
//  ToDo
//
//  Created by Bora Yang on 7/2/24.
//

import UIKit
import SnapKit

final class ListTableViewCell: BaseTableViewCell {
    let completedButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        button.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .selected)
        button.addTarget(nil, action: #selector(completedButtonTapped), for: .touchUpInside)
        return button
    }()

    let todoTitleLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()

    let memoLabel = GrayTextLabel()
    let descriptionLabel = GrayTextLabel()

    let photoImageView = UIImageView()

    var callBackMehtod: (() -> Void)?

    override func configureHierarchy() {
        contentView.addSubview(completedButton)
        contentView.addSubview(todoTitleLabel)
        contentView.addSubview(memoLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(photoImageView)
    }

    override func configureLayout() {
        completedButton.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(10)
            make.size.equalTo(30)
        }

        todoTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(completedButton.snp.trailing).offset(10)
            make.top.equalToSuperview().offset(10)
        }

        memoLabel.snp.makeConstraints { make in
            make.top.equalTo(todoTitleLabel.snp.bottom).offset(5)
            make.leading.equalTo(completedButton.snp.trailing).offset(10)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(memoLabel.snp.bottom).offset(5)
            make.leading.equalTo(completedButton.snp.trailing).offset(10)
        }

        photoImageView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(5)
            make.trailing.equalToSuperview().inset(10)
            make.width.equalTo(photoImageView.snp.height)
        }
    }

    func setData(_ data: ToDoTable, image: UIImage?) {
        if data.priority == 0 {
            todoTitleLabel.text = "!!!" + data.title
        } else if data.priority == 1 {
            todoTitleLabel.text = "!!" + data.title
        } else {
            todoTitleLabel.text = "!" + data.title
        }
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
        if data.isCompleted {
            completedButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        } else {
            completedButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        }
        guard let image = image else { return }
        photoImageView.image = image
    }

    @objc func completedButtonTapped() {
        callBackMehtod?()
    }
}

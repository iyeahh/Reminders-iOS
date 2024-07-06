//
//  DetailRootView.swift
//  ToDo
//
//  Created by Bora Yang on 7/6/24.
//

import UIKit
import SnapKit

final class DetailRootView: BaseView {
    let titleLabel = UILabel()
    let contentLabel = UILabel()
    let dueDateLabel = UILabel()
    let tagLabel = UILabel()
    let priorityLabel = UILabel()
    let photoImageView = UIImageView()
    let editButton = {
        let button = UIButton()
        button.backgroundColor = .link
        button.setTitle("수정하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()

    override func configureHierarchy() {
        addSubview(titleLabel)
        addSubview(contentLabel)
        addSubview(dueDateLabel)
        addSubview(tagLabel)
        addSubview(priorityLabel)
        addSubview(photoImageView)
        addSubview(editButton)
    }

    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(safeAreaLayoutGuide).inset(10)
        }

        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
        }

        dueDateLabel.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
        }

        tagLabel.snp.makeConstraints { make in
            make.top.equalTo(dueDateLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
        }

        priorityLabel.snp.makeConstraints { make in
            make.top.equalTo(tagLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
        }

        editButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(50)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(20)
        }

        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(priorityLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.bottom.equalTo(editButton.snp.top).inset(10)
        }
    }
}

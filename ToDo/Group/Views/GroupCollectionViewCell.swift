//
//  GroupCollectionViewCell.swift
//  ToDo
//
//  Created by Bora Yang on 7/3/24.
//

import UIKit
import SnapKit

final class GroupCollectionViewCell: UICollectionViewCell {
    private let cellBackgrounView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        return view
    }()

    private let colorBackgroundView = {
        let imageView = UIImageView()
        return imageView
    }()

    private let categoryLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 13)
        label.textColor = .lightGray
        return label
    }()

    private let countLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GroupCollectionViewCell {
    private func configureHierarchy() {
        contentView.addSubview(cellBackgrounView)
        contentView.addSubview(colorBackgroundView)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(countLabel)
    }

    private func configureLayout() {
        cellBackgrounView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        colorBackgroundView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(10)
            make.size.equalTo(30)
        }

        categoryLabel.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(10)
            make.top.equalTo(colorBackgroundView.snp.bottom).offset(10)
        }

        countLabel.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview().inset(15)
        }
    }

    func setIconData(_ data: CellButton, index: Int) {
        colorBackgroundView.image = data.image
        categoryLabel.text = data.title
        colorBackgroundView.tintColor = data.color
        if index == 0 {
            let array = ToDoTableRepository.shared.todayDudDate()
            countLabel.text = "\(array.count)"
        } else if index == 1 {
            let array = ToDoTableRepository.shared.expectedDueDate()
            countLabel.text = "\(array.count)"
        } else if index == 2 {
            let array = ToDoTableRepository.shared.readMemo()
            countLabel.text = "\(array.count)"
        } else if index == 3 {
            let array = ToDoTableRepository.shared.isFlagged()
            countLabel.text = "\(array.count)"
        } else {
            let array = ToDoTableRepository.shared.isCompleted()
            countLabel.text = "\(array.count)"
        }
    }

    func setTypeData(_ data: ToDoType) {
        categoryLabel.text = data.name
        countLabel.text = "\(TypeRepository.shared.fetchTypeName(data.name).count)"
    }
}

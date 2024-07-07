//
//  GroupRootView.swift
//  ToDo
//
//  Created by Bora Yang on 7/3/24.
//

import UIKit
import SnapKit

protocol GroupRootViewDelegate {
    func addToDoButtonTapped()
}

final class GroupRootView: BaseView {
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())

    var addToDoButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.plain()
        configuration.title = "새로운 할 일"
        configuration.buttonSize = .small
        configuration.image = UIImage(systemName: "plus.circle.fill")
        configuration.imagePadding = 8
        button.configuration = configuration
        button.addTarget(nil, action: #selector(addToDoButtonTapped), for: .touchUpInside)
        return button
    }()

    var addListButton = {
        let button = UIButton()
        button.setTitle("목록 추가", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        return button
    }()

    var delegate: GroupRootViewDelegate?

    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.width - 30) / 2
        layout.itemSize = CGSize(width: width, height: width * 0.4)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }

    override func configureHierarchy() {
        addSubview(addToDoButton)
        addSubview(addListButton)
        addSubview(collectionView)
    }

    override func configureLayout() {
        addToDoButton.snp.makeConstraints { make in
            make.leading.bottom.equalTo(safeAreaLayoutGuide).inset(10)
        }

        addListButton.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(safeAreaLayoutGuide).inset(10)
        }

        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(addToDoButton.snp.top)
        }
    }

    override func configureView() {
        backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    }

    @objc private func addToDoButtonTapped() {
        delegate?.addToDoButtonTapped()
    }
}

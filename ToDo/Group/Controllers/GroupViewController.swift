//
//  GroupViewController.swift
//  ToDo
//
//  Created by Bora Yang on 7/3/24.
//

import UIKit

final class GroupViewController: BaseViewController {
    private let rootView = GroupRootView()
    private var iconList: [CellButton] = []

    override func loadView() {
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.delegate = self
        configureCollectionView()
        iconList = CellButton.setCellButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rootView.collectionView.reloadData()
    }

    private func configureCollectionView() {
        rootView.collectionView.backgroundColor =  #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        rootView.collectionView.delegate = self
        rootView.collectionView.dataSource = self
        rootView.collectionView.register(GroupCollectionViewCell.self, forCellWithReuseIdentifier: GroupCollectionViewCell.identifier)
    }

    override func configureView() {
        navigationItem.title = "전체"

        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: nil)
        let leftBarButton = UIBarButtonItem(image: UIImage(systemName: "calendar"), style: .plain, target: self, action: #selector(calendarButtonTapped))
        navigationItem.rightBarButtonItem = rightBarButton
        navigationItem.leftBarButtonItem = leftBarButton
    }

    @objc func calendarButtonTapped() {
        let vc = CalendarViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension GroupViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iconList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GroupCollectionViewCell.identifier, for: indexPath) as? GroupCollectionViewCell else {
            return UICollectionViewCell()
        }
        let data = iconList[indexPath.item]
        cell.setData(data, index: indexPath.item)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ListViewController()
        vc.naviTitle = iconList[indexPath.item].title
        if indexPath.item == 0 {
            let array = ToDoTableRepository.shared.todayDudDate()
            vc.todoList = array
        } else if indexPath.item == 1 {
            let array = ToDoTableRepository.shared.expectedDueDate()
            vc.todoList = array
        } else if indexPath.item == 2 {
            let array = ToDoTableRepository.shared.readMemo()
            vc.todoList = array
        } else if indexPath.item == 3 {
            let array = ToDoTableRepository.shared.isFlagged()
            vc.todoList = array
        } else {
            let array = ToDoTableRepository.shared.isCompleted()
            vc.todoList = array
        }
        navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension GroupViewController: GroupRootViewDelegate {
    func addToDoButtonTapped() {
        let vc = CreateViewController()
        vc.delegate = self
        let navVC = UINavigationController(rootViewController: vc)
        navigationController?.present(navVC, animated: true)
    }
}

extension GroupViewController: CreateViewControllerDelegate {
    func createButtonTapped(todo: ToDoTable) {
        rootView.collectionView.reloadData()
    }
}

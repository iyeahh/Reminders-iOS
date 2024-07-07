//
//  CalendarViewController.swift
//  ToDo
//
//  Created by Bora Yang on 7/7/24.
//

import UIKit
import SnapKit
import FSCalendar
import RealmSwift

final class CalendarViewController: BaseViewController2 {
    private var calendar = FSCalendar()
    private let tableView = UITableView()

    var list: Results<ToDoTable>?

    override func viewDidLoad() {
        super.viewDidLoad()
        configrueFSCalendar()
        configureTableView()
    }

    override func configureHierarchy() {
        view.addSubview(calendar)
        view.addSubview(tableView)
    }

    override func configureLayout() {
        calendar.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(calendar.snp.width)
        }

        tableView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(calendar.snp.bottom)
        }
    }

    override func configureView() {
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    private func configrueFSCalendar() {
        calendar.delegate = self
        calendar.dataSource = self
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 70
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
    }
}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let start = Calendar.current.startOfDay(for: date)
        let end: Date = Calendar.current.date(byAdding: .day, value: 1, to: start) ?? Date()
        let predicate = NSPredicate(format: "dueDate >= %@ && dueDate < %@", start as NSDate, end as NSDate)
        list = ToDoTableRepository.shared.readMemo().filter(predicate)
        tableView.reloadData()
    }
}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let list = list {
            return list.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else {
            return UITableViewCell()
        }
        if let list = list {
            let data = list[indexPath.row]
            cell.setData(data, image: nil)
        }
        return cell
    }
}

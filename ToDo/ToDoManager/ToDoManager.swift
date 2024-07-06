//
//  ToDoManager.swift
//  ToDo
//
//  Created by Bora Yang on 7/2/24.
//

import UIKit
import RealmSwift

final class ToDoManager {
    static let shared = ToDoManager()

    let realm = try! Realm()

    private init() { }

    func createMemo(
        title: String,
        content: String?,
        dueDate: Date?,
        tag: String?,
        priority: Int?
    ) {
        let data = ToDoTable(
            title: title,
            content: content ?? nil,
            dueDate: dueDate ?? nil,
            tag: tag ?? nil,
            priority: priority ?? 1,
            isCompleted: false
        )

        try! realm.write {
            realm.add(data)
            print("Realm Save Succeed")
        }
    }

    func readMemo() -> Results<ToDoTable> {
        return realm.objects(ToDoTable.self)
    }

    func deleteMemo(_ memo: ToDoTable) {
        try! realm.write {
            realm.delete(memo)
        }
    }

    func updateIsCompleted(data: ToDoTable) {
        let value = data.isCompleted ? false: true

        try! realm.write {
            realm.create(
                ToDoTable.self,
                value: ["id": data.id,
                        "isCompleted": value],
                update: .modified
            )
        }
    }

    func todayDudDate() -> Results<ToDoTable> {
        let result = readMemo().where {
            $0.dueDate == Date()
        }
        return result
    }

    func notTodayDueDate() -> Results<ToDoTable> {
        let result = readMemo().where {
            $0.dueDate != Date()
        }
        return result
    }

    func isCompleted() -> Results<ToDoTable> {
        let result = readMemo().where {
            $0.isCompleted == true
        }
        return result
    }
}

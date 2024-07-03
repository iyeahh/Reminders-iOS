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
            priority: priority ?? 1)

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
}

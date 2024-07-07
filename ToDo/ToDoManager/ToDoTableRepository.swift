//
//  ToDoManager.swift
//  ToDo
//
//  Created by Bora Yang on 7/2/24.
//

import UIKit
import RealmSwift

final class ToDoTableRepository {
    static let shared = ToDoTableRepository()

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

        do {
            try realm.write {
                realm.add(data)
            }
        } catch {
            print("Realm Create Error")
        }
    }

    func readMemo() -> Results<ToDoTable> {
        return realm.objects(ToDoTable.self)
    }

    func deleteMemo(_ memo: ToDoTable) {
        do {
            try realm.write {
                realm.delete(memo)
            }
        } catch {
            print("Realm Delete Error")
        }
    }

    func updateIsCompleted(data: ToDoTable) {
        let value = data.isCompleted ? false: true

        do {
            try realm.write {
                realm.create(
                    ToDoTable.self,
                    value: ["id": data.id,
                            "isCompleted": value],
                    update: .modified
                )
            }
        } catch {
            print("Realm Update isCompleted Error")
        }
    }

    func update(id: ObjectId,
                title: String,
                content: String?,
                dueDate: Date?,
                tag: String?,
                priority: Int?
    ) {
        do {
            try realm.write {
                realm.create(
                    ToDoTable.self,
                    value: ["id": id,
                            "title": title,
                            "content": content,
                            "dueDate": dueDate,
                            "tag": tag,
                            "priority": priority
                           ],
                    update: .modified
                )
            }
        } catch {
            print("Realm Update Error")
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

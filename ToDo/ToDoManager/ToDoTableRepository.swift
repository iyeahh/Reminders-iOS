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
            isCompleted: false,
            isFlagged: false
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

    func updateIsFlagged(data: ToDoTable) {
        let value = data.isFlagged ? false: true

        do {
            try realm.write {
                realm.create(
                    ToDoTable.self,
                    value: ["id": data.id,
                            "isFlagged": value],
                    update: .modified
                )
            }
        } catch {
            print("Realm Update isFlagged Error")
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
        let start = Calendar.current.startOfDay(for: Date())
        let end: Date = Calendar.current.date(byAdding: .day, value: 1, to: start) ?? Date()
        let predicate = NSPredicate(format: "dueDate >= %@ && dueDate < %@", start as NSDate, end as NSDate)
        return readMemo().filter(predicate)
    }

    func expectedDueDate() -> Results<ToDoTable> {
        let start = Calendar.current.startOfDay(for: Date())
        let end: Date = Calendar.current.date(byAdding: .day, value: 1, to: start) ?? Date()
        let predicate = NSPredicate(format: "dueDate > %@", end as NSDate)
        return readMemo().filter(predicate)
    }

    func isCompleted() -> Results<ToDoTable> {
        let result = readMemo().where {
            $0.isCompleted == true
        }
        return result
    }

    func isFlagged() -> Results<ToDoTable> {
        let result = readMemo().where {
            $0.isFlagged == true
        }
        return result
    }
}

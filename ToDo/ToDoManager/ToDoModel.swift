//
//  ToDoModel.swift
//  ToDo
//
//  Created by Bora Yang on 7/2/24.
//

import Foundation
import RealmSwift

final class ToDoType: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var regDate: Date
    // 1:n ⭐️
    @Persisted var detail: List<ToDoTable>
}

final class ToDoTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted(indexed: true) var title: String
    @Persisted var content: String?
    @Persisted var dueDate: Date?
    @Persisted var tag: String?
    @Persisted var priority: Int?
    @Persisted var isCompleted: Bool
    @Persisted var isFlagged: Bool

    convenience init(title: String, content: String?, dueDate: Date?, tag: String?, priority: Int?, isCompleted: Bool, isFlagged: Bool) {
        self.init()
        self.title = title
        self.content = content ?? nil
        self.dueDate = dueDate ?? nil
        self.tag = tag ?? nil
        self.priority = priority ?? 1
        self.isCompleted = isCompleted
        self.isFlagged = isFlagged
    }
}

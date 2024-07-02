//
//  ToDoModel.swift
//  ToDo
//
//  Created by Bora Yang on 7/2/24.
//

import Foundation
import RealmSwift

final class ToDoTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted(indexed: true) var title: String
    @Persisted var memo: String?
    @Persisted var dueDate: Date?

    convenience init(title: String, memo: String?, dueDate: Date?) {
        self.init()
        self.title = title
        self.memo = memo ?? nil
        self.dueDate = dueDate ?? nil
    }
}

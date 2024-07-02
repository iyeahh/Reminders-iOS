//
//  ToDoModel.swift
//  ToDo
//
//  Created by Bora Yang on 7/2/24.
//

import Foundation
import RealmSwift

final class ToDoModel: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted(indexed: true) var title: String
    @Persisted var memo: String?
    @Persisted var dueDate: Date?

    convenience init(id: ObjectId, title: String, memo: String? = nil, dueDate: Date? = nil) {
        self.init()
        self.id = id
        self.title = title
        self.memo = memo
        self.dueDate = dueDate
    }
}

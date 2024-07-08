//
//  TypeRepository.swift
//  ToDo
//
//  Created by Bora Yang on 7/8/24.
//

import Foundation
import RealmSwift

final class TypeRepository {
    static let shared = TypeRepository()
    private init() { }

    let realm = try! Realm()

    func fetchType() -> Results<ToDoType> {
        return realm.objects(ToDoType.self)
    }

    func fetchTypeName(_ name: String) -> List<ToDoTable> {
        return fetchType().where {
            $0.name == name
        }.first!.detail
    }

    func createItem(_ data: ToDoTable, type: ToDoType) {
        do {
            try realm.write {
                type.detail.append(data)
                print("Realm Save Succeed")
            }
        } catch {
            print("Realm Error")
        }
    }
}

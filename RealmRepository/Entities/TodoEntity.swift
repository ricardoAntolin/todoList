//
//  TodoEntity.swift
//  todoist
//
//  Created by Ricardo Antolin on 3/6/17.
//  Copyright © 2017 Ricardo Antolin. All rights reserved.
//

import QueryKit
import Domain
import RealmSwift
import Realm

final class TodoEntity: Object {
    dynamic var uid: String = ""
    dynamic var createDate: NSDate = NSDate()
    dynamic var updateDate: NSDate = NSDate()
    dynamic var title: String = ""
    dynamic var content: String = ""
    dynamic var priority: Int = 0
    dynamic var deleted: Bool = false
    dynamic var done: Bool = false
    
    override class func primaryKey() -> String? {
        return "uid"
    }
}

extension TodoEntity: DomainConvertibleType {
    func asDomain() -> TodoModel {
        return TodoModel(uid: uid,
                    createDate: createDate as Date,
                    updateDate: updateDate as Date,
                    title: title,
                    content: content,
                    priority: priority,
                    deleted: deleted,
                    done: done)
    }
}

extension TodoModel: RealmRepresentable {
    func asRealm() -> TodoEntity {
        return TodoEntity.build { object in
            object.uid = uid
            object.createDate = createDate as NSDate
            object.updateDate = updateDate as NSDate
            object.title = title
            object.content = content
            object.priority = priority
            object.deleted = deleted
            object.done = done
        }
    }
}

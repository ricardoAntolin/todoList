//
//  TodoModel.swift
//  todoist
//
//  Created by Ricardo Antolin on 3/6/17.
//  Copyright © 2017 Ricardo Antolin. All rights reserved.
//

import Foundation

public class TodoModel {
    public var uid: String
    public var createDate: Date
    public var updateDate: Date
    public var title: String
    public var content: String
    public var priority: Int
    public var deleted: Bool
    public var done: Bool
    
    public init(uid: String,
                createDate: Date,
                updateDate: Date,
                title: String,
                content: String,
                priority: Int,
                deleted: Bool,
                done: Bool) {
        self.uid = uid
        self.createDate = createDate
        self.updateDate = updateDate
        self.title = title
        self.content = content
        self.priority = priority
        self.deleted = deleted
        self.done = done
    }
    
    public init(){
        self.uid = ""
        self.createDate = Date()
        self.updateDate = Date()
        self.title = ""
        self.content = ""
        self.priority = 0
        self.deleted = false
        self.done = false
    }
}

extension TodoModel: Equatable {
    public static func == (lhs: TodoModel, rhs: TodoModel) -> Bool {
        return lhs.uid == rhs.uid &&
            lhs.createDate == rhs.createDate &&
            lhs.updateDate == rhs.updateDate &&
            lhs.title == rhs.title &&
            lhs.content == rhs.content &&
            lhs.priority == rhs.priority &&
            lhs.deleted == rhs.deleted &&
            lhs.done == rhs.done
    }
}

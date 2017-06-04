//
//  TodoModel.swift
//  todoist
//
//  Created by Ricardo Antolin on 3/6/17.
//  Copyright © 2017 Ricardo Antolin. All rights reserved.
//

import Foundation

public struct TodoModel {
    public let uid: String
    public let createDate: Date
    public let updateDate: Date
    public let title: String
    public let content: String
    public let priority: Int
    public let deleted: Bool
    public let done: Bool
    
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

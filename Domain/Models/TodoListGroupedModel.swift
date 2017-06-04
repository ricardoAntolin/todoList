//
//  TodoListGrouped.swift
//  todoist
//
//  Created by Ricardo Antolin on 3/6/17.
//  Copyright © 2017 Ricardo Antolin. All rights reserved.
//

import Foundation
import RxDataSources

public struct TodoListGroupedModel {
    public var header: String
    public var items: [Item]
    
    public init(header: String, items:[TodoModel]){
        self.header = header
        self.items = items
    }
}

extension TodoListGroupedModel:Equatable {
    public static func == (lhs: TodoListGroupedModel, rhs: TodoListGroupedModel) -> Bool {
        
        guard(lhs.items.count == rhs.items.count) else {
                return false
        }
        
        guard(lhs.items == rhs.items &&
            lhs.header == rhs.header) else {
                return false
        }
        return true
    }
}

extension TodoListGroupedModel: SectionModelType {
    public typealias Item = TodoModel
    
    public init(original: TodoListGroupedModel, items: [Item]) {
        self = original
        self.items = items
    } 
}

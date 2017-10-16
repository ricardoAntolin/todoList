//
//  SaveOrUpdateTodo.swift
//  todoist
//
//  Created by Ricardo Antolin on 3/6/17.
//  Copyright © 2017 Ricardo Antolin. All rights reserved.
//

import Foundation
import Domain
import RxSwift

final class SaveTodoUseCase: Domain.SaveTodoUseCase {
    private let repository: AbstractRepository<TodoModel>
    
    init(repository: AbstractRepository<TodoModel>) {
        self.repository = repository
    }
    
    func saveTodo(todo: TodoModel) -> Observable<Void> {
        let todoEntity = todo.asRealm()
        if todoEntity.uid.isEmpty {
            todoEntity.uid = UUID().uuidString
            todoEntity.createDate = NSDate()
        }
        todoEntity.updateDate = NSDate()
        return repository.save(entity: todoEntity.asDomain())
    }
}

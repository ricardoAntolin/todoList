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
        return repository.save(entity: todo)
    }
}

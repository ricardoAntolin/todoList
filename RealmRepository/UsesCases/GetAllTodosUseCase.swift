//
//  GetAllTodosUseCase.swift
//  todoist
//
//  Created by Ricardo Antolin on 3/6/17.
//  Copyright © 2017 Ricardo Antolin. All rights reserved.
//

import Foundation
import Domain
import RxSwift
import Realm
import RealmSwift

final class GetAllTodosUseCase: Domain.GetAllTodosUseCase {
    private let repository: AbstractRepository<TodoModel>
    
    init(repository: AbstractRepository<TodoModel>) {
        self.repository = repository
    }
    
    func getAllTodos() -> Observable<[TodoListGroupedModel]> {
        return repository.queryAll()
            .map{ todoList in
                return [
                    TodoListGroupedModel(
                        header: "Tasks",
                        items: todoList.filter { !$0.deleted }
                    )
                ]
        }
    }
}

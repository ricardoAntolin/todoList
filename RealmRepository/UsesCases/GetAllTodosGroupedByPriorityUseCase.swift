//
//  GetAllTodosGroupedByPriorityUseCase.swift
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

final class GetAllTodosGroupedByPriorityUseCase: Domain.GetAllTodosGroupedByPriorityUseCase {
    private let repository: AbstractRepository<TodoModel>
    
    init(repository: AbstractRepository<TodoModel>) {
        self.repository = repository
    }
    
    func getAllTodosGroupedByPriority() -> Observable<[TodoListGroupedModel]> {
        return repository.queryAll().map{ todoList in
            var todoListGroupedModel:[TodoListGroupedModel] = []
            var highList: [TodoModel] = []
            var mediumList:[TodoModel] = []
            var lowList: [TodoModel] = []
            
            todoList.forEach{ todo in
                if(todo.priority == 1){
                    mediumList.append(todo)
                }else if (todo.priority == 2){
                    highList.append(todo)
                }else {
                    lowList.append(todo)
                }
            }
            todoListGroupedModel.append(TodoListGroupedModel(header: "High Priority", items: highList))
            todoListGroupedModel.append(TodoListGroupedModel(header: "Medium Priority", items: mediumList))
            todoListGroupedModel.append(TodoListGroupedModel(header: "Low Priority", items: lowList))
            
            return todoListGroupedModel
        }
    }
}

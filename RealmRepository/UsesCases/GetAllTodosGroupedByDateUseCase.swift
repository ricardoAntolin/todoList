//
//  GetAllTodosGroupedByDateUseCase.swift
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

final class GetAllTodosGroupedByDateUseCase: Domain.GetAllTodosGroupedByDateUseCase {
    private let repository: AbstractRepository<TodoModel>
    
    init(repository: AbstractRepository<TodoModel>) {
        self.repository = repository
    }
    
    func getAllTodosGroupedByDate() -> Observable<[TodoListGroupedModel]> {
        return repository.queryAll().map{ todoList in
            var todoListGroupedModel: [TodoListGroupedModel] = []
            var inThePastList: [TodoModel] = []
            var todayList:[TodoModel] = []
            var inTheFutureList: [TodoModel] = []
            
            todoList.forEach{ todo in
                let order = Calendar.current.compare(Date(), to: todo.createDate, toGranularity: .day)
                switch order {
                case .orderedDescending:
                    inThePastList.append(todo)
                case .orderedAscending:
                    inTheFutureList.append(todo)
                case .orderedSame:
                    todayList.append(todo)
                }
            }
            todoListGroupedModel.append(TodoListGroupedModel(header: "Past task", items: inThePastList))
            todoListGroupedModel.append(TodoListGroupedModel(header: "Today task", items: todayList))
            todoListGroupedModel.append(TodoListGroupedModel(header: "Future tasks", items: inTheFutureList))
            
            return todoListGroupedModel
        }
    }
}

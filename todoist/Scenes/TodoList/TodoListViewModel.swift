//
//  TodoListViewModel.swift
//  todoist
//
//  Created by Ricardo Antolin on 3/6/17.
//  Copyright © 2017 Ricardo Antolin. All rights reserved.
//

import Foundation
import Domain
import RxSwift
import RxCocoa

enum GroupTypes{
    case ALL, DATE, PRIORITY
}

final class TodoListViewModel: ViewModelType {
    
    struct Input {
        let trigger: Driver<GroupTypes>
        let createTodoTrigger: Driver<Void>
        let selection: Driver<IndexPath>
        let done: Driver<TodoModel>
    }
    
    struct Output {
        let fetching: Driver<Bool>
        let todoGrouped: Driver<[TodoListGroupedModel]>
        let createTodo: Driver<Void>
        let selectedTodo: Driver<TodoModel>
        let error: Driver<Error>
        let changes: Driver<Void>
    }
    
    private let getAllTodosUseCase: GetAllTodosUseCase
    private let getAllTodosGroupedByDateUseCAse: GetAllTodosGroupedByDateUseCase
    private let getAllTodosGroupedByPriorityUseCAse: GetAllTodosGroupedByPriorityUseCase
    private let saveTodoUseCase: SaveTodoUseCase
    private let navigator: TodoListNavigator
    
    init(getAllTodosUseCase: GetAllTodosUseCase, getAllTodosGroupedByDateUseCAse: GetAllTodosGroupedByDateUseCase, getAllTodosGroupedByPriorityUseCAse: GetAllTodosGroupedByPriorityUseCase, saveTodoUseCase: SaveTodoUseCase, navigator: TodoListNavigator){
        self.getAllTodosUseCase = getAllTodosUseCase
        self.getAllTodosGroupedByDateUseCAse = getAllTodosGroupedByDateUseCAse
        self.getAllTodosGroupedByPriorityUseCAse = getAllTodosGroupedByPriorityUseCAse
        self.saveTodoUseCase = saveTodoUseCase
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        let todoGrouped = input.trigger.flatMapLatest { group -> SharedSequence<DriverSharingStrategy, [TodoListGroupedModel]> in
            switch group {
            case GroupTypes.DATE:
                return self.getAllTodosGroupedByDateUseCAse.getAllTodosGroupedByDate()
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriver(onErrorJustReturn: [TodoListGroupedModel(header: "",items: [])])
            case GroupTypes.PRIORITY:
                return self.getAllTodosGroupedByPriorityUseCAse.getAllTodosGroupedByPriority()
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriver(onErrorJustReturn: [TodoListGroupedModel(header: "",items: [])])
            default:
                return self.getAllTodosUseCase.getAllTodos()
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriver(onErrorJustReturn: [TodoListGroupedModel(header: "",items: [])])
            }
        }
        
        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()
        let selectedTodo = input.selection
            .withLatestFrom(todoGrouped) { (indexPath, todoGrouped) ->  TodoModel in
                return todoGrouped[indexPath.section].items[indexPath.row]
            }
            .do(onNext: navigator.toTodoDetail)
        let createTodo = input.createTodoTrigger
            .do(onNext: navigator.toCreateTodo)
        
        let changes = input.done.flatMapLatest { todo -> SharedSequence<DriverSharingStrategy, Void> in
            print(todo)
            return self.saveTodoUseCase.saveTodo(todo: todo)
                .trackActivity(activityIndicator)
                .trackError(errorTracker)
                .asDriverOnErrorJustComplete()
        }
        
        return Output(fetching: fetching,
                      todoGrouped: todoGrouped,
                      createTodo: createTodo,
                      selectedTodo: selectedTodo,
                      error: errors,
                      changes: changes)
    }
    
    
    
}

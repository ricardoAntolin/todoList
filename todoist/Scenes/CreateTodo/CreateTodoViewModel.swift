//
//  CreateTodoViewModel.swift
//  todoist
//
//  Created by Ricardo Antolin on 4/6/17.
//  Copyright © 2017 Ricardo Antolin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Domain

final class CreatePostViewModel: ViewModelType {
    private let createTodoUseCase: SaveTodoUseCase
    private let getTodoDetailsUseCase: GetTodoDetailsFromUUIDUseCase
    private let navigator: CreateTodoNavigator
    private var todo:TodoModel? = nil
    
    init(createTodoUseCase: SaveTodoUseCase,  getTodoDetailsUseCase: GetTodoDetailsFromUUIDUseCase,navigator: CreateTodoNavigator) {
        self.createTodoUseCase = createTodoUseCase
        self.getTodoDetailsUseCase = getTodoDetailsUseCase
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let todo = input.trigger.flatMapLatest { todoUUID -> Driver<TodoModel?> in
            return self.getTodoDetailsUseCase.findTodoById(id: todoUUID)
                .do( onNext: { (todo) in self.todo = todo } )
                .trackActivity(activityIndicator)
                .trackError(errorTracker)
                .asDriver(onErrorJustReturn: TodoModel())
        }
        
        let todoModel = Driver.combineLatest(input.title, input.details, input.priority, input.done) { (title, details, priority, done) -> TodoModel in
            return TodoModel(uid: self.todo?.uid ?? "",
                      createDate: self.todo?.createDate ?? Date(),
                      updateDate: self.todo?.updateDate ?? Date(),
                      title: title,
                      content: details,
                      priority: Priority(rawValue: priority)?.hashValue ?? 0,
                      deleted: self.todo?.deleted ?? false,
                      done: done)
        }
        
        let canSave = Driver.combineLatest(todoModel, activityIndicator.asDriver()) { (todo, activityIndicator) -> Bool in
            guard self.todo != nil else { return false }
            let comp = (todo == self.todo!)
            return !(comp) && !activityIndicator
        }
        
        
        let save = input.saveTrigger.withLatestFrom(todoModel)
            .flatMapLatest { [unowned self] in
                return self.createTodoUseCase.saveTodo(todo: $0)
                    .trackActivity(activityIndicator)
                    .asDriverOnErrorJustComplete()
        }
        
        let dismiss = Driver.of(save, input.cancelTrigger)
            .merge()
            .do(onNext: navigator.toTodoList )
        
        return Output(dismiss: dismiss, saveEnabled: canSave, todo: todo)
    }
}

extension CreatePostViewModel {
    struct Input {
        let trigger: Driver<String>
        let cancelTrigger: Driver<Void>
        let saveTrigger: Driver<Void>
        let title: Driver<String>
        let details: Driver<String>
        let priority: Driver<String>
        let done: Driver<Bool>
    }
    
    struct Output {
        let dismiss: Driver<Void>
        let saveEnabled: Driver<Bool>
        let todo: Driver<TodoModel?>
    }
}

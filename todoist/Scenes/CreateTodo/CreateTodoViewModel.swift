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
    private let navigator: CreateTodoNavigator
    
    init(createTodoUseCase: SaveTodoUseCase, navigator: CreateTodoNavigator) {
        self.createTodoUseCase = createTodoUseCase
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
        let titleAndDetails = Driver.combineLatest(input.title, input.details) {
            $0
        }
        let activityIndicator = ActivityIndicator()
        
        let canSave = Driver.combineLatest(titleAndDetails, activityIndicator.asDriver()) {
            return !$0.0.isEmpty && !$0.1.isEmpty && !$1
        }
        
        
        let save = input.saveTrigger.withLatestFrom(titleAndDetails)
            .map { (title, content) in
                return TodoModel(uid: UUID().uuidString,
                            createDate: Date(),
                            updateDate: Date(),
                            title: title,
                            content: content,
                            priority: 1,
                            deleted: false,
                            done: false)
            }
            .flatMapLatest { [unowned self] in
                return self.createTodoUseCase.saveTodo(todo: $0)
                    .trackActivity(activityIndicator)
                    .asDriverOnErrorJustComplete()
        }
        
        let dismiss = Driver.of(save, input.cancelTrigger)
            .merge()
            .do(onNext: navigator.toTodoList )
        
        return Output(dismiss: dismiss, saveEnabled: canSave)
    }
}

extension CreatePostViewModel {
    struct Input {
        let cancelTrigger: Driver<Void>
        let saveTrigger: Driver<Void>
        let title: Driver<String>
        let details: Driver<String>
    }
    
    struct Output {
        let dismiss: Driver<Void>
        let saveEnabled: Driver<Bool>
    }
}

//
//  UseCaseProvider.swift
//  todoist
//
//  Created by Ricardo Antolin on 3/6/17.
//  Copyright © 2017 Ricardo Antolin. All rights reserved.
//

import Foundation
import Domain
import Realm
import RealmSwift

public final class UseCaseProvider: Domain.UseCaseProvider {
    private let configuration: Realm.Configuration
    
    public init(configuration: Realm.Configuration = Realm.Configuration()) {
        self.configuration = configuration
    }
    
    public func getAllTodosUseCase() -> Domain.GetAllTodosUseCase {
        let repository = Repository<TodoModel>(configuration: configuration)
        return GetAllTodosUseCase(repository: repository)
    }
    
    public func saveTodoUseCase() -> Domain.SaveTodoUseCase {
        let repository = Repository<TodoModel>(configuration: configuration)
        return SaveTodoUseCase(repository: repository)
    }

    public func getAllTodosGroupedByDateUseCase() -> Domain.GetAllTodosGroupedByDateUseCase {
        let repository = Repository<TodoModel>(configuration: configuration)
        return GetAllTodosGroupedByDateUseCase(repository: repository)
    }
    
    public func getAllTodosGroupedByPriorityUseCase() -> Domain.GetAllTodosGroupedByPriorityUseCase {
        let repository = Repository<TodoModel>(configuration: configuration)
        return GetAllTodosGroupedByPriorityUseCase(repository: repository)
    }
}

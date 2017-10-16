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
    private let repository:Repository<TodoModel>
    
    public init(configuration: Realm.Configuration = Realm.Configuration()) {
        self.configuration = configuration
        self.repository = Repository<TodoModel>(configuration: configuration)
    }
    
    public func getAllTodosUseCase() -> Domain.GetAllTodosUseCase {
        return GetAllTodosUseCase(repository: repository)
    }
    
    public func saveTodoUseCase() -> Domain.SaveTodoUseCase {
        return SaveTodoUseCase(repository: repository)
    }

    public func getAllTodosGroupedByDateUseCase() -> Domain.GetAllTodosGroupedByDateUseCase {
        return GetAllTodosGroupedByDateUseCase(repository: repository)
    }
    
    public func getAllTodosGroupedByPriorityUseCase() -> Domain.GetAllTodosGroupedByPriorityUseCase {
        return GetAllTodosGroupedByPriorityUseCase(repository: repository)
    }
    
    public func getTodoDetailsFromUUIDUseCase() -> Domain.GetTodoDetailsFromUUIDUseCase {
        return GetTodoDetailsFromUUIDUseCase(repository: repository)
    }
}

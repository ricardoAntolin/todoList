//
//  UseCaseProvider.swift
//  todoist
//
//  Created by Ricardo Antolin on 3/6/17.
//  Copyright © 2017 Ricardo Antolin. All rights reserved.
//

import Foundation

public protocol UseCaseProvider {
    
    func getAllTodosUseCase() -> GetAllTodosUseCase
    
    func saveTodoUseCase() -> SaveTodoUseCase
    
    func getAllTodosGroupedByPriorityUseCase() -> GetAllTodosGroupedByPriorityUseCase
    
    func getAllTodosGroupedByDateUseCase() -> GetAllTodosGroupedByDateUseCase
    
    func getTodoDetailsFromUUIDUseCase() -> GetTodoDetailsFromUUIDUseCase

}

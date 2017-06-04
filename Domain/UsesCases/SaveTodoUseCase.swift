//
//  CreateTodoUseCase.swift
//  todoist
//
//  Created by Ricardo Antolin on 3/6/17.
//  Copyright © 2017 Ricardo Antolin. All rights reserved.
//

import Foundation
import RxSwift

public protocol SaveTodoUseCase {
    func saveTodo(todo: TodoModel) -> Observable<Void>
}

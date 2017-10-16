//
//  GetTodoDetailsFromUUIDUseCase.swift
//  Domain
//
//  Created by Ricardo Antolin on 15/10/17.
//  Copyright © 2017 Ricardo Antolin. All rights reserved.
//

import Foundation
import RxSwift

public protocol GetTodoDetailsFromUUIDUseCase {
    func findTodoById(id: String) -> Observable<TodoModel?>
}

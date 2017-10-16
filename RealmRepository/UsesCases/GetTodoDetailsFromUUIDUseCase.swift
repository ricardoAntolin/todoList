//
//  GetTodoDetailsFromUUIDUseCase.swift
//  RealmRepository
//
//  Created by Ricardo Antolin on 15/10/17.
//  Copyright © 2017 Ricardo Antolin. All rights reserved.
//

import Foundation
import Domain
import RxSwift
import Realm
import RealmSwift

final class GetTodoDetailsFromUUIDUseCase : Domain.GetTodoDetailsFromUUIDUseCase {
    private let repository: AbstractRepository<TodoModel>
    
    init(repository: AbstractRepository<TodoModel>) {
        self.repository = repository
    }
    
    func findTodoById(id: String) -> Observable<TodoModel?> {
        return repository.findById(id: id)
    }
}

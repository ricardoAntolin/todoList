//
//  Repository.swift
//  todoist
//
//  Created by Ricardo Antolin on 3/6/17.
//  Copyright © 2017 Ricardo Antolin. All rights reserved.
//

import Foundation
import Foundation
import Realm
import RealmSwift
import RxSwift
import RxRealm

func abstractMethod() -> Never {
    fatalError("abstract method")
}

class AbstractRepository<T> {
    
    func queryAll() -> Observable<[T]> {
        abstractMethod()
    }
    
    func save(entity: T) -> Observable<Void> {
        abstractMethod()
    }
    
    func delete(entity: T) -> Observable<Void> {
        abstractMethod()
    }
}

final class Repository<T:RealmRepresentable>: AbstractRepository<T> where T == T.RealmType.DomainType, T.RealmType: Object {
    private let configuration: Realm.Configuration
    private let scheduler: RunLoopThreadScheduler
    
    private var realm: Realm {
        return try! Realm(configuration: self.configuration)
    }
    
    init(configuration: Realm.Configuration) {
        self.configuration = configuration
        let name = "com.rantolin.todoist.RealmRepository.Repository"
        self.scheduler = RunLoopThreadScheduler(threadName: name)
        print("File url: \(RLMRealmPathForFile("default.realm"))")
    }
    
    override func queryAll() -> Observable<[T]> {
        return Observable.deferred {
            let realm = self.realm
            let objects = realm.objects(T.RealmType.self)
            
            return Observable.array(from: objects)
                .mapToDomain()
            }
            .subscribeOn(scheduler)
    }
    
    override func save(entity: T) -> Observable<Void> {
        return Observable.deferred {
            let realm = self.realm
            return realm.rx.save(entity: entity)
            }.subscribeOn(scheduler)
    }
    
    override func delete(entity: T) -> Observable<Void> {
        return Observable.deferred {
            return self.realm.rx.delete(entity: entity)
            }
            .subscribeOn(scheduler)
    }
    
}

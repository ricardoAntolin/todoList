//
//  RxBus.swift
//  todoist
//
//  Created by Ricardo Antolin on 16/10/17.
//  Copyright © 2017 Ricardo Antolin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class RxBus<T> {
    
    private let bus = PublishSubject<T>.init()
    
    func send(o: T) {
        bus.onNext(o)
    }
    
    func toDriver() -> Driver<T> {
        return bus.asDriverOnErrorJustComplete()
    }
    
    func hasObservers() -> Bool {
        return bus.hasObservers
    }
}

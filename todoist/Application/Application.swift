//
//  Application.swift
//  todoist
//
//  Created by Ricardo Antolin on 3/6/17.
//  Copyright © 2017 Ricardo Antolin. All rights reserved.
//

import Foundation
import Domain
import RealmRepository

final class Application {
    static let shared = Application()
    
    private let realmUseCaseProvider: Domain.UseCaseProvider
    
    private init() {
        self.realmUseCaseProvider = RealmRepository.UseCaseProvider()
    }
    
    func configureMainInterface(in window: UIWindow) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let navigationController = UINavigationController()
        
        let navigator = DefaultTodoNavigator(services: realmUseCaseProvider,
                                             navigationController: navigationController,
                                             storyBoard: storyboard)

        window.rootViewController = navigationController
       
        navigator.toTodoList()
    }
}

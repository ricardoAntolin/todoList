//
//  DefaultNavigator.swift
//  todoist
//
//  Created by Ricardo Antolin on 3/6/17.
//  Copyright © 2017 Ricardo Antolin. All rights reserved.
//

import UIKit
import Domain

protocol TodoListNavigator {
    func toCreateTodo()
    func toTodoDetail(_ todo: TodoModel)
    func toTodoList()
}

class DefaultTodoNavigator: TodoListNavigator {
    private let storyBoard: UIStoryboard
    private let navigationController: UINavigationController
    private let services: UseCaseProvider
    
    init(services: UseCaseProvider,
         navigationController: UINavigationController,
         storyBoard: UIStoryboard) {
        self.services = services
        self.navigationController = navigationController
        self.storyBoard = storyBoard
    }
    
    func toCreateTodo(){
        openTodoDetails(id: nil)

    }
    
    func toTodoDetail(_ todo: TodoModel){
        openTodoDetails(id: todo.uid)
    }
    
    func toTodoList(){
        let vc = storyBoard.instantiateViewController(ofType: TodoListViewController.self)
        vc.viewModel = TodoListViewModel(getAllTodosUseCase: services.getAllTodosUseCase(),
                                         getAllTodosGroupedByDateUseCAse: services.getAllTodosGroupedByDateUseCase(),
                                         getAllTodosGroupedByPriorityUseCAse: services.getAllTodosGroupedByPriorityUseCase(),
                                         saveTodoUseCase: services.saveTodoUseCase(),
                                         navigator: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
    private func openTodoDetails(id: String?) {
        let navigator = DefaultCreateTodoNavigator(navigationController: navigationController)
        let viewModel = CreatePostViewModel(createTodoUseCase: services.saveTodoUseCase(),
                                            getTodoDetailsUseCase: services.getTodoDetailsFromUUIDUseCase(),
                                            navigator: navigator)
        let vc = storyBoard.instantiateViewController(ofType: CreateTodoViewController.self)
        vc.viewModel = viewModel
        if (id != nil) { vc.taskUUID = id! }
        let nc = UINavigationController(rootViewController: vc)
        navigationController.present(nc, animated: true, completion: nil)

    }
}

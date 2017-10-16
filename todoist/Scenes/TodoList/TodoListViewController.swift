//
//  TodoListViewController.swift
//  todoist
//
//  Created by Ricardo Antolin on 3/6/17.
//  Copyright © 2017 Ricardo Antolin. All rights reserved.
//

import UIKit
import Domain
import RxSwift
import RxCocoa
import RxDataSources

class TodoListViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addNewTodo: UIBarButtonItem!
    var viewModel: TodoListViewModel!
    var input: TodoListViewModel.Input?
    private let done = RxBus<TodoModel>()
    private let trigger = RxBus<GroupTypes>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        bindViewModel(groupType: GroupTypes.ALL)
    }
    
    private func configureTableView() {
        tableView.refreshControl = UIRefreshControl()
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    private func bindViewModel(groupType: GroupTypes) {
        assert(viewModel != nil)
        
        input = TodoListViewModel.Input(trigger: trigger.toDriver(),
                                        createTodoTrigger: addNewTodo.rx.tap.asDriver(),
                                        selection: tableView.rx.itemSelected.asDriver(),
                                        done: done.toDriver())
        let output = viewModel.transform(input: input!)
        
        let dataSource = RxTableViewSectionedReloadDataSource<TodoListGroupedModel>()
        
        dataSource.configureCell = { ds, tv, ip, item in
            let cell = (tv.dequeueReusableCell(withIdentifier: TodoTableViewCell.reuseID)
                ?? UITableViewCell(style: .default, reuseIdentifier: TodoTableViewCell.reuseID)) as! TodoTableViewCell
            cell.doneSwitch.isOn = item.done
            cell.lblTitle.text = item.title
            cell.doneSwitch.isOn = item.done
            self.done.send(o: item as TodoModel)
            cell.doneSwitch.rx.isOn.subscribe { isOn in
                item.done = isOn.element ?? false
                self.done.send(o: item as TodoModel)
            }.addDisposableTo(self.disposeBag)
            return cell
        }
        
        
        
        dataSource.titleForHeaderInSection = { ds, index in
            return ds.sectionModels[index].header
        }
        
        output.todoGrouped.drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        output.createTodo.drive().addDisposableTo(disposeBag)
        output.selectedTodo.drive().addDisposableTo(disposeBag)
        
        trigger.send(o: groupType)
    }
    
    @IBAction func byDateButtonTapped(_ sender: Any) {
        trigger.send(o: GroupTypes.DATE)
    }
    
    @IBAction func byPriorityButtonTapped(_ sender: Any) {
        trigger.send(o: GroupTypes.PRIORITY)
    }
    
}

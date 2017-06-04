//
//  CreateTodoViewController.swift
//  todoist
//
//  Created by Ricardo Antolin on 4/6/17.
//  Copyright © 2017 Ricardo Antolin. All rights reserved.
//

import UIKit
import Domain
import RxSwift
import RxCocoa

class CreateTodoViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    var viewModel: CreatePostViewModel!
    @IBOutlet weak var txtDetails: UITextView!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var btnCancel: UIBarButtonItem!
    @IBOutlet weak var btnSave: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let input = CreatePostViewModel.Input(cancelTrigger: btnCancel.rx.tap.asDriver(),
                                              saveTrigger: btnSave.rx.tap.asDriver(),
                                              title: txtTitle.rx.text.orEmpty.asDriver(),
                                              details: txtDetails.rx.text.orEmpty.asDriver())
        
        let output = viewModel.transform(input: input)
        
        output.dismiss.drive()
            .addDisposableTo(disposeBag)
        output.saveEnabled.drive(btnSave.rx.isEnabled)
            .addDisposableTo(disposeBag)
    }
    
}

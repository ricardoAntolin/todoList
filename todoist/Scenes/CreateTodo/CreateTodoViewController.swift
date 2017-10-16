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

class CreateTodoViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    private let disposeBag = DisposeBag()
    var viewModel: CreatePostViewModel!
    var taskUUID: String = ""
    @IBOutlet weak var txtDetails: UITextView!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var btnCancel: UIBarButtonItem!
    @IBOutlet weak var btnSave: UIBarButtonItem!
    @IBOutlet weak var txtPriotity: UITextField!
    @IBOutlet weak var pickerPriority: UIPickerView!
    @IBOutlet weak var switchDone: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let input = CreatePostViewModel.Input(trigger: Driver<String>.just(taskUUID),
                                              cancelTrigger: btnCancel.rx.tap.asDriver(),
                                              saveTrigger: btnSave.rx.tap.asDriver(),
                                              title: txtTitle.rx.text.orEmpty.asDriver(),
                                              details: txtDetails.rx.text.orEmpty.asDriver(),
                                              priority: txtPriotity.rx.text.orEmpty.asDriver(),
                                              done: switchDone.rx.value.asDriver())
        
        let output = viewModel.transform(input: input)
        
        output.dismiss.drive()
            .addDisposableTo(disposeBag)
        output.saveEnabled.drive(btnSave.rx.isEnabled)
            .addDisposableTo(disposeBag)
        output.todo.drive(onNext: {(todo) in self.fillForm(todo: todo)})
            .addDisposableTo(disposeBag)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CreateTodoViewController.dismissPicker))
        view.addGestureRecognizer(tap)
    }
    
    func fillForm(todo: TodoModel?) {
        if((todo) != nil){
            txtTitle.text = todo!.title
            txtTitle.sendActions(for: .editingChanged)
            txtDetails.text = todo!.content
            txtPriotity.text = Priority.fromHashValue(hashValue: todo!.priority).rawValue
            txtPriotity.sendActions(for: .editingChanged)
            switchDone.setOn(todo!.done, animated: true)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Priority.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Priority.fromHashValue(hashValue: row).rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.txtPriotity.text = Priority.fromHashValue(hashValue: row).rawValue
        txtPriotity.sendActions(for: .editingChanged)
        self.pickerPriority.isHidden = true
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.txtPriotity {
            self.pickerPriority.isHidden = false
            textField.endEditing(true)
        } else {
            dismissPicker()
        }
    }
    
    func dismissPicker() {
        self.pickerPriority.isHidden = true
    }
}

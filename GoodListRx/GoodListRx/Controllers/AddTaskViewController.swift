//
//  AddTaskViewController.swift
//  GoodListRx
//
//  Created by Maxim Bekmetov on 26.10.2022.
//

import UIKit
import RxSwift

class AddTaskViewController: UIViewController {

    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var taskTitleTextField: UITextField!

    private let taskSubject = PublishSubject<Task>()
    var taskSubjectObservable: Observable<Task> {
        return taskSubject.asObservable()
    }

    @IBAction func save() {
        guard let priority = Priority(rawValue: self.prioritySegmentedControl.selectedSegmentIndex),
              let title = self.taskTitleTextField.text else {
            return
        }
        let task = Task(title: title, priority: priority)
        taskSubject.onNext(task)

        self.dismiss(animated: true)
    }
}

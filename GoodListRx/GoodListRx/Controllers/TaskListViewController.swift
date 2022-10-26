//
//  TaskListViewController.swift
//  GoodListRx
//
//  Created by Maxim Bekmetov on 26.10.2022.
//

import UIKit
import RxSwift
import RxCocoa

class TaskListViewController: UIViewController {

    @IBOutlet weak var prioritySegmenterdControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!

    private var tasks = BehaviorRelay<[Task]>(value: [])

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navC = segue.destination as? UINavigationController,
              let addTVC = navC.viewControllers.first as? AddTaskViewController else {
            fatalError("Controller not found")
        }
        addTVC.taskSubjectObservable.subscribe(onNext: { task in


            let priority = Priority(rawValue: self.prioritySegmenterdControl.selectedSegmentIndex - 1)

            var existingTasks = self.tasks.value
            existingTasks.append(task)
            self.tasks.accept(existingTasks)
            print(task)
        }).disposed(by: disposeBag)
    }
}

extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath)

        return cell
    }
}

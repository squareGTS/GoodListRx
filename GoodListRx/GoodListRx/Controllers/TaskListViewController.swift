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
    private var filteredTasks = [Task]()

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
        addTVC.taskSubjectObservable.subscribe(onNext: { [unowned self] task in

            let priority = Priority(rawValue: self.prioritySegmenterdControl.selectedSegmentIndex - 1)

            var existingTasks = self.tasks.value
            existingTasks.append(task)
            self.tasks.accept(existingTasks)

            self.filterTask(by: priority)
        }).disposed(by: disposeBag)
    }

    @IBAction func priorityValueChanged(segmentedControl: UISegmentedControl) {
        let priority = Priority(rawValue: segmentedControl.selectedSegmentIndex - 1)
        filterTask(by: priority)
    }

    private func filterTask(by priority: Priority?) {
        if priority == nil {
            self.filteredTasks = self.tasks.value
            self.updateTableView()
        } else {
            self.tasks.map { tasks in
                return tasks.filter { $0.priority == priority! }}.subscribe(onNext: { [weak self] task in self?.filteredTasks = task
                    self?.updateTableView()
                }).disposed(by: disposeBag)
        }
    }
}

extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { self.filteredTasks.count }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath)

        cell.textLabel?.text = self.filteredTasks[indexPath.row].title

        return cell
    }

    private func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

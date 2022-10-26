//
//  TaskListViewController.swift
//  GoodListRx
//
//  Created by Maxim Bekmetov on 26.10.2022.
//

import UIKit

class TaskListViewController: UIViewController {

    @IBOutlet weak var prioritySegmenterdControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!




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

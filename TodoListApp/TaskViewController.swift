//
//  TaskViewController.swift
//  TodoListApp
//
//  Created by Shamanth R on 28/01/25.
//

import UIKit

class TaskViewController: UIViewController {
    
    
    @IBOutlet weak var label: UILabel!
    
    var task: String?
    var taskIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = task
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(deleteTask))
    }
    
    @objc func deleteTask() {
        guard let taskIndex = taskIndex else { return }
        
        let userDefaults = UserDefaults.standard
        guard let count = userDefaults.value(forKey: "count") as? Int else { return }
        
        // Remove the selected task
        userDefaults.removeObject(forKey: "task_\(taskIndex + 1)")
        
        // Reorganize remaining tasks
        for i in (taskIndex + 1)..<count {
            if let nextTask = userDefaults.value(forKey: "task_\(i + 1)") as? String {
                userDefaults.set(nextTask, forKey: "task_\(i)")
            }
        }
        
        // Update the total count
        userDefaults.set(count - 1, forKey: "count")
        userDefaults.removeObject(forKey: "task_\(count)") // Remove the last leftover task
        
        // Go back to the previous screen
        navigationController?.popViewController(animated: true)
    }
}

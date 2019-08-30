//
//  ViewController.swift
//  Todoapp
//
//  Created by CTS-MACMINI-1 on 30/08/19.
//  Copyright © 2019 Cogitate Technology Solutions. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray:[String] = []
    let userData = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = userData.array(forKey: "tododata") as? [String]{
       itemArray = item
        }}

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell",for : indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
        
    }
        else {
    tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    // new entries
    @IBAction func addButtonPressed(_ sender: Any) {
        var addedValue = UITextField()
        let  alert = UIAlertController(title : "Add New Things to do",message: "" ,preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Task", style: .default) { (action) in
            self.itemArray.append(addedValue.text!)
            self.tableView.reloadData()
            self.userData.set(self.itemArray, forKey: "tododata")

        }
        alert.addTextField { (addFeild) in
            addedValue = addFeild
            addFeild.placeholder = "Enter the Task"
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}


//
//  ViewController.swift
//  Todoapp
//
//  Created by Anand Tiwari on 30/08/19.
//  Copyright © 2019 Cogitate Technology Solutions. All rights reserved.
//

import UIKit



class TodoListViewController: UITableViewController{

 let file = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("myList.plist")
    var itemArray = [Datafetch]()
    let userData = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
       loadData()
        
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell",for : indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title

        if (cell.accessoryType == .checkmark){
            print("its chack 1st time")
        }
        print(itemArray[indexPath.row].done)
        cell.accessoryType = itemArray[indexPath.row].done ? .checkmark : .none
        if (cell.accessoryType == .checkmark){
            print("its chack")
        }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].done = !(itemArray[indexPath.row].done)
       saveData()
        
       print("did select call")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    // new entries for alert
    @IBAction func addButtonPressed(_ sender: Any) {
        var addedValue = UITextField()
        let  alert = UIAlertController(title : "Add New Things to do",message: "" ,preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Task", style: .default) { (action) in
            print(addedValue.text!)
            let new = Datafetch()
            new.done = false
            new.title=addedValue.text!
            self.itemArray.append(new)
            self.saveData()
            self.tableView.reloadData()
        }
        alert.addTextField { (addFeild) in
            addedValue = addFeild
            addFeild.placeholder = "Enter the Task"
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    // persisting data
    
    func saveData(){
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: file!)
        }catch{(
            print(error))}
        tableView.reloadData()
    }
    
    func loadData(){
         let data = try? Data(contentsOf : file!)

        let decoder = PropertyListDecoder()
        do{
            itemArray = try decoder.decode([Datafetch].self, from: data!)
        }catch{
            print(error)
        }
    }
    
    
}


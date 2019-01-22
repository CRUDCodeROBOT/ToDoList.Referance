//
//  ViewController.swift
//  Today
//
//  Created by Saiyan on 2019/01/18.
//  Copyright © 2019 Rob. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController{

    
    let itemArray = ["Find 1","Find 2","find 3"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
    
        return cell
        
    }
    
    //MARK - TableVIew Delegate Method
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    print(itemArray[indexPath.item])
print(itemArray[indexPath.row])
    
    
    if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
    {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    } else {tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    
    
    tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK - Add New Item
    
    
    }
    @IBAction func addButtonPressed(_ sender: Any) {
    }
}




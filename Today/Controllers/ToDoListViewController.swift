//
//  ViewController.swift
//  Today
//
//  Created by Saiyan on 2019/01/18.
//  Copyright © 2019 Rob. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController{
    
    
    //  var itemArray = ["Past","Present","Future"]
    // Item data to replace item Array
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let newItem = Item()
        newItem.title = "Past"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem.title = "Present"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem.title = "Future"
        itemArray.append(newItem3)
        
        //   if let
        //        items = defaults.array(forKey: "ToDoListArray") as? [String]
        //
        //   {itemArray = items}
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        // set cell text lable text property, itemArray returns an item object. tap into tital property with dot notation eg. .title
        //        cell.textLabel?.text = itemArray[indexPath.row]
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        //        cell.textLabel?.text = itemArray[indexPath.row].title
        
        
        // update on if statement for checkmark and as above "let item" to reduce code
        /* Ternary operator ==> value = condition ? valueIfTrue : valueIfFalse
         cell.accessoryType = item.done == true ? .checkmark : .none
         // also can remove == true
         */
        
        if item.done == true {
            //        if itemArray[indexPath.row].done == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    //MARK - TableVIew Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //    print(itemArray[indexPath.item])
        // print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        //above improves on the below
        /*
         if itemArray[indexPath.row].done == false {
         itemArray[indexPath.row].done = true
         } else {
         itemArray[indexPath.row].done = false
         }
         */
        
        // ----------------------------------------------------------------------
        // old checkmark-if statement check
        /*
         if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
         {
         tableView.cellForRow(at: indexPath)?.accessoryType = .none
         } else {tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
         */
        
        // starting data not loading before checkmark is done
        // push to reload data
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK - Add New Item
        @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //will happen once item is added
            
            //   print("Success!")
            //print(textField.txt)
            
            let newItem = Item()
            newItem.title = textField.text!
            //self.itemArray.append(textField.text!)
            
            self.itemArray.append(newItem)
            //self.itemArray.append(textField.txt)
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Creat new Item"
            // add text to local var, ie. extend the scope of var in the closure
            textField = alertTextField
            
            
            alert.addAction(action)
            // print(alertText.txt)
        }
        present(alert, animated: true, completion: nil)
    }
    
}




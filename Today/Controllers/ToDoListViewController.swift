//
//  ViewController.swift
//  Today
//
//  Created by Saiyan on 2019/01/18.
//  Copyright © 2019 Rob. All rights reserved.

import UIKit
import CoreData

class ToDoListViewController: UITableViewController{
    
    //  var itemArray = ["Past","Present","Future"]
    // Item data to replace item Array
    var itemArray = [Item]()
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    // let dataFilePath replaces the default singleton
    // let defaults = UserDefaults.standard
    
    // no longer using
    // let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // show data file
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        //   print(dataFilePath)
        /*
         let newItem = Item()
         newItem.title = "Past"
         itemArray.append(newItem)
         
         let newItem2 = Item()
         newItem2.title = "Present"
         itemArray.append(newItem2)
         
         let newItem3 = Item()
         newItem3.title = "Future"
         itemArray.append(newItem3)
         */
        // refactored above in selectedCategory
        //   loadItems()
        
        //           if let items = defaults.array(forKey: "ToDoListArray") as? [Item]
        //         {itemArray = items}
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
        cell.accessoryType = item.done ? .checkmark : .none
        
//        if item.done == true {
//            //        if itemArray[indexPath.row].done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        return cell
    }
    
    //MARK - TableVIew Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //    print(itemArray[indexPath.item])
        // print(itemArray[indexPath.row])
        
        //will delete once completed apposed to marking as true or false
        
        //   context.delete(itemArray[indexPath.row])
        //  itemArray.remove(at: indexPath.row)
        
        
        // toggle done status from true to false
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
        
        // save method called
        saveItems()
        
        // starting data not loading before checkmark is done
        // push to reload data
        //reload data func is called in above save method
        // tableView.reloadData()
        
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
            
            //  let newItem = Item() - item.swift file removed and renamed to OLDItem
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            //self.itemArray.append(textField.text!)
            newItem.done = false
            // added from CategoryViewController and data parent link
            newItem.parentCategory = self.selectedCategory
            self.itemArray.append(newItem)
            //self.itemArray.append(textField.txt)
            
            /*
             // moved over to save Method ie. saved method called below to replace code
             
             let encoder = PropertyListEncoder()
             do {
             let data = try encoder.encode(self.itemArray)
             try data.write(to: self.dataFilePath!)
             } catch {
             print("Error encoding item array, \(error)")
             }
             // removed as data file path above replaces defaults
             //    self.defaults.set(self.itemArray, forKey: "ToDoListArray")
             self.tableView.reloadData()
             */
            // save method
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Creat new Item"
            // add text to local var, ie. extend the scope of var in the closure
            textField = alertTextField
            
            // print(alertText.txt)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

//MARK - Model Manupulation Methods
func saveItems() {
    // no longer using coder
    // let encoder = PropertyListEncoder()
    do {
        try context.save()
        
        //     let data = try encoder.encode(itemArray)
        //     try data.write(to: dataFilePath!)
    } catch {
        print("Error saving item, \(error)")
    }
    // removed as data file path above replaces defaults
    //    self.defaults.set(self.itemArray, forKey: "ToDoListArray")
    
    self.tableView.reloadData()
}
func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
    let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
    if let additonalPredicate = predicate {request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additonalPredicate])} else {
        request.predicate = categoryPredicate
    }
    // optional binding as above
    //    let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicatece])
    //    request.predicate = compoundPredicate
    
    // refactored into defualt value as above
    //  let request : NSFetchRequest<Item> = Item.fetchRequest()
    do {
        itemArray = try context.fetch(request)
    } catch {
        print("Error Fetching data from context \(error)")
        // replaced with READ CRUD object
        /*
         if let data = try? Data(contentsOf: dataFilePath!) {
         let decoder = PropertyListDecoder()}
         do {
         itemArray = try decoder.decode([Item].self, from: data)
         catch {
         print("Error decoding item array, \(error)")
         */
    }
    tableView.reloadData()
    // moved to extension
    //   func searchBarSearchButtonClicked( searchBar: UISearchBar)
}
}
//MARK: - Search Bar method
extension ToDoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(  _ searchBar: UISearchBar)
    {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
       
        let predicate = NSPredicate(format: "title CONTAINS [cd] %@", searchBar.text!)
        // request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        // code refactered to the above
        // let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        //      request.predicate = predicate
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        //[] is an array above refactered into an array []
        // code refactered to the above
        //let sortDescriptors = NSSortDescriptor(key: "title", ascending: true)
        //request.sortDescriptors = [sortDescriptor]
        loadItems(with: request, predicate: predicate)
        //refactored as above func LoadItems
        /*
         do {
         itemArray = try context.fetch(request)
         } catch {
         print("Error Fetching data from context \(error)")
         }
         */
       // tableView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}

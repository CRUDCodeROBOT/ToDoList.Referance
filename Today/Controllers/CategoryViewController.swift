//
//  CategoryViewController.swift
//  Today
//
//  Created by Saiyan on 2019/01/30.
//  Copyright © 2019 Rob. All rights reserved.

import UIKit
import CoreData

/*
 class CategoryViewController: UITableViewController {
 override func viewDidLoad() {
 super.viewDidLoad()
 //extra Auto.gen code -not needed
 // Uncomment the following line to preserve selection between presentations
 // self.clearsSelectionOnViewWillAppear = false
 // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
 // self.navigationItem.rightBarButtonItem = self.editButtonItem
 //extra Auto.gen code -not needed
 }
 //extra Auto.gen code -not needed
 // MARK: - Table view data source
 override func numberOfSections(in tableView: UITableView) -> Int {
 // #warning Incomplete implementation, return the number of sections
 return 0
 }
 override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 // #warning Incomplete implementation, return the number of rows
 return 0
 }
 /*
 override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
 // Configure the cell...
 return cell
 }
 */
 /*
 // Override to support conditional editing of the table view.
 override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the specified item to be editable.
 return true
 }
 */
 /*
 // Override to support editing the table view.
 override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
 if editingStyle == .delete {
 // Delete the row from the data source
 tableView.deleteRows(at: [indexPath], with: .fade)
 } else if editingStyle == .insert {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */
 /*
 // Override to support rearranging the table view.
 override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
 }
 */
 /*
 // Override to support conditional rearranging of the table view.
 override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the item to be re-orderable.
 return true
 }
 */
 /*
 // MARK: - Navigation
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */
 //extra Auto.gen code -not needed
 //MARK: - TableView Datasource Methods
 //MARK: - Data Manipulation Methods
 //MARK: - Add New Categories
 @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
 }
 //MARK: - TableView Delegate Methods
 //------------
 }
 //----------
 */
class CategoryViewController: UITableViewController {
    //-- start
    //Var
    //   var nameArray = [Name]()
    var categories = [Category]()
    // context from TODO
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        //      let category = nameArray[indexPath.row]
        //      cell.textLabel?.text = category.title
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
        //check box not needed should be replaced with "move to next slide function
        //        if Category. == true {
        //            cell.accessoryType = .checkmark
        //        } else {
        //            cell.accessoryType = .none
        //        }
        //        return cell
        }
        //MARK: - TableView Delegate Methods
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "goToItems", sender: self)
        }
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let destinationVC = segue.destination as! ToDoListViewController
            
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.selectedCategory = categories[indexPath.row]
            }
        }
        //MARK: - Data Manipulation Methods
        func saveCategories() {
            do {
                try context.save()
            } catch {
                print("Error saving item, \(error)")
            }
            tableView.reloadData()
        }
        //   func loadCategories(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
        func loadCategories() {
            let request : NSFetchRequest<Category> = Category.fetchRequest()
            do {
                categories = try context.fetch(request)
            } catch {
                print("Error Loading Categories \(error)")
            }
            tableView.reloadData()
        }
        //    do {nameArray = try context.fetch(request)
        //        } catch {
        //            print("Error Fetching data from context \(error)")
        //        }
        //tableView.reloadData()
        //    }
        //MARK: - Add New Categories
        @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
            var textField = UITextField()
            let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "Add", style: .default) { (action) in
                let newCategory = Category(context: self.context)
                newCategory.name = textField.text!
                self.categories.append(newCategory)
                self.saveCategories()
                //            newCategory.done = false
                //            self.itemArray.append(newCategory)
                //
                //            self.saveItems()
                
            }
            alert.addAction(action)
            alert.addTextField { (field) in
                textField = field
                textField.placeholder = "Add new Category"
            }
            present(alert, animated: true, completion: nil)
                //--end
            }
}

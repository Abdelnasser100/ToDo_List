//
//  CategoryTableViewController.swift
//  ToDo_List
//
//  Created by Abdelnasser on 26/02/2022.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {

    //MARK: - vars
    
    let realm = try! Realm()

    //var categiryArray = [Category]()
    var categoryArray :Results<Category>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Category List"
        categoryArray = realm.objects(Category.self)
    }
    
    
    
    @IBAction func addCategory(_ sender: UIBarButtonItem) {
        
        var alertText = UITextField()
        
        let alert = UIAlertController(title: "Add Category", message: "add", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = alertText.text!
            //self.categiryArray.append(newCategory)
            self.tableView.reloadData()
            
            try! self.realm.write{
                self.realm.add(newCategory)
            }
            self.tableView.reloadData()

        }
        
        
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(cancel)
        alert.addAction(addAction)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add Category"
            alertText = alertTextField
        }
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoryArray.count
       
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = categoryArray[indexPath.row].name
        return cell
    }
    
    override func tableView (_ tableView:UITableView, didSelectRowAt indexPath:IndexPath){
        
        performSegue(withIdentifier:"GoToItem" ,sender:self)
    }
    
    
    override func prepare(for segue:UIStoryboardSegue, sender:Any?){
        let indexPath = tableView.indexPathForSelectedRow
        
        let vc = segue.destination as! ItemTableViewController
        
        let selectedCategory = categoryArray[indexPath!.row]
        vc.category = selectedCategory
        
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      
        let category = categoryArray[indexPath.row]
        
        try! realm.write{
            realm.delete(category)
        }
        
        tableView.reloadData()
        
    }
}

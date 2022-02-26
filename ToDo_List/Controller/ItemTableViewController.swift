//
//  ItemTableViewController.swift
//  ToDo_List
//
//  Created by Abdelnasser on 26/02/2022.
//

import UIKit
import RealmSwift

class ItemTableViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var category:Category?{
        didSet{
            print(category?.name)
            itemArray = category?.items.sorted(byKeyPath: "name")
        }
    }

   // var itemArray = [Item]()
    var itemArray:Results<Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = category?.name
        
        print(print(Realm.Configuration.defaultConfiguration.fileURL!))
        
    }

    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
        var alertText = UITextField()
        
        let alert = UIAlertController(title: "Add Item", message: "add", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newItem = Item()
            newItem.name = alertText.text!
          //self.itemArray.append(newItem)
            self.tableView.reloadData()
            
            try! self.realm.write{
               // self.realm.add(newItem)
                self.category?.items.append(newItem)
            }
            self.tableView.reloadData()
        }
        
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(cancel)
        alert.addAction(addAction)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add Item"
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
        return itemArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = itemArray[indexPath.row].name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = itemArray[indexPath.row]
        
        try! realm.write{
        item.checked = !item.checked
        }
            
        if item.checked{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        
        //itemArray[indexPath.row] = item
        
//
//        if (tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.none){
//        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }else{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      
        let item = itemArray[indexPath.row]
        
        try! realm.write{
            realm.delete(item)
        }
        
        tableView.reloadData()
        
    }
    

    
}

//
//  ChurchSelectionViewController.swift
//  altar
//
//  Created by Juan Moreno on 1/28/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import UIKit
import Firebase

class ChurchSelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searching {
                  return seachinChurch.count
              } else {
                  return churchList.count
              }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "iglesia", for: indexPath)
       
         cell.textLabel?.font = UIFont(name: "Avenir", size: 20)
         cell.textLabel?.textColor = UIColor.white// set to any colour
         cell.layer.backgroundColor = UIColor.clear.cgColor
        cell.layer.opacity = 0.2
        
        
        if searching {
                cell.textLabel?.text = seachinChurch[indexPath.row]
               } else {
                    cell.textLabel?.text = churchList[indexPath.row]
               }
        return cell

        
    
//        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

        
        if searching {
                       advengers.shared.currentChurch = seachinChurch[indexPath.row]
            
            
                      } else {
                           advengers.shared.currentChurch = churchList[indexPath.row]
            
            
                      }
        
        navigationController?.popViewController(animated: true)
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("ChurchSelection"), object: nil)
              
    }

    @IBOutlet var serachBar: UISearchBar!
    @IBOutlet var listadeChurch: UITableView!
    
    var seachinChurch = [String] ()
    var searching: Bool = false
     var churchList = ["I don't have one","Favorday Church","River Church","Rey de Reyes","Not listed"]
   
    override func viewDidLoad() {

        super.viewDidLoad()
        
       
        
        listadeChurch.dataSource = self
        listadeChurch.delegate = self
        serachBar.delegate = self
        listadeChurch.backgroundColor = UIColor.clear
        serachBar.backgroundColor = UIColor.clear
        
        
        var ref: DatabaseReference!

        ref = Database.database().reference().child("churcheslist")
        
        let values = ["churcheslist": churchList ] as [String : Any]

        
        ref.updateChildValues(values) { (err, ref) in
            if let err = err {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                print("Failed to save post to DB", err)
                return
            }
            
            print("Successfully saved post to DB")
            self.dismiss(animated: true, completion: nil)
        }

        
    }
    
   func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
           seachinChurch = churchList.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
           searching = true
           listadeChurch.reloadData()
       }
       
       func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
           searching = false
           searchBar.text = ""
           listadeChurch.reloadData()
       }
}


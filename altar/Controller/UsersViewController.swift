//
//  PrayViewController.swift
//  altar
//
//  Created by Juan Moreno on 9/13/19.
//  Copyright © 2019 Juan Moreno. All rights reserved.
//

import UIKit
import Firebase

class UsersViewController: UIViewController {

    @IBOutlet weak var tablaUsuarios: UITableView!
    
    var users = [User] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tablaUsuarios.delegate = self
        tablaUsuarios.dataSource = self
        retriveUsers()
        
        

       
        // Do any additional setup after loading the view.
    }
    
    func retriveUsers () -> Void {
        
        advengers.shared.usersStatusRef.queryOrderedByKey().observe(.value) { (datasnap) in
            let usersRead = datasnap.value as! [ String : NSDictionary]
            //self.users.removeAll()
            
            for (_,value) in usersRead {
                
                print("heeyyy")
                
                print(datasnap.value)
                
                if let userid = value["userid"] as? String {
                    
                     print("Entra")
                     print(userid)
                    
                    if userid != Auth.auth().currentUser?.uid
                    {
                        if advengers.shared.currentChurch == value["church"] as? String {
                            
                            var userToShow = User()
                            userToShow.userID = value["userid"] as? String ?? ""
                            userToShow.fullName = value["name"] as? String ?? ""
                            userToShow.email = value["email"] as? String ?? ""
                            userToShow.photoUser = value["photoURL"] as? String ?? ""
                            
                            self.users.append(userToShow)
                            self.tablaUsuarios.reloadData()
                          
                        }
                        
                        
                    }
                }
            }
           
            
            
        }
     // advengers.shared.usersStatusRef.removeAllObservers()
        
    }

    @IBAction func logout(_ sender: Any) {
        
        try! Auth.auth().signOut()
        
    }
    
    @IBAction func reloadData(_ sender: Any) {
        
        
        print(self.users.count)
         self.tablaUsuarios.reloadData()
        
    }
    
}



extension UsersViewController: UITableViewDelegate, UITableViewDataSource {


func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   // return users.count
    
    return users.count
    
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
    
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserTableViewCell
    
    
   
    
 
     if users.count != nil {
    
     if let titulo = cell.viewWithTag(200) as? UILabel
     
     {
     titulo.text = users[indexPath.row].fullName
     
     }
     
     cell.nombre.text = users[indexPath.row].fullName
    cell.userId = users[indexPath.row].userID
    cell.foto.downloadImage(imgURL: users[indexPath.row].photoUser)
    
                            }
 
    
    return cell
    
}
    
}

extension UIImageView {
    
    func downloadImage (imgURL: String) {
        
  
            let url = URLRequest(url: URL(string: imgURL)!)
            
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    
                    print(error?.localizedDescription)
                    return
                }
                
                DispatchQueue.main.async {
                    
                    self.image = UIImage(data: data!)
                }
                
            }
        
        task.resume()
        
        
        
    }
    
    
}

extension UsersViewController: UITextViewDelegate {
    
    
}

//
//  PrayViewController.swift
//  altar
//
//  Created by Juan Moreno on 9/13/19.
//  Copyright © 2019 Juan Moreno. All rights reserved.
//

import UIKit
import Firebase

class UsersViewController: UIViewController, UIPageViewControllerDelegate {

    @IBOutlet weak var tablaUsuarios: UITableView!
    
    @IBOutlet weak var contenedor: UIView!
    
    var users = [User] ()
    @IBOutlet weak var pageController: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contenedor.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    
        
        tablaUsuarios.delegate = self
        tablaUsuarios.dataSource = self
        
        
        pageController.numberOfPages = 6
        
     //   navigationItem.title = advengers.shared.currentChurch
        
        // TODO: REFACTORIAR, OJO CON LAS FUNCONES QUE EJCUTAN LOS BOTONES // ----------------------------
                      // ---------------------------------------------------------------------------------------------
                      navigationController?.navigationBar.backgroundColor = advengers.shared.colorBlue
                      navigationController?.navigationBar.barTintColor = advengers.shared.colorBlue
                      
                      navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "settingsincon"), style: .plain, target: self, action: #selector(advengers.shared.settings))
               
                      navigationItem.leftBarButtonItem?.tintColor = advengers.shared.colorOrange
                      
                      
                      let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,
                                            NSAttributedString.Key.font:UIFont(name: "Avenir-Heavy", size: 15)]
                      navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
                      
                      
                      
                      
                      if advengers.shared.isPastor {
                          
                          navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+ Event", style: .plain, target: self, action: #selector(addEnvent))
                          
                      }
               
                      let textAttributes2 = [NSAttributedString.Key.foregroundColor: advengers.shared.colorOrange,
                                                    NSAttributedString.Key.font:UIFont(name: "Avenir-Heavy", size: 15)]
                      
                      navigationItem.rightBarButtonItem?.setTitleTextAttributes(textAttributes2 as [NSAttributedString.Key : Any], for: .normal)
                      navigationItem.rightBarButtonItem?.tintColor = advengers.shared.colorOrange
                      
                      navigationItem.title = advengers.shared.currentChurch
                      
                      // -----------------------------------------------------------------------------------------
               
        
        
        retriveUsers()
        
    
        

       
        // Do any additional setup after loading the view.
    }
    
    
    @objc func addEnvent()  {
        
        
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
                            
                            let userToShow = User(uid: value["userid"] as? String ?? "", dictionary: value as! [String : Any])
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let chat = ChatViewController ()
        chat.user2Name = users[indexPath.row].fullName
        chat.user2UID = users[indexPath.row].uid
        chat.user2ImgUrl = users[indexPath.row].photoUser
        navigationController?.pushViewController(chat, animated: true)
        
        
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

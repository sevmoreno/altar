//
//  SettingsViewController.swift
//  altar
//
//  Created by Juan Moreno on 2/6/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {
    
    
    let titleSettings: UILabel = {
        
        let a = UILabel ()
        
        a.text = "Settings"
        a.font = UIFont(name: "Avenir-Heavy", size: 34)
        a.tintColor = .white
        a.textColor = .white
        return a
        
    } ()
    
    let separador: UIView = {
          
          let a = UIView ()
          
          a.backgroundColor = .lightGray
          
          return a
          
      } ()
    
    let logOut: UIButton = {
        
        /*
        let button = UIButton(type: .system)
        button.setTitle("Log Out", for: .normal)
       // button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
       // button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont(name: "Avenir-Book", size: 20)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector (logout), for: .touchUpInside)
 */
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont(name: "Avenir-Book", size: 20)
        button.setTitle("Log Out", for: .normal) 
        button.setTitleColor(.white, for: .normal)
      
        button.addTarget(self, action: #selector(logout), for: .touchUpInside)
               
        return button
    }()
    
      let editProfile: UIButton = {
             
             /*
             let button = UIButton(type: .system)
             button.setTitle("Log Out", for: .normal)
            // button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
            // button.layer.cornerRadius = 5
             button.titleLabel?.font = UIFont(name: "Avenir-Book", size: 20)
             button.setTitleColor(.white, for: .normal)
             button.addTarget(self, action: #selector (logout), for: .touchUpInside)
      */
             let button = UIButton(type: .system)
             button.titleLabel?.font = UIFont(name: "Avenir-Book", size: 20)
             button.setTitle("Edit User Profile", for: .normal)
             button.setTitleColor(.white, for: .normal)
           
             button.addTarget(self, action: #selector(editUserProfile), for: .touchUpInside)
                    
             return button
         }()
    
    
    let editChurchProfile: UIButton = {
                
                /*
                let button = UIButton(type: .system)
                button.setTitle("Log Out", for: .normal)
               // button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
               // button.layer.cornerRadius = 5
                button.titleLabel?.font = UIFont(name: "Avenir-Book", size: 20)
                button.setTitleColor(.white, for: .normal)
                button.addTarget(self, action: #selector (logout), for: .touchUpInside)
         */
                let button = UIButton(type: .system)
                button.titleLabel?.font = UIFont(name: "Avenir-Book", size: 20)
                button.setTitle("Edit Church Profile", for: .normal)
                button.setTitleColor(.white, for: .normal)
              
                button.addTarget(self, action: #selector(editChurchProfileAction), for: .touchUpInside)
                       
                return button
            }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = advengers.shared.colorBlue
        
        view.addSubview(titleSettings)
        titleSettings.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 100, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        titleSettings.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        view.addSubview(separador)
        separador.anchor(top: titleSettings.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 15, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 0, height: 1)
        separador.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        view.addSubview(logOut)
        logOut.anchor(top: separador.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 59, paddingLeft: 0, paddingBottom: 0, paddingRight: 30, width: 0, height: 0)
        logOut.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        view.addSubview(editProfile)
        editProfile.anchor(top: logOut.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 30, width: 0, height: 0)
        editProfile.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        
        if advengers.shared.isPastor {
            
            view.addSubview(editChurchProfile)
            editChurchProfile.anchor(top: editProfile.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 30, width: 0, height: 0)
            editChurchProfile.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

            
        }
        // Do any additional setup after loading the view.
    }
    
    @objc func logout () {
        
        
        print("Log out ejecutado")
         try? Auth.auth().signOut()
        
     //   dismiss(animated: true, completion: nil)
           navigationController?.dismiss(animated: true, completion: nil)

        
          let vc =  WelcomeViewController ()
            present(vc, animated: true)
    // _ = navigationController?.popToRootViewController(animated: true)
        
    }
    
    
    
    @objc func editUserProfile () {
        
        
    }
    
    
     @objc func editChurchProfileAction () {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

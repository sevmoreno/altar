//
//  ViewController.swift
//  altar
//
//  Created by Juan Moreno on 9/8/19.
//  Copyright © 2019 Juan Moreno. All rights reserved.
//
import UIKit
import Firebase




class logInViewController: UIViewController, UITextFieldDelegate {
    


    @IBOutlet weak var emailLogin: UITextField!
    @IBOutlet weak var passwordLogin: UITextField! 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       emailLogin.delegate = self
       passwordLogin.delegate = self
        
        
      //  emailLogin.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 100, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        
        Auth.auth().addStateDidChangeListener() { auth, user in
            // 2
            if user != nil {
                // 3
                self.performSegue(withIdentifier: "accesoOK", sender: nil)
                self.emailLogin.text = nil
                self.passwordLogin.text = nil
                
            }
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func SignUp(_ sender: Any) {
        
        self.performSegue(withIdentifier: "accesoSignIN", sender: nil)
        
    }
    

    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    
    
    @IBAction func SingIn(_ sender: Any) {
        
        guard
            let email = emailLogin.text,
            let password = passwordLogin.text,
            email.count > 0,
            password.count > 0
            else {
                return
        }
        
        
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if let error = error, user == nil {
                let alert = UIAlertController(title: "Sign In Failed",
                                              message: error.localizedDescription,
                                              preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                
                self.present(alert, animated: true, completion: nil)
            }
                
            else {
                
                self.performSegue(withIdentifier: "accesoOK", sender: nil)
            }
        }
        
        
    }

    
}


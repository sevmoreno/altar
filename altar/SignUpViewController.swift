//
//  SignUpViewController.swift
//  altar
//
//  Created by Juan Moreno on 9/8/19.
//  Copyright © 2019 Juan Moreno. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var churchChose: UIPickerView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordvalidator: UITextField!
    @IBOutlet weak var signInBtt: UIButton!
    
    var picker = UIImagePickerController ()
    let storageReference = Storage.storage().reference(forURL: "gs://altar-92d12.appspot.com" ).child("users")
    var ref: DatabaseReference!
    
 
    let databaseReference = Database.database().reference()
    
    var selectedChurch = "Not listed"
    var churchList = ["Favorday Church","River Church","Not listed"]
  
   // let userStorage =
    override func viewDidLoad() {
        super.viewDidLoad()
        
        image.image = UIImage.init(named: "default")
        
        picker.delegate = self
        
        churchChose.dataSource = self
        churchChose.delegate = self

    }

    @IBAction func signIn(_ sender: Any) {
        
        guard name.text != "", email.text != "", password.text != "", passwordvalidator.text != "" else {return}
        
        if password.text == password.text {
            
            Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
                
                if let error = error {
                    print(error.localizedDescription)
                }
                
                if user != nil {
                
                let imageref = self.storageReference.child("picture").child("\(user!.user.uid)")
                let data = self.image.image?.jpegData(compressionQuality: 0.5)
                    
                 
                let uploadTask = imageref.putData(data!, metadata: nil, completion: { (metadata, error) in

                        
                    })
                
                uploadTask.resume()
                    
                    self.ref = self.databaseReference
                
                    let userinfo: [String:Any] = ["userid" : (user?.user.uid), "name" : self.name.text!, "email" : self.email.text!, "church": self.selectedChurch]
                    let userID = String ((user?.user.uid)!) ?? "NoTiene"
                 //   self.databaseReference.child("users").child("\(user!.user.uid)").setValue(user?.user.uid, forKeyPath: "userid")
                    self.ref.child("users").child(userID).setValue(self.name.text!)
                    self.ref.child("users").child(userID).setValue(self.email.text!)
                 //   self.databaseReference.child("users").child("\(user!.user.uid)").setValue(self.selectedChurch, forKeyPath: "church")
                    self.performSegue(withIdentifier: "accesoOK", sender: self)
                    
                }
                
            }
            
      
        }
        
        else {
            let alertController = UIAlertController(title: "Password not matching", message: "Password not matching", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func changePicture(_ sender: Any) {
        
        picker.allowsEditing = true
 
        picker.sourceType = .photoLibrary
        
        present(picker, animated: true, completion: nil)
        
    }
    

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        guard let selectedImage = info[.editedImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        image.image = selectedImage
     self.dismiss(animated: true, completion: nil)
        
    }

    
    
}

extension SignUpViewController: UIPickerViewDataSource,UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      
            return churchList.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if row < churchList.count {
        return churchList[row]
        }
        return ""
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
       selectedChurch = churchList[row]
    }
    
}

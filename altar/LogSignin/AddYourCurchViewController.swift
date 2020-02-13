//
//  AddYourCurchViewController.swift
//  altar
//
//  Created by Juan Moreno on 2/13/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//


    import UIKit
    import Firebase
    import FirebaseUI

    class AddYourCurchViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
        
      //  @IBOutlet var seleecionFoto: UIButton!
        @IBOutlet weak var churchChose: UIPickerView!
        @IBOutlet weak var image: UIImageView!
        @IBOutlet weak var name: UITextField!
        @IBOutlet weak var email: UITextField!
        @IBOutlet weak var password: UITextField!
        @IBOutlet weak var passwordvalidator: UITextField!
        @IBOutlet weak var signInBtt: UIButton!
      //  var picker = UIImagePickerController ()
        let storageReference = Storage.storage().reference(forURL: "gs://altar-92d12.appspot.com" ).child("users")
        var ref: DatabaseReference!
        
     
        let databaseReference = Database.database().reference()
        
        var selectedChurch = "Favorday Church"
        var churchList = ["Favorday Church","River Church","Rey de Reyes","Not listed"]
        
       @IBOutlet weak var mainScrollViewBottomConstraint: NSLayoutConstraint!
      
        @IBOutlet var textviewBackground: UIView!
        @IBOutlet var textbackbroundpassword: UIView!
        @IBOutlet var textEmail: UIView!
        @IBOutlet var textbackgroundPassValidator: UIView!
        @IBOutlet var selectUChurch: UIView!
        @IBOutlet var selectChurchButton: UIButton!
        // let userStorage =
        @IBOutlet var textviewemail: UIView!
        
        var imageToSave: UIImage?
        
        override func viewDidLoad() {
            
            super.viewDidLoad()
            
            let accounthelper = AccountHelpers ()
            
            accounthelper.loadCurrentUserInfo()
            accounthelper.fetchUserInfo()
            
            print(advengers.shared.currenUSer as [String:Any])
//
//            NotificationCenter.default.addObserver(self, selector: #selector(churchSelection), name: NSNotification.Name(rawValue: "ChurchSelection"), object: nil)
//
//            navigationController?.navigationBar.isHidden = true
//
//            signInBtt.backgroundColor = UIColor.rgb(red: 247, green: 131, blue: 97)
//            signInBtt.layer.cornerRadius = 22
//            signInBtt.layer.masksToBounds = true
//            signInBtt.setTitleColor(.white , for: .normal)
//            signInBtt.setTitle("Sign in", for: .normal)
//            signInBtt.setTitleColor(UIColor.white.withAlphaComponent(0.3), for: .highlighted )
//            signInBtt.applyGradient(colors: [WelcomeViewController.UIColorFromRGB(0xF78361).cgColor,WelcomeViewController.UIColorFromRGB(0xF54B64).cgColor])
//        textviewBackground.layer.cornerRadius = 22
//        textviewemail.layer.cornerRadius = 22
//    textbackbroundpassword.layer.cornerRadius = 22
//
//            textEmail.layer.cornerRadius = 22
//          textbackgroundPassValidator.layer.cornerRadius = 22
//
//            selectUChurch.layer.cornerRadius = 22
//
//
//                //Border
//            name.layer.cornerRadius = 22
//
//            name.backgroundColor = UIColor.clear
//
//            //Text
//            name.textColor = .white
//
//
//            name?.delegate = self
//            email.delegate = self
//            password.delegate = self
//            passwordvalidator.delegate = self
            

            
            

        }
        
        
        @objc func churchSelection() {
            DispatchQueue.main.async {
                self.selectChurchButton.setTitle(advengers.shared.currentChurch, for: .normal)
                print(advengers.shared.currentChurch)
            }
            
            
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            textField.text = ""
            
        }
        
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.view.endEditing(true)
            return false
        }
        
        @IBAction func goBack(_ sender: Any) {
            
            //navigationController?.popViewController(animated: true)
        }
        
        /*
        @objc func adjustForKeyboard (_ notification: Notification) {
           let userInfo = (notification as NSNotification).userInfo!
        let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
           mainScrollViewBottomConstraint.constant = keyboardSize.height
       }

        @objc func keyboardWillHide(_ notification: Notification) {
           mainScrollViewBottomConstraint.constant = 0
       }
     */

        @IBAction func signIn(_ sender: Any) {

//            guard name?.text != "", email.text != "", password.text != "", passwordvalidator.text != "" else {return}
//
//            if password.text == password.text {
//
//                Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
//
//                    if let error = error {
//                        print(error.localizedDescription)
//                    }
//
//                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
//                    changeRequest?.displayName = self.name?.text
//                    changeRequest?.commitChanges(completion: { (no) in
//
//                    })
//
//
//                    if user != nil {
//
//                    let imageref = self.storageReference.child("picture").child("\(user!.user.uid)")
//
//
//
//                        let data = self.imageToSave?.jpegData(compressionQuality: 0.5) ?? UIImage(named: "Rectangle")!.jpegData(compressionQuality: 0.5)
//
//
//                    let uploadTask = imageref.putData(data!, metadata: nil, completion: { (metadata, error) in
//
//
//                        imageref.downloadURL(completion: { (url, error) in
//
//
//
//                            let modoString = String (url!.absoluteString)
//                            self.ref = self.databaseReference
//
//                            let userinfo: [String:Any] = ["userid" : (user?.user.uid), "name" : self.name?.text!, "email" : self.email.text!, "church": advengers.shared.currentChurch, "photoURL" : modoString ?? ""]
//                            let userID = String ((user?.user.uid)!) ?? "NoTiene"
//                            //   self.databaseReference.child("users").child("\(user!.user.uid)").setValue(user?.user.uid, forKeyPath: "userid")
//                            self.ref.child("users").child(userID).setValue(userinfo)
//                            //self.ref.child("users").child(userID).setValue(self.email.text!)
//                            //   self.databaseReference.child("users").child("\(user!.user.uid)").setValue(self.selectedChurch, forKeyPath: "church")
//                            self.performSegue(withIdentifier: "accesoOK", sender: self)
//
//
//
//                        })
//
//
//
//                        })
//
//
//
//                    uploadTask.resume()
//
//
//
//                    }
//
//                }
//
//
//            }
//
//            else {
//                let alertController = UIAlertController(title: "Password not matching", message: "Password not matching", preferredStyle: .alert)
//                let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//                alertController.addAction(OKAction)
//                self.present(alertController, animated: true, completion: nil)
//            }
//        }
////
//        @IBAction func changePicture(_ sender: Any) {
//
//            picker.allowsEditing = true
//
//            picker.sourceType = .photoLibrary
//
//            present(picker, animated: true, completion: nil)
//
//        }
//
//
//        func imagePickerController(_ picker: UIImagePickerController,
//                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
//        {
//
//            print("seactivo")
//            guard let selectedImage = info[.editedImage] as? UIImage else {
//                fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
//            }
//
//
//         seleecionFoto.setImage(selectedImage, for: .normal )
//           seleecionFoto.layer.cornerRadius = seleecionFoto.frame.width/2
//               seleecionFoto.layer.masksToBounds = true
//               seleecionFoto.layer.borderColor = UIColor.white.cgColor
//               seleecionFoto.layer.borderWidth = 1
//
//          imageToSave = selectedImage
//
//         //   image.image = selectedImage
//         self.dismiss(animated: true, completion: nil)

        }

        
        
    }

//    extension AddYourCurchViewController: UIPickerViewDataSource,UIPickerViewDelegate {
//
//        func numberOfComponents(in pickerView: UIPickerView) -> Int {
//            return 1
//        }
//
//        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//
//                return churchList.count
//
//        }
//
//        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//
//            if row < churchList.count {
//            return churchList[row]
//            }
//            return ""
//
//        }
//
//        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//
//           selectedChurch = churchList[row]
//        }
        
  //  }



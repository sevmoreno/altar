//
//  PhotoVideoPostViewController.swift
//  altar
//
//  Created by Juan Moreno on 11/12/19.
//  Copyright © 2019 Juan Moreno. All rights reserved.
//

import UIKit
import Firebase

class PhotoVideoPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let  textoIngresado: UITextView = {
        
        let a = UITextView ()
        
        
        return a
        
    } ()
    
    
    var picker = UIImagePickerController ()
    
    let imageToDisplay: UIImageView = {
        
        let imagen = UIImageView ()
        imagen.contentMode = .scaleAspectFit
        return imagen
    } ()
    
    
    let postIt: UIButton = {
        
               let button = UIButton()
               button.setTitle("Post", for: .normal)
               button.backgroundColor = .black
               button.layer.cornerRadius = 5
               button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
               button.setTitleColor(.white, for: .normal)
            button.addTarget(self, action: #selector (postImageAndText), for: .touchUpInside)
               return button

    } ()
    
    
    var isImage: UIImage?
    var isVideo: String?
    
    override func viewDidLoad() {
        
        textoIngresado.delegate = self
        picker.delegate = self
        textoIngresado.text = "Say something about this photo ..."
        
        
        if isImage != nil {
            
            DispatchQueue.main.async {
                self.imageToDisplay.image = self.isImage
            }
            
           
        }
        textoIngresado.backgroundColor = .white
        
        
        view.backgroundColor = .purple
        
        view.addSubview(imageToDisplay)
        let ratio: CGFloat = isImage!.size.width / isImage!.size.height
        imageToDisplay.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 100, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: view.frame.width - 60, height: view.frame.width / ratio)
      
 
   //     imageToDisplay.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 400, height: 400)

        
         view.addSubview(textoIngresado)
        view.addSubview(postIt)
        
        
        textoIngresado.anchor(top: imageToDisplay.bottomAnchor, left: view.leftAnchor, bottom: postIt.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 30, paddingBottom: 80, paddingRight: 30, width: 0, height: 0)
        
        
        
        
       // postIt.heightAnchor.constraint(equalToConstant: 40).isActive = true
       // postIt.widthAnchor.constraint(equalToConstant: 140).isActive = true
       // postIt.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
      //  postIt.topAnchor.constraint(equalTo: textoIngresado.bottomAnchor, constant: 100).isActive = true
             
        
          postIt.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 100, paddingRight: 0, width: 200, height: 30)
     
          postIt.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

       
    }
    

    @objc func postImageAndText(_ sender: Any) {
        
        
        AppDelegate.instance().showActivityIndicatior()
        
        let uid = Auth.auth().currentUser?.uid
        
        let nombreToDisplay = advengers.shared.currenUSer["name"] ?? "Unknow"
        let userphot = advengers.shared.currenUSer["photoURL"] ?? "No cargo"
        
        let key = advengers.shared.postPrayFeed.childByAutoId().key
        
        let imageRef = advengers.shared.PostPrayStorage.child(uid!).child("\(key!).jpg")
        
        let data = isImage?.jpegData(compressionQuality: 0.6)
       
        
        let uploadTask = imageRef.putData(data!, metadata: nil) { (matadata, error) in
            
            if error != nil {
                print(error.debugDescription)
            }
            
            
            imageRef.downloadURL(completion: { (url, error) in
                if let url = url {
                    
                    let feed = ["userid": uid,
                                "pathtoPost":url.absoluteString,
                                "prays": 0,
                                "author": nombreToDisplay,
                                "userPhoto": userphot,
                                "postID": key,
                                "postType": advengers.postType.textImage.rawValue,
                                "message": self.textoIngresado.text,
                                "imagH:": self.isImage!.size.height,
                                "imagW:": self.isImage!.size.width
                        
                        
                        
                        ] as! [String:Any]
                    
                    let postfeed = ["\(key!)" : feed] as! [String:Any]
                    
                    advengers.shared.postPrayFeed.updateChildValues(postfeed)
                    
                    AppDelegate.instance().dismissActivityIndicator()
                    
                    _ = self.navigationController?.popToRootViewController(animated: true)
                    
                    
                }
            })
            
        }
        
        uploadTask.resume()
        
        
    }
    
   
    
}

extension PhotoVideoPostViewController: UITextViewDelegate {
    
    
    func textViewDidChange(_ textView: UITextView) {
    //    adjustUITextViewHeight(arg: textoIngresado)

    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        textView.text = ""
        
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
      
        
    }
    
    func adjustUITextViewHeight(arg : UITextView)
      {
          arg.translatesAutoresizingMaskIntoConstraints = true
          arg.sizeToFit()
          arg.isScrollEnabled = false
      }
    
}

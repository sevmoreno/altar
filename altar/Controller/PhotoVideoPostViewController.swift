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

    @IBOutlet weak var textoIngresado: UITextView!
    var picker = UIImagePickerController ()
    
    @IBOutlet weak var imageToDisplay: UIImageView!
    
    var isImage: UIImage?
    var isVideo: String?
    
    override func viewDidLoad() {
        textoIngresado.delegate = self
        picker.delegate = self
        textoIngresado.text = "Say something about this photo ..."
        if isImage != nil {
            
            imageToDisplay.image = isImage
        }
        
     

       
    }
    

    @IBAction func postImageAndText(_ sender: Any) {
        
        
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
                                "message": self.textoIngresado.text] as! [String:Any]
                    
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
        adjustUITextViewHeight(arg: textoIngresado)

    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        
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

//
//  PrayPostViewController.swift
//  altar
//
//  Created by Juan Moreno on 9/16/19.
//  Copyright © 2019 Juan Moreno. All rights reserved.
//

import UIKit
import Firebase

class PrayPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
 
    
    var picker = UIImagePickerController ()
    
    @IBOutlet weak var textoIngresado: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
       picker.delegate = self
        
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectVideoPhoto(_ sender: Any) {
        
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
         
          //  let textView = UITextView(frame: CGRect(x: CGFloat(20), y: CGFloat(20), width: CGFloat(400), height: CGFloat(400 )))
          //  textView.text = "this is a test \n this is test \n this is a test"
            let img = UIImageView(frame: textoIngresado.bounds)
            img.image = image
            textoIngresado.backgroundColor = UIColor.clear
            textoIngresado.addSubview( img)
          //  self.view.addSubview(textView)
            textoIngresado.sendSubviewToBack(img)
            
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func postAction(_ sender: Any) {
        
        AppDelegate.instance().showActivityIndicatior()
        
        let uid = Auth.auth().currentUser?.uid
  
        let nombreToDisplay = advengers.shared.currenUSer["name"] ?? "Unknow"
        let userphot = advengers.shared.currenUSer["photoURL"] ?? "No cargo"
        
        let key = advengers.shared.postPrayFeed.childByAutoId().key
        
        let imageRef = advengers.shared.PostPrayStorage.child(uid!).child("\(key!).jpg")
        
       // let data = UIGraphicsImageRenderer(bounds: textoIngresado.bounds)
        let data = textViewImage().jpegData(compressionQuality: 0.6)
        
      //  let data2 = data.jpegData(withCompressionQuality: 0.6) { (bada) in
            
      //  }
        
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
                                "postType": advengers.postType.textBkground] as! [String:Any]
                    
                    let postfeed = ["\(key!)" : feed] as! [String:Any]
                    
                    advengers.shared.postPrayFeed.updateChildValues(postfeed)
                    
                     AppDelegate.instance().dismissActivityIndicator()
                    
                    _ = self.navigationController?.popViewController(animated: true)
                    
                  // self.dismiss(animated: true, completion: nil)
                }
            })
   
        }
        uploadTask.resume()
        
    }
    
    func textViewImage() -> UIImage {
        
        var image: UIImage? = nil
        
        
        UIGraphicsBeginImageContextWithOptions(textoIngresado.visibleSize, textoIngresado.isOpaque, 0.0)
        
        let savedContentOffset: CGPoint = textoIngresado.contentOffset
        let savedFrame: CGRect = textoIngresado.frame
        
        textoIngresado.contentOffset = .zero
        textoIngresado.frame = CGRect(x: 0, y: 0, width: textoIngresado.visibleSize.width, height: textoIngresado.visibleSize.height)
        
        textoIngresado.layer.render(in: UIGraphicsGetCurrentContext()!)
        image = UIGraphicsGetImageFromCurrentImageContext()
        
        textoIngresado.contentOffset = savedContentOffset
        textoIngresado.frame = savedFrame
        
        UIGraphicsEndImageContext()
        
        return image!
    }
}



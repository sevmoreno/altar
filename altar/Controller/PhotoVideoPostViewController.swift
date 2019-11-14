//
//  PhotoVideoPostViewController.swift
//  altar
//
//  Created by Juan Moreno on 11/12/19.
//  Copyright © 2019 Juan Moreno. All rights reserved.
//

import UIKit

class PhotoVideoPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var textoIngresado: UITextView!
    var picker = UIImagePickerController ()
    
    @IBOutlet weak var imageToDisplay: UIImageView!
    
    var isImage: UIImage?
    var isVideo: String?
    
    override func viewDidLoad() {
        textoIngresado.delegate = self
        picker.delegate = self
        
        if isImage != nil {
            
            imageToDisplay.image = isImage
        }
        
     

       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
            //picker.allowsEditing = true
             //picker.sourceType = .photoLibrary
             // self.present(picker, animated: true, completion: nil)


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

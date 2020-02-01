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
 
    var selectionVideoPhoto: String = ""
    var picker = UIImagePickerController ()
    
    var hasImage: Bool = false

    var typeOfPost: String = ""
    
    var imageToSend: UIImage?
    var videoToSend: String?
    
    @IBOutlet var nombreUsuario: UILabel? {
        didSet {
            
            nombreUsuario?.text = advengers.shared.currenUSer["name"]
        }
    }
    @IBOutlet weak var textoIngresado: UITextView!
    
    @IBOutlet weak var usuarioFoto: CustomImageView!
        
    

    
    var attributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 75),
        .foregroundColor : UIColor.white
    ]
    
    var fontSize: Int = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     //  navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "gear").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleLogOut))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(postAction))
        
 
        
       
       picker.delegate = self
       textoIngresado.text = "What is your prayer"
       textoIngresado.textColor = .lightGray
       textoIngresado.delegate = self
     
         DispatchQueue.main.async {
            print("Esta es la foto")
            print(advengers.shared.currenUSer["photoURL"])
            self.usuarioFoto.loadImage(urlString: advengers.shared.currenUSer["photoURL"]!)
        
        }
     //   let imagenUsuario = CustomImageView ()
        
        
      //  if let foto = advengers.shared.currenUSer["photoURL"] {
        //    imagenUsuario.loadImage(urlString: foto)
          
         /*
            DispatchQueue.main.async {
                 
                self.usuarioFoto.image = advengers.shared.currenUSer["photoURL"]
                // self.usuarioFoto.loadImage(urlString: foto)
             }
            */
       // }
       // else { return }
 
       
        
        
        // Do any additional setup after loading the view.
    }


    
 
    
    
    @IBAction func photoVideoButton(_ sender: Any) {
                   selectionVideoPhoto = "photo"
                   picker.allowsEditing = true
                   picker.sourceType = .photoLibrary
                   self.present(picker, animated: true, completion: nil)
        
        // performSegue(withIdentifier: "photoVideoPost", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "photoVideoPost" {
            let controller = segue.destination as! PhotoVideoPostViewController
              if imageToSend != nil
              {
                   controller.isImage = imageToSend
                
              } else if videoToSend != nil {
                
                controller.isVideo = videoToSend
            }
            
        

            
        }
    }
    
    @IBAction func selectVideoPhoto(_ sender: Any) {
        
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if selectionVideoPhoto == "photo" {
    
            
            if info[UIImagePickerController.InfoKey.mediaType] as! String == "public.image" {
                
                if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                     
                    imageToSend = image
                    performSegue(withIdentifier: "photoVideoPost", sender: nil)
                    
                    }
            }
            
            
            if info[UIImagePickerController.InfoKey.mediaType] as! String == "public.video" {
                           
                videoToSend = (info[UIImagePickerController.InfoKey.mediaURL] as! String)
                print (videoToSend!)
                performSegue(withIdentifier: "onlyVideoPost", sender: nil)
            

                }
            
             
            
            
        } else {
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
         
    
            let img = UIImageView(frame: textoIngresado.bounds)
            img.image = image
            textoIngresado.backgroundColor = UIColor.clear
            textoIngresado.addSubview( img)
          //  self.view.addSubview(textView)
            textoIngresado.sendSubviewToBack(img)
            
        }
          
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func postAction(_ sender: Any) {
        
        AppDelegate.instance().showActivityIndicatior()
        
        let uid = Auth.auth().currentUser?.uid
  
        let nombreToDisplay = advengers.shared.currenUSer["name"] ?? "Unknow"
        let userphot = advengers.shared.currenUSer["photoURL"] ?? "No cargo"
        
        let key = advengers.shared.postPrayFeed.childByAutoId().key
        
        let imageRef = advengers.shared.PostPrayStorage.child(uid!).child("\(key!).jpg")

        

        //let cg = CGPoint(x: 0.0,y: 200.0)
        textoIngresado.tintColor = .clear
      
        let data = textoToImage().jpegData(compressionQuality: 0.6)
        
        
        let imagenCapturada = UIImage(data: data!)
  

        if hasImage {
            
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
                                    "postType": advengers.postType.imageOnly.rawValue,
                                    "message": self.textoIngresado.text as String,
                                    "imagH:": imagenCapturada!.size.height,
                                    "imagW:": imagenCapturada?.size.width
                            
                            
                                    ] as! [String:Any]
                        
                        let postfeed = ["\(key!)" : feed] as! [String:Any]
                        
                        advengers.shared.postPrayFeed.updateChildValues(postfeed)
                        
                        AppDelegate.instance().dismissActivityIndicator()
                        
                        _ = self.navigationController?.popViewController(animated: true)
                        
                        
                    }
                })
                
            }
            uploadTask.resume()
            
            
            
        } else {
           
            let feed = [                       "userid": uid,
                                               "pathtoPost":"",
                                               "prays": 0,
                                               "author": nombreToDisplay,
                                               "userPhoto": userphot,
                                               "postID": key,
                                               "postType": advengers.postType.textOnly.rawValue,
                                               "message": self.textoIngresado.text as String,
                                               "imagH:": 0,
                                               "imagW:": 0
                                       
                                       
                                               ] as! [String:Any]
            /*
            
            let feed = ["userid": uid,
                        "pathtoPost": nil,
                        "prays": 0,
                        "author": nombreToDisplay,
                        "userPhoto": userphot,
                        "postID": key,
                        "postType": advengers.postType.textOnly.rawValue,
                        "message": self.textoIngresado.text as String,
                        "imagH:": 0,
                        "imagW:": 0] as! [String:Any]
            */
            
            let postfeed = ["\(key!)" : feed] as! [String:Any]
            
            advengers.shared.postPrayFeed.updateChildValues(postfeed)
            
            AppDelegate.instance().dismissActivityIndicator()
            
            _ = self.navigationController?.popViewController(animated: true)

            
        }
        
  
        
    }
    
    func textoToImage() -> UIImage {
        
        var image: UIImage? = nil
        
        
     //   UIGraphicsBeginImageContextWithOptions(textoIngresado.visibleSize, textoIngresado.isOpaque, 0.0)
        UIGraphicsBeginImageContextWithOptions(textoIngresado.frame.size, textoIngresado.isOpaque, 0.0)
        //let savedContentOffset: CGPoint = textoIngresado.contentOffset
        let savedFrame: CGRect = textoIngresado.frame
        
       // textoIngresado.contentOffset = .zero
       // textoIngresado.frame = CGRect(x: 0, y: 0, width: textoIngresado.frame.size.width, height: textoIngresado.frame.size.height)
        
        textoIngresado.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        image = UIGraphicsGetImageFromCurrentImageContext()
        
        // rtextoIngresado.contentOffset = savedContentOffset
       // textoIngresado.frame = savedFrame
        
        UIGraphicsEndImageContext()
        
        return image!
    }
    // MARK:   --------------------------------------- TEXT STYLE --------------------------------------
    
    @IBAction func style1(_ sender: Any) {
        textoIngresado.backgroundColor = UIColor(red:81.0/255.0, green:224.0/255.0, blue:225.0/255.0, alpha:1.0)

        textoIngresado.backgroundColor = UIColor(patternImage: UIImage (named: "fondo1")!)
        let quote = textoIngresado.text!
        let font = UIFont(name: "LeagueGothic", size: CGFloat(fontSize))
     //   let font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
       attributes[.font] = font
        
   
        
        let attributedQuote = NSAttributedString(string: quote, attributes: attributes)

        textoIngresado.attributedText = attributedQuote
      
    }
    
    @IBAction func style2(_ sender: Any) {
        
        hasImage = true
        textoIngresado.backgroundColor = UIColor(red:51.0/255.0, green:101.0/255.0, blue:138.0/255.0, alpha:1.0)
        
        let quote = textoIngresado.text!
        let font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        attributes[.font] = font
        
        let attributedQuote = NSAttributedString(string: quote, attributes: attributes)
        
        textoIngresado.attributedText = attributedQuote
    }
    
    @IBAction func style3(_ sender: Any) {
        
        hasImage = true
        textoIngresado.backgroundColor = UIColor(red:47.0/255.0, green:72.0/255.0, blue:88.0/255.0, alpha:1.0)
        
        let quote = textoIngresado.text!
        let font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        attributes[.font] = font
        
        let attributedQuote = NSAttributedString(string: quote, attributes: attributes)
        
        textoIngresado.attributedText = attributedQuote    }
    
    @IBAction func style4(_ sender: Any) {
        
        hasImage = true
        textoIngresado.backgroundColor = UIColor(red:246.0/255.0, green:174.0/255.0, blue:45.0/255.0, alpha:1.0)
        let quote = textoIngresado.text!
        let font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        attributes[.font] = font
        
        let attributedQuote = NSAttributedString(string: quote, attributes: attributes)
        
        textoIngresado.attributedText = attributedQuote
    }
    
    @IBAction func style5(_ sender: Any) {
        
        hasImage = true
        textoIngresado.backgroundColor = UIColor(red:244.0/255.0, green:100.0/255.0, blue:25.0/255.0, alpha:1.0)
        let quote = textoIngresado.text!
        let font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        attributes[.font] = font
        
        let attributedQuote = NSAttributedString(string: quote, attributes: attributes)
        
        textoIngresado.attributedText = attributedQuote
    }
    
    @IBAction func imageBackground(_ sender: Any) {
        
        selectionVideoPhoto = "backgroundForText"
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
        
    }
}

// ------------------------------------------------ MARK: TEXT DELEGATE -------------------------

extension PrayPostViewController: UITextViewDelegate {
    
    func adjustUITextViewHeight(arg : UITextView)
    {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        // adjustUITextViewHeight(arg: textView)
        
        /* AVER
        if textoIngresado.text.count > 10 {
            
            let quote = textoIngresado.text!
            let font = attributes[.font] as! UIFont
            attributes[.font] = font.withSize(CGFloat(fontSize))
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            // paragraphStyle.firstLineHeadIndent = 5.0
            
            attributes[  .paragraphStyle] = paragraphStyle
            
            let attributedQuote = NSAttributedString(string: quote, attributes: attributes)
            
            textoIngresado.attributedText = attributedQuote
            
        }
 */
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        
        
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Placeholder"
            textView.textColor = UIColor.lightGray
        }
    }
    
  
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
 
}


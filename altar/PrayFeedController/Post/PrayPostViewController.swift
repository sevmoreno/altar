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
    
    var styleEnable: Int = 0
    
    var imagenDFondo = UIImageView()
    
    @IBOutlet var nombreUsuario: UILabel? {
        didSet {
            
            nombreUsuario?.text = advengers.shared.currenUSer["name"]
        }
    }
    @IBOutlet weak var textoIngresado: UITextView!
    
    @IBOutlet weak var usuarioFoto: CustomImageView!
        
    @IBOutlet var siTieneFoto: UIImageView!
    @IBOutlet var style1: UIButton!
    @IBOutlet var style2: UIButton!
    @IBOutlet var style3: UIButton!
    @IBOutlet var style4: UIButton!
    @IBOutlet var style5: UIButton!
    
    /*
    @IBOutlet var colorPicker1: UIButton!
    @IBOutlet var colorPicker2: UIButton!
    @IBOutlet var colorPicker3: UIButton!
    @IBOutlet var colorPicker4: UIButton!
    @IBOutlet var colorPicker5: UIButton!
    */
    
    
    var attributes: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "Avenir-Book", size: 20),
        .foregroundColor : UIColor.black,
    
    ]
    
    var fontSize: CGFloat = 14
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //style1.backgroundColor = UIColor.rgb(red: 246, green: 109, blue: 48)
        style1.setBackgroundImage(UIImage(named: "fondo1"), for: .normal)
        style1.layer.cornerRadius = 5
        style1.layer.masksToBounds = true
        
        style2.backgroundColor = UIColor.rgb(red: 255, green: 204, blue: 0)
        style2.layer.cornerRadius = 5
        
        style3.backgroundColor = UIColor.rgb(red: 0, green: 122, blue: 255)
        style3.layer.cornerRadius = 5
        
        style4.backgroundColor = UIColor.rgb(red: 255, green: 149, blue: 0)
        style4.layer.cornerRadius = 5
        
        style5.backgroundColor = UIColor.rgb(red: 218, green: 202, blue: 229)
        style5.layer.cornerRadius = 5

        
        
        /*
        
                   for family: String in UIFont.familyNames {
                   print("\(family)")
                   for names: String in UIFont.fontNames(forFamilyName: family) {
                   print("== \(names)")
                   }
                   }
        */
     //  navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "gear").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleLogOut))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(postAction))
        
 
        
        
       picker.delegate = self
       textoIngresado.text = "What is your prayer"
    //   textoIngresado.textColor = .lightGray
       textoIngresado.delegate = self
        textoIngresado.isScrollEnabled = true
        
     
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
            
            img.tag = 100
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
        textoIngresado.backgroundColor = .clear
      
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
                                    "date": Date().millisecondsSince1970,
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
    
    func captureScreen() -> UIImage
    {
      //  var tamano = siTieneFoto.bounds.size
        //   tamano.height = 380
        // tamano.width = 384
   //     var limite = view.bounds
    //    limite.origin = CGPoint(x: 15, y: 162)
    //    limite.size = tamano
   //     limite.size.height = limite.size.height
  //      view.backgroundColor = .clear
      let renderer = UIGraphicsImageRenderer(size: siTieneFoto.bounds.size)

        let image = renderer.image(actions: { context in
            textoIngresado.drawHierarchy(in: siTieneFoto.bounds, afterScreenUpdates: true)
        })

        return image
    }
    
    func textoToImage() -> UIImage {
        
        
        let img = UIImageView(frame: textoIngresado.bounds)
        img.image = siTieneFoto.image
                 
        img.tag = 100
                 textoIngresado.backgroundColor = UIColor.clear
                 textoIngresado.addSubview( img)
               //  self.view.addSubview(textView)
                 textoIngresado.sendSubviewToBack(img)
                 
        
       
        
        
   //    UIGraphicsBeginImageContextWithOptions(textoIngresado.visibleSize, textoIngresado.isOpaque, 0.0)
    
       
        UIGraphicsBeginImageContextWithOptions(textoIngresado.frame.size, textoIngresado.isOpaque, 0.0)
       let savedContentOffset: CGPoint = textoIngresado.contentOffset
        let savedFrame: CGRect = textoIngresado.frame
        
        textoIngresado.contentOffset = .zero
      textoIngresado.frame = CGRect(x: 0, y: 0, width: textoIngresado.frame.size.width, height: textoIngresado.frame.size.height)
        
        textoIngresado.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let imagena = UIGraphicsGetImageFromCurrentImageContext()
        
        textoIngresado.contentOffset = savedContentOffset
        textoIngresado.frame = savedFrame
        
        UIGraphicsEndImageContext()
        
        return imagena!
    }
    // MARK:   --------------------------------------- TEXT STYLE --------------------------------------
    func backToNormal () {
        
        
               DispatchQueue.main.async {
                   
                   
                   self.textoIngresado.backgroundColor = .white
                   
                   let quote = self.textoIngresado.text!
                   
                   let font = UIFont(name: "Avenir-Book", size: CGFloat(14))
              //     let font = UIFont(name: "LeagueGothic", size: CGFloat(self.fontSize))
                   let paragraphStyle = NSMutableParagraphStyle()
                   paragraphStyle.alignment = .left
                  
                   self.attributes[.foregroundColor] = UIColor.black
                   self.attributes[.font] = font
                   self.attributes[.paragraphStyle] = paragraphStyle
                   let attributedQuote = NSAttributedString(string: quote, attributes: self.attributes)
                   self.textoIngresado.attributedText = attributedQuote
                   self.textoIngresado.isScrollEnabled = true
                   self.styleEnable = 0
                  self.textoIngresado.returnVertical ()
               }
               
    }
    @IBAction func style1(_ sender: Any) {
       // textoIngresado.backgroundColor = UIColor(red:81.0/255.0, green:224.0/255.0, blue:225.0/255.0, alpha:1.0)
        
  
        if styleEnable == 1 {
            
           backToNormal()
       
            
        } else {
        
  
        
        textoIngresado.isScrollEnabled = false
        
        styleEnable = 1
        textoIngresado.centerVertically()
      //  RGB: (246, 246, 214) (218, 202, 229)
        
        
        
        
    
     //   textoIngresado.backgroundColor = UIColor.rgb(red: 246, green: 109, blue: 48)

          
        
     //   textoIngresado.backgroundColor = UIColor.rgb(red: 218, green: 202, blue: 229)
        let quote = textoIngresado.text!
        
        switch quote.count {
            
        case 1...50:
        fontSize = 60
        case 50...60:
        fontSize = 50
        case 60...70:
        fontSize = 40
        default:
            fontSize = 14
        }
        
        
     
            let font = UIFont(name: "LeagueGothic", size: CGFloat(self.fontSize))
     //   let font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
            self.attributes[.paragraphStyle] = paragraphStyle
            self.attributes[.foregroundColor] = UIColor.white
            self.attributes[.font] = font
            
            
            hasImage = true
        
   
        
            let attributedQuote = NSAttributedString(string: quote, attributes: self.attributes)

            self.textoIngresado.attributedText = attributedQuote
            self.textoIngresado.isScrollEnabled = false
            self.textoIngresado.backgroundColor = .clear
            
          DispatchQueue.main.async {
            self.siTieneFoto.image = UIImage(named: "fondo1")
            self.siTieneFoto.contentMode = .scaleAspectFill
            self.siTieneFoto.setNeedsDisplay()
            
            }
        }
        
        

        
       // let img = UIImageView(frame: textoIngresado.bounds)
        //img.image = UIImage(named: "fondo1")
                   
        //img.tag = 100
      //textoIngresado.backgroundColor = UIColor.clear
      
      //textoIngresado.addSubview(imagenDFondo)
                 //  self.view.addSubview(textView)
      //textoIngresado.sendSubviewToBack(imagenDFondo)
       // */
      
    }
    
    @IBAction func style2(_ sender: Any) {
        
        hasImage = true
        textoIngresado.backgroundColor = UIColor.rgb(red: 246, green: 109, blue: 48)
        
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
    
    
    /*
    @IBAction func imageBackground(_ sender: Any) {
        
        selectionVideoPhoto = "backgroundForText"
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
        
    }
    
    
    @IBAction func changeTypoLeague(_ sender: Any) {
        
        let texto = textoIngresado.attributedText
        let font = UIFont(name: "LeagueGothic", size: CGFloat(fontSize))
        attributes[.font] = font
        
        let attributedQuote = NSAttributedString(string: texto?.string ?? "", attributes: attributes)
        textoIngresado.attributedText = attributedQuote
    }
    
    
    
    @IBAction func changeTypoAvenir(_ sender: Any) {
        
              let texto = textoIngresado.attributedText
              let font = UIFont(name: "Avenir-Book", size: CGFloat(fontSize))
              attributes[.font] = font
              
              let attributedQuote = NSAttributedString(string: texto?.string ?? "", attributes: attributes)
              textoIngresado.attributedText = attributedQuote
        
        
        
    }
    
    
    @IBAction func centerHorizontal(_ sender: Any) {
        
        let texto = textoIngresado.attributedText
              
         //     attributes[.a] = font
              
              let attributedQuote = NSAttributedString(string: texto?.string ?? "", attributes: attributes)
              textoIngresado.attributedText = attributedQuote
        
        
    }
    
    @IBAction func centerVertical(_ sender: Any) {
        
         textoIngresado.centerVertically()
        
    }
    
    */
    
    
}







// ------------------------------------------------ MARK: TEXT DELEGATE -------------------------

extension PrayPostViewController: UITextViewDelegate {
    /*
    func adjustUITextViewHeight(arg : UITextView)
    {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
    }
 
 */
    
    func textViewDidChange(_ textView: UITextView) {
        
        if styleEnable != 0 {
         //   textoIngresado.textAlignment = .center
          //  textoIngresado.isScrollEnabled = false
             textoIngresado.centerVertically()
        //     textoIngresado.addSubview(imagenDFondo)
                           //  self.view.addSubview(textView)
         //       textoIngresado.sendSubviewToBack(imagenDFondo)
        }
        /*
        if styleEnable == 1 {
            
          //  textoIngresado.centerVertically()
            
            let quote = textoIngresado.text!
            let font = attributes[.font] as! UIFont
            attributes[.font] = font.withSize(CGFloat(fontSize))
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .left
            // paragraphStyle.firstLineHeadIndent = 5.0
            
            attributes[  .paragraphStyle] = paragraphStyle
            
            let attributedQuote = NSAttributedString(string: quote, attributes: attributes)
            
            textoIngresado.attributedText = attributedQuote
            
            
            
        }
        */
        
    
        // adjustUITextViewHeight(arg: textView)
        
        /*
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
        let numberOfLines = textoIngresado.layoutManager.numberOfLines
        
        if textoIngresado.text.count > 50 && textoIngresado.text.count  < 60  || numberOfLines < 6 {
            print ("Entre 50 y 60")
            print (numberOfLines)
            textoIngresado.isScrollEnabled = false
                   let quote = textoIngresado.text!
                   let font = attributes[.font] as! UIFont
                    fontSize = 50
                   attributes[.font] = font.withSize(fontSize)
                   let paragraphStyle = NSMutableParagraphStyle()
                   paragraphStyle.alignment = .center
                   // paragraphStyle.firstLineHeadIndent = 5.0
                   
                   attributes[.paragraphStyle] = paragraphStyle
                   
                   let attributedQuote = NSAttributedString(string: quote, attributes: attributes)
                   
                   textoIngresado.attributedText = attributedQuote
                   
               }
        
        
        if textoIngresado.text.count > 60 && textoIngresado.text.count  < 80  || numberOfLines > 6 &&  numberOfLines < 11 {
                   print ("Entre 60 y 60")
                              print (numberOfLines)
                   let quote = textoIngresado.text!
                   let font = attributes[.font] as! UIFont
                   fontSize = 30
                   attributes[.font] = font.withSize(fontSize)
                   let paragraphStyle = NSMutableParagraphStyle()
                   paragraphStyle.alignment = .center
                   // paragraphStyle.firstLineHeadIndent = 5.0
                   
                   attributes[  .paragraphStyle] = paragraphStyle
                   
                   let attributedQuote = NSAttributedString(string: quote, attributes: attributes)
                   
                   textoIngresado.attributedText = attributedQuote
                   
               }
        
        
        if textoIngresado.text.count > 80 && textoIngresado.text.count  < 100  || numberOfLines >= 11 {
                          print("Mayour a 11 liieas")
                          let quote = textoIngresado.text!
                          let font = attributes[.font] as! UIFont
            
                          fontSize = 14
                          attributes[.font] = UIFont(name: "Avenir-Book", size: fontSize)
                          let paragraphStyle = NSMutableParagraphStyle()
                          paragraphStyle.alignment = .left
                          // paragraphStyle.firstLineHeadIndent = 5.0
                          attributes[.foregroundColor] = UIColor.black
                          attributes[ .paragraphStyle] = paragraphStyle
                          
                          let attributedQuote = NSAttributedString(string: quote, attributes: attributes)
                          
                          textoIngresado.attributedText = attributedQuote
            
        
                          textoIngresado.backgroundColor = .white
            
                          for subview in self.textoIngresado.subviews {
                              if (subview.tag == 1) {
                                  subview.removeFromSuperview()
                              }
                          }
                        styleEnable = 0
                        textoIngresado.returnVertical()
                        
            if styleEnable == 0 {
            siTieneFoto.image = nil
            }
                        // Para remover el centrado ===============
            
                        /*
                         let removeEverything = UITextView ()
                        removeEverything.attributedText = textoIngresado.attributedText
                        textoIngresado = removeEverything
            
                        */
          
                      }
      
        

    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        let attributedQuote = NSMutableAttributedString(string: "", attributes: attributes)
        
        textoIngresado.attributedText = attributedQuote
      
        
        /*
        
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
 */
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        /*
        if textView.text.isEmpty {
            textView.text = "Placeholder"
            textView.textColor = UIColor.lightGray
        }
 */
        
    }
    
  
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
 
}


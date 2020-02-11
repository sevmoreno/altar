//
//  DevotionalCreatorViewController.swift
//  altar
//
//  Created by Juan Moreno on 1/13/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import UIKit
import Firebase


class DevotionalCreatorViewController: UIViewController {

    @IBOutlet weak var devText: UITextView!
    
    var attributedString = NSMutableAttributedString(string: "")
    
    struct devocionalFormato {
        
        var texto: String!
        var atributos: [NSAttributedString.Key:Any]
        
    }
    var devocionalRichText = [NSAttributedString] ()
    var decocionalToSave = [devocionalFormato] ()
    
    @IBOutlet weak var scroll: UIScrollView!
    
    @IBOutlet var titulo: UITextField!
    
    var attributes = [
               
             //  NSAttributedString.Key.underlineStyle : 1,
               NSAttributedString.Key.foregroundColor : UIColor.black,
               NSAttributedString.Key.font: UIFont(name: "Avenir-Book", size: 15)
             //  NSAttributedString.Key.strokeWidth : 3.0
                  
               ] as [NSAttributedString.Key : Any]
    
    var boldActive = false
    
    lazy var accessory: UIView = {
        let accessoryView = UIView(frame: .zero)
        //accessoryView.backgroundColor = .lightGray
        accessoryView.alpha = 0.6
        return accessoryView
    }()
    let IndexButton: UIButton = {
        let cancelButton = UIButton(type: .custom)
       // cancelButton.setTitle("Index", for: .normal)
        let imagen = UIImage(named: "indexButton")
        cancelButton.setImage(imagen?.withRenderingMode(.alwaysOriginal), for: .normal)
        cancelButton.setTitleColor(UIColor.red, for: .normal)
        cancelButton.addTarget(self, action:
        #selector(indexButtonAction), for: .touchUpInside)
        cancelButton.showsTouchWhenHighlighted = true
        return cancelButton
    }()
    
    let captialsButton: UIButton = {
         let cancelButton = UIButton(type: .custom)
      //   cancelButton.setTitle("Aa", for: .normal)
        let imagen = UIImage(named: "capitalButton")
              cancelButton.setImage(imagen?.withRenderingMode(.alwaysOriginal), for: .normal)
        // cancelButton.setTitleColor(UIColor.red, for: .normal)
         cancelButton.addTarget(self, action:
         #selector(capitalButtonAction), for: .touchUpInside)
         cancelButton.showsTouchWhenHighlighted = true
         return cancelButton
     }()
    
    
    lazy var boldsButton: UIButton = {
            let cancelButton = UIButton(type: .custom)
          //  cancelButton.setTitle("n", for: .normal)
           // cancelButton.setTitleColor(UIColor.red, for: .normal)
        let imagen = UIImage(named: "boldbutton")
        cancelButton.setImage(imagen?.withRenderingMode(.alwaysOriginal), for: .normal)
               // cancelButton.setTitleColor(UIColor.red, for: .normal)
            cancelButton.addTarget(self, action:
            #selector(boldlButtonAction), for: .touchUpInside)
            cancelButton.showsTouchWhenHighlighted = true
            return cancelButton
        }()
   
    
    let italicButton: UIButton = {
                let cancelButton = UIButton(type: .custom)
               // cancelButton.setTitle("i", for: .normal)
               // cancelButton.setTitleColor(UIColor.red, for: .normal)
        
        let imagen = UIImage(named: "italicButton")
        cancelButton.setImage(imagen?.withRenderingMode(.alwaysOriginal), for: .normal)
                cancelButton.addTarget(self, action:
                #selector(italicButtonAction), for: .touchUpInside)
                cancelButton.showsTouchWhenHighlighted = true
                return cancelButton
            }()
    
   let bigger: UIButton = {
            let cancelButton = UIButton(type: .custom)
            // cancelButton.setTitle("+", for: .normal)
           // cancelButton.setTitleColor(UIColor.red, for: .normal)
    
    let imagen = UIImage(named: "bigtypoButton")
    cancelButton.setImage(imagen?.withRenderingMode(.alwaysOriginal), for: .normal)
            cancelButton.addTarget(self, action:
            #selector(biggerButtonAction), for: .touchUpInside)
            cancelButton.showsTouchWhenHighlighted = true
            return cancelButton
        }()
    
    let small: UIButton = {
             let cancelButton = UIButton(type: .custom)
            // cancelButton.setTitle("-", for: .normal)
            // cancelButton.setTitleColor(UIColor.red, for: .normal)
        
        let imagen = UIImage(named: "smalltypoButton")
           cancelButton.setImage(imagen?.withRenderingMode(.alwaysOriginal), for: .normal)
             cancelButton.addTarget(self, action:
             #selector(smallButtonAction), for: .touchUpInside)
             cancelButton.showsTouchWhenHighlighted = true
             return cancelButton
         }()
    
    let doneButton: UIButton = {
             let cancelButton = UIButton(type: .custom)
        
        let imagen = UIImage(named: "doneButton")
        cancelButton.setImage(imagen?.withRenderingMode(.alwaysOriginal), for: .normal)
          //   cancelButton.setTitle("Done", for: .normal)
            // cancelButton.setTitleColor(UIColor.red, for: .normal)
             cancelButton.addTarget(self, action:
             #selector(doneButtonAction), for: .touchUpInside)
             cancelButton.showsTouchWhenHighlighted = true
             return cancelButton
         }()
     
    func addAccessory() {
        accessory.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 45)
        accessory.backgroundColor = UIColor.rgb(red: 36, green: 42, blue: 55)
        accessory.translatesAutoresizingMaskIntoConstraints = false
      //  IndexButton.translatesAutoresizingMaskIntoConstraints = false
      //  IndexButton.translatesAutoresizingMaskIntoConstraints = false
     //   boldsButton.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [IndexButton, captialsButton, boldsButton, italicButton,bigger
        ,small,doneButton ])
               
            stackView.translatesAutoresizingMaskIntoConstraints = false
    
        stackView.distribution = .fillEqually
            stackView.axis = .horizontal
            stackView.spacing = 2
               
         accessory.addSubview(stackView)
        
            stackView.anchor(top: accessory.topAnchor, left: accessory.leftAnchor, bottom: accessory.bottomAnchor, right: accessory.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: accessory.frame.width, height: accessory.frame.height)
        devText.inputAccessoryView = accessory
        
        /*
        accessory.addSubview(IndexButton)
        accessory.addSubview(captialsButton)
        accessory.addSubview(boldsButton)
        accessory.addSubview(italicButton)
        accessory.addSubview(bigger)
        accessory.addSubview(small)
        accessory.addSubview(doneButton)
        NSLayoutConstraint.activate([
        IndexButton.leadingAnchor.constraint(equalTo:
        accessory.leadingAnchor, constant: 20),
        IndexButton.centerYAnchor.constraint(equalTo:
        accessory.centerYAnchor),
        captialsButton.centerXAnchor.constraint(equalTo:
        accessory.centerXAnchor),
        captialsButton.centerYAnchor.constraint(equalTo:
        accessory.centerYAnchor),
        boldsButton.trailingAnchor.constraint(equalTo:
        accessory.trailingAnchor, constant: -20),
        boldsButton.centerYAnchor.constraint(equalTo:
        accessory.centerYAnchor)
        ])
 */
    }
    
    
    @objc func indexButtonAction () {
        
        print("Index Button")
        print(devText.selectedRange)
               
               //devText.attributedText!
               
              // attributedString.append(secondString)
              // let rango = devText.selectedRange
              // let prueba = devText.attributedText as! NSMutableAttributedString
               
              // prueba.addAttribute(.foregroundColor, value: UIColor.red, range: rango)
              // devText.attributedText = prueba
        let creatMutable = NSMutableAttributedString(attributedString: devText.attributedText)
               
        creatMutable.addAttribute(.foregroundColor, value: UIColor.red, range: devText.selectedRange)
        devText.attributedText = creatMutable
        
    }
    
    @objc func capitalButtonAction () {
        
        
    }
    
    @objc func boldlButtonAction () {
        
        if devText.selectedRange.length == 0 {
            
            if boldActive {
                let imagen = UIImage(named: "notbold")
                self.attributes[NSAttributedString.Key.font] = UIFont(name: "Avenir-Book", size: 12)
                
                DispatchQueue.main.async {
                    self.boldsButton.setImage(imagen?.withRenderingMode(.alwaysOriginal), for: .normal)
                }
                boldActive = false
            } else {
                let imagen = UIImage(named: "boldbutton")
                self.attributes[NSAttributedString.Key.font] = UIFont(name: "Avenir-Heavy", size: 12)
                               DispatchQueue.main.async {
                                   self.boldsButton.setImage(imagen?.withRenderingMode(.alwaysOriginal), for: .normal)
                               }
                boldActive = true
            }
            
        }
        
        let creatMutable = NSMutableAttributedString(attributedString: devText.attributedText)
        
        creatMutable.enumerateAttribute(.font, in: devText.selectedRange) { value, range, stop in
            if let font = value as? UIFont {
              
          
                
                if font.fontDescriptor.symbolicTraits.contains(.traitBold) {
                  
                    print("Es Bold")
                    let imagen = UIImage(named: "notbold")
                   
                                  // cancelButton.setTitleColor(UIColor.red, for: .normal)
                    
                    creatMutable.addAttribute(.font, value: UIFont(name: "Avenir-Book", size: font.pointSize), range: devText.selectedRange)
                    
                    DispatchQueue.main.async {
                        self.boldsButton.setImage(imagen?.withRenderingMode(.alwaysOriginal), for: .normal)
                    }
                     
                     
                    // creatMutable.addAttribute(.foregroundColor, value: UIColor.red, range: range)
                } else {
                    
                     print("NO Es Bold")
                    let imagen = UIImage(named: "boldbutton")
          
                    creatMutable.addAttribute(.font, value: UIFont(name: "Avenir-Heavy", size: font.pointSize), range: devText.selectedRange)
                    
                    DispatchQueue.main.async {
                        self.boldsButton.setImage(imagen?.withRenderingMode(.alwaysOriginal), for: .normal)
                    }
                    
                }
                
                devText.attributedText = creatMutable
                
            }
        }
        
     
        
    }
    

    @objc func italicButtonAction () {
        
        let creatMutable = NSMutableAttributedString(attributedString: devText.attributedText)
              
              creatMutable.enumerateAttribute(.font, in: devText.selectedRange) { value, range, stop in
                  if let font = value as? UIFont {
                    
                
                      
                      if font.fontDescriptor.symbolicTraits.contains(.traitItalic) {
                        
                          print("Es Italic")
                          let imagen = UIImage(named: "notitalick")
                         
                                        // cancelButton.setTitleColor(UIColor.red, for: .normal)
                          
                          creatMutable.addAttribute(.font, value: UIFont(name: "Avenir-Book", size: font.pointSize), range: devText.selectedRange)
                          
                          DispatchQueue.main.async {
                              self.italicButton.setImage(imagen?.withRenderingMode(.alwaysOriginal), for: .normal)
                          }
                           
                           
                          // creatMutable.addAttribute(.foregroundColor, value: UIColor.red, range: range)
                      } else {
                          
                           print("NO Es Italic")
                          let imagen = UIImage(named: "italicButton")
                
                          creatMutable.addAttribute(.font, value: UIFont(name: "Avenir-BookOblique", size: font.pointSize), range: devText.selectedRange)
                          
                          DispatchQueue.main.async {
                              self.italicButton.setImage(imagen?.withRenderingMode(.alwaysOriginal), for: .normal)
                          }
                          
                      }
                      
                      devText.attributedText = creatMutable
                      
                  }
              }
              
           
              
        
    }
    
    @objc func biggerButtonAction () {
        
        let creatMutable = NSMutableAttributedString(attributedString: devText.attributedText)
              
              creatMutable.enumerateAttribute(.font, in: devText.selectedRange) { value, range, stop in
                
                if let font = value as? UIFont {
                    
                    let name = font.fontName
                    creatMutable.addAttribute(.font, value: UIFont(name: name, size: font.pointSize + 2), range: devText.selectedRange)
                          
                }
                
                }
                      
            devText.attributedText = creatMutable
                      
                  
        
    }
    
    @objc func smallButtonAction () {
        
        let creatMutable = NSMutableAttributedString(attributedString: devText.attributedText)
                 
                 creatMutable.enumerateAttribute(.font, in: devText.selectedRange) { value, range, stop in
                   
                   if let font = value as? UIFont {
                      let name = font.fontName
                       creatMutable.addAttribute(.font, value: UIFont(name: name, size: font.pointSize - 2), range: devText.selectedRange)
                             
                   }
                   
                   }
                         
               devText.attributedText = creatMutable
                         
        
    }
    
    @objc func doneButtonAction () {
        
         let creatMutable = NSMutableAttributedString(attributedString: devText.attributedText)
                
            //    creatMutable.addAttribute(.foregroundColor, value: UIColor.red, range: devText.selectedRange)
         devText.attributedText = creatMutable
         devText.endEditing(true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // NAVIGATION SETTINGS
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post Devotional", style: .plain, target: self, action: #selector(postDevotional))
        navigationItem.leftBarButtonItem?.title = "Back"
        
        
         let attributostitulo = [
           
         //  NSAttributedString.Key.underlineStyle : 1,
            NSAttributedString.Key.foregroundColor : advengers.shared.colorOrange,
           NSAttributedString.Key.font: UIFont(name: "Avenir", size: 15)
         //  NSAttributedString.Key.strokeWidth : 3.0
              
           ] as [NSAttributedString.Key : Any]
        // let font = UIFont(name: "Avenir", size: 15)
        navigationItem.rightBarButtonItem?.setTitleTextAttributes(attributostitulo, for: .normal)
        
        navigationItem.rightBarButtonItem?.tintColor = advengers.shared.colorOrange
        
        // VIEW SETTINGS
        
        print(devText.selectedRange)
        /*
        let attributes2 = devText.attributedText.attributes(at: 0, effectiveRange: nil)

        // iterate each attribute
        for attr in attributes2 {
          print(attr.key, attr.value)
        }
        
        */
        
        //devText.attributedText
    
        /*
        
        let yourButton = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.size.width/8, height: 40))
        yourButton.backgroundColor = UIColor.blue
        yourButton.setTitle("Bold", for: .normal)
        yourButton.setTitleColor(UIColor.white, for: .normal)
        yourButton.addTarget(self, action: #selector(nextButton), for: .touchUpInside)
      //  devText.inputAccessoryView = yourButton
        */
        
        addAccessory()
      
        devText.delegate = self
        
        for family: String in UIFont.familyNames {
               print("\(family)")
               for names: String in UIFont.fontNames(forFamilyName: family) {
                   print("== \(names)")
               }
           }
       
 
       
        
        if devocionalRichText.isEmpty {
        
        devText.attributedText = NSAttributedString(string: "Add your devotional here...", attributes: attributes)
        
        }
      //  devText.selectedRange
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func seleccionFoto(_ sender: Any) {
        
 //     let sellectFoto = SeleccionFotoCollectionViewController(collectionViewLayout: UICollectionViewLayout())
        
   //  present(sellectFoto, animated: true, completion: nil)

        let newViewController = SeleccionFotoCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        self.navigationController?.pushViewController(newViewController, animated: true)
       // performSegue(withIdentifier: "seleccionFoto", sender: self)
    }
    
    
    @objc func nextButton()
    {
        print("Index")
        print(devText.selectedRange)
        
        //devText.attributedText!
        
       // attributedString.append(secondString)
       // let rango = devText.selectedRange
       // let prueba = devText.attributedText as! NSMutableAttributedString
        
       // prueba.addAttribute(.foregroundColor, value: UIColor.red, range: rango)
       // devText.attributedText = prueba
        let creatMutable = NSMutableAttributedString(attributedString: devText.attributedText)
        
        creatMutable.addAttribute(.foregroundColor, value: UIColor.red, range: devText.selectedRange)
        devText.attributedText = creatMutable
        
    }
    @IBAction func bold(_ sender: Any) {
        print(devText.selectedRange)
        
        
        attributedString.addAttribute(.foregroundColor, value: UIColor.red, range: devText.selectedRange)
        devText.attributedText = attributedString
        
    }
    
    @objc func postDevotional () {
        
        let iglesia = advengers.shared.currentChurch
        let userPostRef = Database.database().reference().child("devocionales").child(iglesia)
        let ref = userPostRef.childByAutoId()
        
        
       

       
        let attrString = devText.attributedText
        guard let x = attrString else {return}
        var resultHtmlText = ""
        do {

            let r = NSRange(location: 0, length: x.length)
            let att = [NSAttributedString.DocumentAttributeKey.documentType: NSAttributedString.DocumentType.html]
            let d = try x.data(from: r, documentAttributes: att)

            if let h = String(data: d, encoding: .utf8) {
                resultHtmlText = h
                
   // ------------------------------------ ACA SALVAMOS AL STORAGE LA DATA  ---------------------------------
                let filename = NSUUID().uuidString
                let storageRefDB = Storage.storage().reference().child("devotionales").child(iglesia).child(filename)
                storageRefDB.putData(d, metadata: nil, completion: { (metadata, err) in
                    
                    if let err = err {
                        print("Failed to upload profile image:", err)
                        return
                    }
                    
                    // Firebase 5 Update: Must now retrieve downloadURL
                    storageRefDB.downloadURL(completion: { (downloadURL, err) in
                        if let err = err {
                            print("Failed to fetch downloadURL:", err)
                            return
                        }
                        
                        guard let profileImageUrl = downloadURL?.absoluteString else { return }
                        
                        guard let uid = Auth.auth().currentUser?.uid else {return}
                        
                        
                        
                        let devo = ["urltexto": profileImageUrl,"texto": self.devText.text ,"title": self.titulo.text!, "creationDate": Date().timeIntervalSince1970, "usuarioID": Auth.auth().currentUser?.uid] as [String : Any]
                        
                        ref.updateChildValues(devo) { (err, ref) in
                            if let err = err {
                                //self.navigationItem.rightBarButtonItem?.isEnabled = true
                                print("Failed to save post to DB", err)
                                return
                            }
                            
                            print("Successfully saved post to DB")
                            
                        }
      
                
                    })
                })
                

                
            }
        }
        catch {
            print("utterly failed to convert to html!!! \n>\(x)<\n")
        }
        print(resultHtmlText)
        
        

        
        print("editing")
    }


}


extension DevotionalCreatorViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
      //  scroll.setContentOffset(CGPoint(x: 0, y: (textView.superview?.frame.origin.y)!), animated: true)
        
    let attributes = [
               
             //  NSAttributedString.Key.underlineStyle : 1,
               NSAttributedString.Key.foregroundColor : UIColor.black
             //  NSAttributedString.Key.font: UIFont.systemFontSize
             //  NSAttributedString.Key.strokeWidth : 3.0
                  
               ] as [NSAttributedString.Key : Any]
           
           if devocionalRichText.isEmpty {
            
            
           // attributedString.addAttribute(.link, value: "https://www.hackingwithswift.com", range: NSRange(location: 19, length: 55))
            let secondString = NSAttributedString(string: "", attributes: attributes)
            attributedString.append(secondString)

           devText.attributedText = attributedString
           
        //   devText.attributedText = NSAttributedString(string: "", attributes: attributes)
            
           
          
           }
               
       // devText.t
        

        
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        /*
        if textView.selectedRange.length == 0 {
            
            let creatMutable = NSMutableAttributedString(attributedString: devText.attributedText)
           
            creatMutable.setAttributes(attributes, range: textView.selectedRange)
            
            devText.attributedText = creatMutable
        } else {
            
            let creatMutable = NSMutableAttributedString(attributedString: devText.attributedText)
            devText.attributedText = creatMutable
        }
 */
        
         
        
       let creatMutable = NSMutableAttributedString(attributedString: devText.attributedText)
      //  secondString.att
  
       devText.attributedText = creatMutable
      // scroll.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    func textViewDidChange(_ textView: UITextView) { //Handle the text changes here
       
        /*
       if textView.selectedRange.length == 0 {
           
           let creatMutable = NSMutableAttributedString(attributedString: devText.attributedText)
          
           creatMutable.setAttributes(attributes, range: textView.selectedRange)
           
           devText.attributedText = creatMutable
       } else {
           
           let creatMutable = NSMutableAttributedString(attributedString: devText.attributedText)
           devText.attributedText = creatMutable
       }
        */
        
         devText.typingAttributes = self.attributes
        /*
        
    let creatMutable = NSMutableAttributedString(attributedString: devText.attributedText)

    devText.attributedText = creatMutable
        */
        
    }
    
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        
       
        
        
        let creatMutable2 = NSMutableAttributedString(attributedString: textView.attributedText)
        
        creatMutable2.enumerateAttribute(.font, in: textView.selectedRange) { value, range, stop in
            if let font = value as? UIFont {
              
          
                
                if font.fontDescriptor.symbolicTraits.contains(.traitBold) {
                  
                  
                     
                     
                    print("NO Es Bold")
                                 let imagen = UIImage(named: "boldbutton")
                               
                                 DispatchQueue.main.async {
                                     self.boldsButton.setImage(imagen?.withRenderingMode(.alwaysOriginal), for: .normal)
                                 }
                                 
                    
                    // creatMutable.addAttribute(.foregroundColor, value: UIColor.red, range: range)
                } else {
                    
              print("Es Bold")
                                let imagen = UIImage(named: "notbold")

                                DispatchQueue.main.async {
                                    self.boldsButton.setImage(imagen?.withRenderingMode(.alwaysOriginal), for: .normal)
                                }
                }
                
                
                if font.fontDescriptor.symbolicTraits.contains(.traitItalic) {
                          
                           
                             
                             
                                                         print("NO Es Bold")
                                                        let imagen = UIImage(named: "italicButton")
                                                      
                                                        DispatchQueue.main.async {
                                                            self.italicButton.setImage(imagen?.withRenderingMode(.alwaysOriginal), for: .normal)
                                                        }
                            // creatMutable.addAttribute(.foregroundColor, value: UIColor.red, range: range)
                        } else {
                           
                            print("Es Bold")
                                                       let imagen = UIImage(named: "notitalick")

                                                       DispatchQueue.main.async {
                                                           self.italicButton.setImage(imagen?.withRenderingMode(.alwaysOriginal), for: .normal)
                                                       }
                        }
        
        
            }
        }
        
    }
        
  //   let prueba = devText.attributedText as? NSMutableAttributedString
      //  attributedString = devText.attributedText as! NSMutableAttributedString
  //  }
    
    /*
    private func textViewdDidBeginEditing(_ textField: UITextField) {
        scroll.setContentOffset(CGPoint(x: 0, y: (textField.superview?.frame.origin.y)!), animated: true)
    }

    private func textViewDidEndEditing(_ textField: UITextField) {
        scroll.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }

*/
   
    
    
}

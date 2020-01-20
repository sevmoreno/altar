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
    
    var attributedString = NSMutableAttributedString(string: "Want to learn iOS? You should visit the best source of free iOS tutorials!")
    
    struct devocionalFormato {
        
        var texto: String!
        var atributos: [NSAttributedString.Key:Any]
        
    }
    var devocionalRichText = [NSAttributedString] ()
    var decocionalToSave = [devocionalFormato] ()
    
    @IBOutlet weak var scroll: UIScrollView!
    
    @IBOutlet var titulo: UITextField!
    
    
    let accessory: UIView = {
        let accessoryView = UIView(frame: .zero)
        accessoryView.backgroundColor = .lightGray
        accessoryView.alpha = 0.6
        return accessoryView
    }()
    let cancelButton: UIButton = {
        let cancelButton = UIButton(type: .custom)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(UIColor.red, for: .normal)
        cancelButton.addTarget(self, action:
        #selector(nextButton), for: .touchUpInside)
        cancelButton.showsTouchWhenHighlighted = true
        return cancelButton
    }()
    let charactersLeftLabel: UILabel = {
        let charactersLeftLabel = UILabel()
        charactersLeftLabel.text = "256"
        charactersLeftLabel.textColor = UIColor.white
        return charactersLeftLabel
    }()
    let sendButton: UIButton! = {
        let sendButton = UIButton(type: .custom)
        sendButton.setTitleColor(.red, for: .normal)
        sendButton.setTitle("Send", for: .normal)
        sendButton.setTitleColor(.white, for: .disabled)
        sendButton.addTarget(self, action: #selector(nextButton), for: .touchUpInside)
        sendButton.showsTouchWhenHighlighted = true
        sendButton.isEnabled = true
        return sendButton
    }()
    
    func addAccessory() {
        accessory.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 45)
        accessory.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        charactersLeftLabel.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        devText.inputAccessoryView = accessory
        accessory.addSubview(cancelButton)
        accessory.addSubview(charactersLeftLabel)
        accessory.addSubview(sendButton)
        NSLayoutConstraint.activate([
        cancelButton.leadingAnchor.constraint(equalTo:
        accessory.leadingAnchor, constant: 20),
        cancelButton.centerYAnchor.constraint(equalTo:
        accessory.centerYAnchor),
        charactersLeftLabel.centerXAnchor.constraint(equalTo:
        accessory.centerXAnchor),
        charactersLeftLabel.centerYAnchor.constraint(equalTo:
        accessory.centerYAnchor),
        sendButton.trailingAnchor.constraint(equalTo:
        accessory.trailingAnchor, constant: -20),
        sendButton.centerYAnchor.constraint(equalTo:
        accessory.centerYAnchor)
        ])
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let yourButton = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.size.width/8, height: 40))
        yourButton.backgroundColor = UIColor.blue
        yourButton.setTitle("Bold", for: .normal)
        yourButton.setTitleColor(UIColor.white, for: .normal)
        yourButton.addTarget(self, action: #selector(nextButton), for: .touchUpInside)
      //  devText.inputAccessoryView = yourButton
        
        addAccessory()
      
        devText.delegate = self
        
         navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post Devotional", style: .plain, target: self, action: #selector(postDevotional))
 
        let attributes = [
            
          //  NSAttributedString.Key.underlineStyle : 1,
            NSAttributedString.Key.foregroundColor : UIColor.lightGray
          //  NSAttributedString.Key.font: UIFont.systemFontSize
          //  NSAttributedString.Key.strokeWidth : 3.0
               
            ] as [NSAttributedString.Key : Any]
        
        if devocionalRichText.isEmpty {
        
        devText.attributedText = NSAttributedString(string: "Add your devotional here...", attributes: attributes)
        
        }
      //  devText.selectedRange
        

        // Do any additional setup after loading the view.
    }
    

    
    @objc func nextButton()
    {
         print("do something")
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
        
        let storageRefDB = Storage.storage().reference().child("devotionales").child(iglesia)
        let refDB = storageRefDB.childByAutoId()
        
        
        storageRef.putData(uploadData, metadata: nil, completion: { (metadata, err) in
                      
                      if let err = err {
                          print("Failed to upload profile image:", err)
                          return
                      }
                      
                      // Firebase 5 Update: Must now retrieve downloadURL
                      storageRef.downloadURL(completion: { (downloadURL, err) in
                          if let err = err {
                              print("Failed to fetch downloadURL:", err)
                              return
                          }
                          
                          guard let profileImageUrl = downloadURL?.absoluteString else { return }
                          
                          guard let uid = authResult?.user.uid else {return}
                          
                          let usuariovalores = ["username":username, "photo":profileImageUrl]
                          let valores = [uid:usuariovalores]
                          
                          print(authResult?.user.uid)
                          Database.database().reference().child("users").updateChildValues(valores, withCompletionBlock: { (error, dataref) in
                              if let err = error {
                                  print ("error al salvar info")
                              }
                              
                              print("Succefully saved user")
                          })
                  
                      })
                  })
        
        let devo = ["texto": devText.attributedText, "title": titulo.text!, "creationDate": Date().timeIntervalSince1970] as [String : Any]
        
        ref.updateChildValues(devo) { (err, ref) in
            if let err = err {
                //self.navigationItem.rightBarButtonItem?.isEnabled = true
                print("Failed to save post to DB", err)
                return
            }
            
            print("Successfully saved post to DB")
            
        }
        
        print("editing")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
            let secondString = NSAttributedString(string: "gonna HATEEEE ", attributes: attributes)
            attributedString.append(secondString)

           devText.attributedText = attributedString
           
        //   devText.attributedText = NSAttributedString(string: "", attributes: attributes)
            
           
           
           }
               
       // devText.t
        

        
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        devText.attributedText = attributedString
      //  scroll.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    func textViewDidChange(_ textView: UITextView) { //Handle the text changes here
        
     let prueba = devText.attributedText as? NSMutableAttributedString
      //  attributedString = devText.attributedText as! NSMutableAttributedString
    }
    
    /*
    private func textViewdDidBeginEditing(_ textField: UITextField) {
        scroll.setContentOffset(CGPoint(x: 0, y: (textField.superview?.frame.origin.y)!), animated: true)
    }

    private func textViewDidEndEditing(_ textField: UITextField) {
        scroll.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }

*/
    
    
}

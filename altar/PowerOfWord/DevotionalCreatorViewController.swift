//
//  DevotionalCreatorViewController.swift
//  altar
//
//  Created by Juan Moreno on 1/13/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import UIKit

class DevotionalCreatorViewController: UIViewController {

    @IBOutlet weak var devText: UITextView!
    
    @IBOutlet weak var scroll: UIScrollView!
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
            
            NSAttributedString.Key.underlineStyle : 1,
            NSAttributedString.Key.foregroundColor : UIColor.red,
            NSAttributedString.Key.strokeWidth : 3.0
               
            ] as [NSAttributedString.Key : Any]
        
        devText.attributedText = NSAttributedString(string: "NSAttributedString", attributes: attributes)
        
        
      //  devText.selectedRange
        

        // Do any additional setup after loading the view.
    }
    

    
    @objc func nextButton()
    {
         print("do something")
    }
    @IBAction func bold(_ sender: Any) {
        print(devText.selectedRange)
    }
    
    @objc func postDevotional () {
        
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
        scroll.setContentOffset(CGPoint(x: 0, y: (textView.superview?.frame.origin.y)!), animated: true)
        
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        scroll.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
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

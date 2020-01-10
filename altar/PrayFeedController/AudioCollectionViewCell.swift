//
//  AudioCollectionViewCell.swift
//  altar
//
//  Created by Juan Moreno on 1/9/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase

class AudioCollectionViewCell: UICollectionViewCell {
    
    var audioPlayer: AVAudioPlayer?
    let storage = Storage.storage()
    
    var post: Posts? {
           
           didSet {
              
               
               
               
 //              guard let postImageUrl = post?.photoImage else { return }
          
   //            photoImageView.loadImage(urlString: postImageUrl)

               usernameLabel.text = post?.author
               guard let profileuserURL = post?.userPhoto else {return}
               userProfileImageView.loadImage(urlString: profileuserURL)
               guard let urlA = post?.userPhoto  else {return}

               
               // setupAttributedCaption()
               
               
           }
           
       }
       

       
       fileprivate func setupAttributedCaption() {
           guard let post = self.post else { return }
           
           let attributedText = NSMutableAttributedString(string: post.author, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
           
           attributedText.append(NSAttributedString(string: " \(post.message ?? "Defaul Value")", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
           
           attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 4)]))
           
        //   let timeAgoDisplay = post.timeAgoDisplay()
        //   attributedText.append(NSAttributedString(string: timeAgoDisplay, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.gray]))
           captionLabel.isScrollEnabled = false
           captionLabel.attributedText = attributedText
           
       }
       
       
       let userProfileImageView: CustomImageView = {
           let iv = CustomImageView()
           iv.contentMode = .scaleAspectFill
           iv.clipsToBounds = true
           iv.backgroundColor = .blue
           return iv
       }()
       
       lazy var audioView: UIButton = {
        let iv = UIButton(type: .system)
        iv.setTitle("Play", for: .normal)
        iv.setTitleColor(.black, for: .normal)
           //  iv.contentMode = .scaleAspectFill
          // iv.layer.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
         //  iv.contentMode = .scaleAspectFit
          // iv.clipsToBounds = true
           iv.addTarget(self, action: #selector (hadlePlay), for: .touchUpInside)
           return iv
       }()
       
       let usernameLabel: UILabel = {
           let label = UILabel()
           label.text = "Username"
           label.font = UIFont.boldSystemFont(ofSize: 14)
           return label
       }()
       
       let optionsButton: UIButton = {
           let button = UIButton(type: .system)
           button.setTitle("•••", for: .normal)
           button.setTitleColor(.black, for: .normal)
           return button
       }()
       
       lazy var likeButton: UIButton = {
           let button = UIButton(type: .system)
           button.setImage(#imageLiteral(resourceName: "icon-like").withRenderingMode(.alwaysOriginal), for: .normal)
           button.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
           return button
       }()
       
       @objc func handleLike() {
           print("Handling like from within cell...")
       //    delegate?.didLike(for: self)
       }
       
       lazy var commentButton: UIButton = {
           let button = UIButton(type: .system)
           button.setImage(#imageLiteral(resourceName: "icon-comment-1").withRenderingMode(.alwaysOriginal), for: .normal)
           button.addTarget(self, action: #selector(handleComment), for: .touchUpInside)
           //button.addTarget(self, action: #selector(clickcomment), for: .touchUpInside)
           
           return button
       }()
       
       
       
       @objc func handleComment() {
           print("Trying to show comments...")
           guard let post = post else { return }
           
        //   delegate?.didTapComment(post: post)
           
       }
       
       let sendMessageButton: UIButton = {
           let button = UIButton(type: .system)
           button.setImage(#imageLiteral(resourceName: "icon-messenger").withRenderingMode(.alwaysOriginal), for: .normal)
           return button
       }()
       
       let bookmarkButton: UIButton = {
           let button = UIButton(type: .system)
           button.setImage(#imageLiteral(resourceName: "icon-notification-1").withRenderingMode(.alwaysOriginal), for: .normal)
           return button
       }()
       
       let captionLabel: UITextView = {
           let textView = UITextView()
           textView.font = UIFont.systemFont(ofSize: 14)
           
           textView.backgroundColor = .lightGray
           textView.isScrollEnabled = false
           return textView
       }()
       
       
       
       override init(frame: CGRect) {
           super.init(frame: frame)
           
           print("Este es el frame de la cell: \(frame.width),\(frame.height)")
           
         

              
           defaultCell()
           
       
           
       
         
           
           
         
       }
       
       required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
       func defaultCell () {
           
           
           addSubview(userProfileImageView)
           addSubview(usernameLabel)
           
           
     
           addSubview(audioView)
           
           let stackView = UIStackView(arrangedSubviews: [likeButton, commentButton])
           stackView.distribution = .fillEqually
           
           addSubview(stackView)
           
           userProfileImageView.translatesAutoresizingMaskIntoConstraints = false
           userProfileImageView.layer.cornerRadius = 40 / 2
           userProfileImageView.topAnchor.constraint(equalTo: topAnchor, constant:8).isActive = true
           userProfileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant:8).isActive = true
           userProfileImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
           userProfileImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
           userProfileImageView.bottomAnchor.constraint(equalTo: audioView.topAnchor, constant: -8).isActive = true
          // userProfileImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
          // userProfileImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
           
          // userProfileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
           
           usernameLabel.translatesAutoresizingMaskIntoConstraints = false
          
            usernameLabel.topAnchor.constraint(equalTo: userProfileImageView.topAnchor, constant:10).isActive = true
           usernameLabel.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 8).isActive = true
           
             
          //  usernameLabel.anchor(top: topAnchor, left: userProfileImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
           
           // NEW CODE
           
    

           audioView.translatesAutoresizingMaskIntoConstraints = false
           audioView.topAnchor.constraint(equalTo: userProfileImageView.bottomAnchor, constant: 8).isActive = true
           audioView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
           audioView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
           audioView.bottomAnchor.constraint(equalTo: stackView.topAnchor ).isActive = true
         //  audioView.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
          
           
           
           stackView.anchor(top: audioView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 4, paddingBottom: -8, paddingRight: 0, width: 120, height: 50)
           
           /*
                stackView.translatesAutoresizingMaskIntoConstraints = false
                 stackView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 0).isActive = true
                 stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
                 stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
                 stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
                 stackView.widthAnchor.constraint(equalToConstant: 120).isActive = true
               stackView.heightAnchor.constraint(equalToConstant: 120).isActive = true
           
           */
           
           
          //      stackView.anchor(top: captionLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 4, paddingBottom: -8, paddingRight: 0, width: 120, height: 50)
           
          // setupUser()
           
         //  addSubview(optionsButton)
         //  addSubview(photoImageView)
           
         //  userProfileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
           
    
           
       //    optionsButton.anchor(top: topAnchor, left: nil, bottom: photoImageView.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 44, height: 0)
           
          
           
        //   photoImageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
          // photoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
           
           
           
        //   addSubview(captionLabel)
           
        //   captionLabel.anchor(top: photoImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
           
           
        //   setupActionButtons()
       }
       
    
    
     
       
       fileprivate func setupActionButtons() {

           let stackView = UIStackView(arrangedSubviews: [likeButton, commentButton])
           stackView.distribution = .fillEqually
           
           addSubview(stackView)
           stackView.anchor(top: captionLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 4, paddingBottom: -8, paddingRight: 0, width: 120, height: 50)
           
           
       }
    
    
    @objc func hadlePlay ()  {
        
        
        let httpsReference = storage.reference(forURL: post!.photoImage)
        
        httpsReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
          if let error = error {
            // Uh-oh, an error occurred!
          } else {
            
            
            self.playContent(data: data!)
            // Data for "images/island.jpg" is returned
            //let image = URL(data: data!)
            
          }
        }
        
        
        let url = URL(fileURLWithPath: post!.photoImage)
        
        print ("Click ok")
        print (post!.photoImage)
        print(url.absoluteString)
        
        
    
        
    }
    
    func playContent (data: Data)
    
    {
        

        do {
            
            audioPlayer = try AVAudioPlayer(data: data)
            audioPlayer?.play()
            print("Playing ....")
        } catch {
            print ("No Playing")
            //print(url.absoluteString)
        }
        
        
        
        
    }
       
    
    
    
}

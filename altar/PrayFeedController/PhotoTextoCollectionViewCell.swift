//
//  PhotoTextoCollectionViewCell.swift
//  altar
//
//  Created by Juan Moreno on 1/8/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import UIKit

class PhotoTextoCollectionViewCell: UICollectionViewCell {
 

        
        
        var post: Posts? {
            
            didSet {
               
                
                
                
                guard let postImageUrl = post?.photoImage else { return }
              //  likeButton.setImage(post?.hasLiked == true ? #imageLiteral(resourceName: "like_selected").withRenderingMode(.alwaysOriginal) : #imageLiteral(resourceName: "like_unselected").withRenderingMode(.alwaysOriginal), for: .normal)
                
                photoImageView.loadImage(urlString: postImageUrl)
                //  print("Este es el conentido de la altura: \(photoImageView.image?.size.height)")
             //   post?.imageH = photoImageView.image?.size.height
                usernameLabel.text = post?.author
                guard let profileuserURL = post?.userPhoto else {return}
                userProfileImageView.loadImage(urlString: profileuserURL)
                //print("ESTE ES EL USUERNAME CELL")
                //  print(post?.user.username)
                // usernameLabel.text = post?.user.username
                
                //guard let profileuserURL = post?.user.profileImageUrl else {return}
                // userProfileImageView.loadImage(urlString: profileuserURL)
                
                setupAttributedCaption()
                
                
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
        
        var photoImageView: CustomImageView = {
            let iv = CustomImageView()
            //  iv.contentMode = .scaleAspectFill
            
            iv.contentMode = .scaleAspectFit
            iv.clipsToBounds = true
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
            
            
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.clipsToBounds = true
            addSubview(photoImageView)
            
            let stackView = UIStackView(arrangedSubviews: [likeButton, commentButton])
            stackView.distribution = .fillEqually
            addSubview(captionLabel)
            addSubview(stackView)
            
            userProfileImageView.translatesAutoresizingMaskIntoConstraints = false
            userProfileImageView.layer.cornerRadius = 40 / 2
            userProfileImageView.topAnchor.constraint(equalTo: topAnchor, constant:8).isActive = true
            userProfileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant:8).isActive = true
            userProfileImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
            userProfileImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
            userProfileImageView.bottomAnchor.constraint(equalTo: photoImageView.topAnchor, constant: -8).isActive = true
           // userProfileImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
           // userProfileImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            
           // userProfileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
            
            usernameLabel.translatesAutoresizingMaskIntoConstraints = false
           
             usernameLabel.topAnchor.constraint(equalTo: userProfileImageView.topAnchor, constant:10).isActive = true
            usernameLabel.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 8).isActive = true
            
              
           //  usernameLabel.anchor(top: topAnchor, left: userProfileImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
            
            // NEW CODE
            
     

            photoImageView.translatesAutoresizingMaskIntoConstraints = false
            photoImageView.topAnchor.constraint(equalTo: userProfileImageView.bottomAnchor, constant: 8).isActive = true
            photoImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            photoImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
            photoImageView.bottomAnchor.constraint(equalTo: captionLabel.topAnchor ).isActive = true
            photoImageView.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
           
            
            captionLabel.anchor(top: photoImageView.bottomAnchor, left: leftAnchor, bottom: stackView.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
            
            
            stackView.anchor(top: captionLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 4, paddingBottom: -8, paddingRight: 0, width: 120, height: 50)
           
            
            
            
            
            
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
        

    }



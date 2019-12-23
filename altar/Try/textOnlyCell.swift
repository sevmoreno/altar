//
//  textOnlyCell.swift
//  altar
//
//  Created by Juan Moreno on 12/22/19.
//  Copyright © 2019 Juan Moreno. All rights reserved.
//

import UIKit

class textOnlyCell: UICollectionViewCell {
    
    
    var post: Posts? {
        
        didSet {
       
          //  guard let postImageUrl = post?.photoImage else { return }
           
         //   photoImageView.loadImage(urlString: postImageUrl)
         
            usernameLabel.text = post?.author
            guard let profileuserURL = post?.userPhoto else {return}
            userProfileImageView.loadImage(urlString: profileuserURL)
    
            setupAttributedCaption()
            
            
        }
        
    }
    
    // var delegate: HomePostCellDelegate?
    
    /*
     var post: Post? {
     
     didSet {
     guard let postImageUrl = post?.imageUrl else { return }
     likeButton.setImage(post?.hasLiked == true ? #imageLiteral(resourceName: "like_selected").withRenderingMode(.alwaysOriginal) : #imageLiteral(resourceName: "like_unselected").withRenderingMode(.alwaysOriginal), for: .normal)
     
     photoImageView.loadImage(urlString: postImageUrl)
     //  print("Este es el conentido de la altura: \(photoImageView.image?.size.height)")
     post?.imageH = photoImageView.image?.size.height
     usernameLabel.text = post?.user.username
     guard let profileuserURL = post?.user.profileImageUrl else {return}
     userProfileImageView.loadImage(urlString: profileuserURL)
     //print("ESTE ES EL USUERNAME CELL")
     //  print(post?.user.username)
     // usernameLabel.text = post?.user.username
     
     //guard let profileuserURL = post?.user.profileImageUrl else {return}
     // userProfileImageView.loadImage(urlString: profileuserURL)
     
     setupAttributedCaption()
     }
     }
     
     */
    
    fileprivate func setupAttributedCaption() {
        guard let post = self.post else { return }
        
        let attributedText = NSMutableAttributedString(string: post.author, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: " \(post.message ?? "Defaul Value")", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
        
        attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 4)]))
        
        //   let timeAgoDisplay = post.timeAgoDisplay()
        //   attributedText.append(NSAttributedString(string: timeAgoDisplay, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.gray]))
        
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
    
    let captionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("Esto es Init")
        print("Nombre del autor en init \(post?.author)")
        print("Nombre del tipo en init \(post?.postType)")
        
        
        
        defaultCell()
        
        
        
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func defaultCell () {
        
       
        
        addSubview(userProfileImageView)
        addSubview(usernameLabel)
        addSubview(optionsButton)

        userProfileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        
        userProfileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        userProfileImageView.layer.cornerRadius = 40 / 2
        
        usernameLabel.anchor(top: topAnchor, left: userProfileImageView.rightAnchor, bottom: optionsButton.topAnchor, right: optionsButton.leftAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        optionsButton.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 44, height: 0)
        

        
      //  setupActionButtons()
        
      //  addSubview(captionLabel)
      //  captionLabel.anchor(top: likeButton.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        
        
     
        
    }
    
   
    
    fileprivate func setupActionButtons() {
        
        let stackView = UIStackView(arrangedSubviews: [likeButton, commentButton])
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        stackView.anchor(top: captionLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 120, height: 50)
        
        
    }
    
    
}


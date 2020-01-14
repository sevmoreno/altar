//
//  textOnlyCell.swift
//  altar
//
//  Created by Juan Moreno on 12/22/19.
//  Copyright © 2019 Juan Moreno. All rights reserved.
//

import UIKit

protocol textOnlyCellDelegate {
    func didTapComment(post: Posts)
    func didLike(for cell: textOnlyCell)
}

class textOnlyCell: UICollectionViewCell {
    
    var delegate: textOnlyCellDelegate?
    
    var post: Posts? {
        
        didSet {

                       usernameLabel.text = post?.author
                       guard let profileuserURL = post?.userPhoto else {return}
                       userProfileImageView.loadImage(urlString: profileuserURL)
            
            
            
            likeButton.setImage(post?.hasLiked == true ? #imageLiteral(resourceName: "pray").withRenderingMode(.alwaysOriginal) : #imageLiteral(resourceName: "pray2").withRenderingMode(.alwaysOriginal), for: .normal)
       
      

    
            setupAttributedCaption()
            
            
        }
        
    }
    

    
    fileprivate func setupAttributedCaption() {
        guard let post = self.post else { return }
        
        let attributedText = NSMutableAttributedString(string: post.author, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: " \(post.message ?? "Defaul Value")", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
        
        attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 4)]))

        
        captionLabel.attributedText = attributedText
    }
    
    
    
    let userProfileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .blue
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
        print("Handling like from within cell...text only")
        delegate?.didLike(for: self)
    }
    
    lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "icon-comment-1").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleComment), for: .touchUpInside)
        //button.addTarget(self, action: #selector(clickcomment), for: .touchUpInside)
        
        return button
    }()
    
    
    
    @objc func handleComment() {
        print("Trying to show comments...on only text")
        guard let post = post else { return }
        
        delegate?.didTapComment(post: post)
        
    }
    
    let sendMessageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "icon-play").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "icon-play").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    
    let captionLabel: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isEditable = false
        //        label.numberOfLines = 0
        //        label.backgroundColor = .lightGray
        textView.isScrollEnabled = false
        return textView
    }()
    
 //   let captionLabel: UILabel = {
 //       let label = UILabel()
 //       label.numberOfLines = 0
 //       label.isScrollEnabled = false
 //       return label
 //   }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
            
    
        
             addSubview(userProfileImageView)
             addSubview(usernameLabel)
             addSubview(optionsButton)

           
             userProfileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
             userProfileImageView.layer.cornerRadius = 40 / 2
             
             usernameLabel.anchor(top: topAnchor, left: userProfileImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
             
             
             
            //  optionsButton.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 44, height: 0)
             

             
          
             
             addSubview(captionLabel)
             captionLabel.anchor(top: userProfileImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
             
             setupActionButtons()
             
             

        
        
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    
    fileprivate func setupActionButtons() {
        
        let stackView = UIStackView(arrangedSubviews: [likeButton, commentButton])
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        stackView.anchor(top: captionLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 8, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 120, height: 50)
        
        
    }
    
    
}


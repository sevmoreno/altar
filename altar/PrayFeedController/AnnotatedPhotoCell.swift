

import UIKit


protocol ImageOnlyDelegate {
    func ImageOnlyDelegate_didTapComment(post: Posts)
    func ImageOnlyDelegate_didLike(for cell: AnnotatedPhotoCell)
}


class AnnotatedPhotoCell: UICollectionViewCell {
    
    var delegate: ImageOnlyDelegate?
    
    
    var post: Posts? {
        
        didSet {
           
            
            
            
            guard let postImageUrl = post?.photoImage else { return }
      
            
            photoImageView.loadImage(urlString: postImageUrl)

            usernameLabel.text = post?.author
            guard let profileuserURL = post?.userPhoto else {return}
            userProfileImageView.loadImage(urlString: profileuserURL)


            // --------------- CODE POST DESIGN   --------------------------
            if post!.likes  > 0 {
                likeButton.setImage(UIImage(named: "cellprayiconRed")?.withRenderingMode(.alwaysOriginal), for: .normal)
            
            } else {
                
                likeButton.setImage(UIImage(named: "cellPrayIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
            }
            
            likeCount.text = String(post!.likes)
            
            if let tiene = post?.comments {
            commentCount.text = String(tiene)
            }
            
            let fecha = post?.creationDate
          //  let fecha = Date(milliseconds: Int64(post?.creationDate ?? 0))
            
            praysDate.text = fecha!.timeAgoDisplay()
            
            // ==========================================================
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
    
    lazy var praysDate: UILabel = {
              let label2 = UILabel ()
              label2.font = UIFont(name: "Avenir-Medium", size: 12)
              label2.text = "You prayed 1"
           label2.textColor = .lightGray
           //   button.setImage(UIImage(named: "cellPrayIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
             // button.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
              return label2
          }()
    
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
        label.font = UIFont(name: "Avenir-Medium", size: 15)
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
        button.setImage(UIImage(named: "cellPrayIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
        return button
    }()
    
    lazy var likeCount: UILabel = {
        let label2 = UILabel ()
        label2.font = UIFont(name: "Avenir-Medium", size: 15)
        label2.text = "0000"
     //   button.setImage(UIImage(named: "cellPrayIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
       // button.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
        return label2
    }()
    
    @objc func handleLike() {
        print("Handling like from within cell...")
         delegate?.ImageOnlyDelegate_didLike(for: self)
    }
    
    lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "cellComment Icone")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleComment), for: .touchUpInside)
        //button.addTarget(self, action: #selector(clickcomment), for: .touchUpInside)
        
        return button
    }()
    
    lazy var commentCount: UILabel = {
           let label2 = UILabel ()
           label2.font = UIFont(name: "Avenir-Medium", size: 15)
           label2.text = "    "
        //   button.setImage(UIImage(named: "cellPrayIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
          // button.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
           return label2
       }()
       
    
    @objc func handleComment() {
        print("Trying to show comments...")
        guard let post = post else { return }
        
        delegate?.ImageOnlyDelegate_didTapComment(post: post)
        
    }
    
    let sendMessageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "icon-play-1").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "icon-play-1").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let captionLabel: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isEditable = false
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
        
        let stackView = UIStackView(arrangedSubviews: [likeButton,likeCount,commentButton,commentCount])
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        
        userProfileImageView.translatesAutoresizingMaskIntoConstraints = false
        userProfileImageView.layer.borderWidth = 1
       
        userProfileImageView.layer.borderColor = advengers.shared.colorOrange.cgColor
        
        userProfileImageView.layer.cornerRadius = 50 / 2
        userProfileImageView.topAnchor.constraint(equalTo: topAnchor, constant:15).isActive = true
        userProfileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant:15).isActive = true
        userProfileImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        userProfileImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        userProfileImageView.bottomAnchor.constraint(equalTo: photoImageView.topAnchor, constant: -8).isActive = true

        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
       
         usernameLabel.topAnchor.constraint(equalTo: userProfileImageView.topAnchor, constant:10).isActive = true
        usernameLabel.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 8).isActive = true
        
 

        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.topAnchor.constraint(equalTo: userProfileImageView.bottomAnchor, constant: 8).isActive = true
        photoImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        photoImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: stackView.topAnchor ).isActive = true
        photoImageView.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
       
        addSubview(praysDate)
        praysDate.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 30, width: 0, height: 0)
         praysDate.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor).isActive = true
        
        stackView.anchor(top: photoImageView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: -8, paddingRight: 0, width: 120, height: 50)
        

    }
    
  
  
    

}


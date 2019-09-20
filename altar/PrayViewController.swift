//
//  PrayViewController.swift
//  altar
//
//  Created by Juan Moreno on 9/16/19.
//  Copyright © 2019 Juan Moreno. All rights reserved.
//

import UIKit
import Firebase

class PrayViewController: UIViewController {

    @IBOutlet weak var feedCollection: UICollectionView!
    var posts = [Posts] ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        advengers.shared.usersStatusRef.queryOrderedByKey().observe(.value) { (datasnap) in
            
            let userinfo = datasnap.value as! [String:NSDictionary]
            
            for (key, value) in userinfo {
                
                if key == Auth.auth().currentUser?.uid {
                    advengers.shared.currenUSer["userid"] = value["userid"] as! String
                    advengers.shared.currenUSer["email"] = value["email"] as! String
                    advengers.shared.currenUSer["name"] = value["name"] as! String
                    advengers.shared.currenUSer["photoURL"] = value["photoURL"] as! String
                    advengers.shared.currenUSer["church"] = value["church"] as! String
                    advengers.shared.currentChurch = value["church"] as! String
                }
            }
            
            self.fetchPost()
        }
        
        

    }
  
    func fetchPost () {
        
        advengers.shared.postPrayFeed.queryOrderedByKey().observe(.value) { (data) in
            
            self.posts.removeAll()
            
            if let postfeed = data.value as? [String:NSDictionary] {
            
            for (_,value) in postfeed
            {
          //      let eachpost = value as! [String:Any]
                    
                let temporarioPost = Posts ()
                temporarioPost.author = value["author"] as! String
                temporarioPost.photoImage = value["pathtoPost"] as! String
                temporarioPost.likes = value["prays"] as! Int
                temporarioPost.userPhoto = value["userPhoto"] as! String
                temporarioPost.postID = value["postID"] as! String
                temporarioPost.userID = value["userid"] as! String
                
                self.posts.append(temporarioPost)
                
                print(temporarioPost.photoImage)
                
                self.feedCollection.reloadData()
              
                
                
            }
            
            
        }
        }
    }
    

}
extension PrayViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "feed", for: indexPath) as! FeedCollectionViewCell
        cell.fotoAuthor.downloadImage(imgURL: posts[indexPath.row].userPhoto)
        cell.postImagen.downloadImage(imgURL: posts[indexPath.row].photoImage)
        cell.nameAutor.text = posts[indexPath.row].author
        cell.praysCount.text = String (posts[indexPath.row].likes) + "Prayed"
        cell.postID = posts[indexPath.row].postID
        
        
        return cell
    }
    
    
   
}

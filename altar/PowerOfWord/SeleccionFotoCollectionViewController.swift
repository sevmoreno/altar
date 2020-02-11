//
//  SeleccionFotoCollectionViewController.swift
//  altar
//
//  Created by Juan Moreno on 2/10/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase

class SeleccionFotoCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout  {

    
    let cellId = "cellId"
    var photos = [Posts] ()
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleUpdateFeed), name: NSNotification.Name(rawValue: "UpdateFeed"), object: nil)
        
        collectionView?.register(FotoCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
    //    collectionView?.backgroundColor =  UIColor.rgb(red: 32, green: 36, blue: 47)
        
        collectionView.backgroundColor = .red
        
      
        
     //   collectionView.reloadData()

        
     //   refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
     //   collectionView?.refreshControl = refreshControl
        
   //     fetchPost ()
        
        // collectionView?.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
  
       
        
        
    }
    
    @objc func handleRefresh() {
        photos.removeAll()
        fetchPost ()
        DispatchQueue.main.async {
           self.refreshControl.endRefreshing()
        }
    }
    
    @objc func handleUpdateFeed() {
        

       
           photos.removeAll()
            collectionView.reloadData()
           fetchPost ()
        
       }
    


    
    
    func fetchPost () {
        
        
  
     //  ref.observeSingleEvent(of: .value, with: { (snapshot) in
      //  print("Fechea ")
        advengers.shared.postPrayFeed.observeSingleEvent(of: .value, with: { (data) in
            
           // self.photos.removeAll()
            
            if let postfeed = data.value as? [String:NSDictionary] {
                
                for (_,value) in postfeed
                {
                    
                    
                    let temporarioPost = Posts (dictionary: value as! [String : Any])
                    
                    
                    self.photos.append(temporarioPost)
                    
                    self.photos.sort(by: { (p1, p2) -> Bool in
                        return p1.creationDate?.compare(p2.creationDate!) == .orderedDescending
                    })
                    
                    DispatchQueue.main.async {
                              self.collectionView.reloadData()
                          }
                   
                    
                    
                }
                
                
            }
        })
    }


    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 3.0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
     
            
            return CGSize(width: (380/2) - 9, height:  (460/2) - 3 )
            
        }
        

        

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
            
        //    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath as IndexPath) as! FotoCollectionViewCell
        cell.backgroundColor = .blue
         //   cell.post = photos[indexPath.item]
      
        return cell
        }
        
        
        

    
    /* TODO: PEFRECCIONAR ESTA FUNCION
     
    override func collectionView(_ collectionView: UICollectionView,
                                 didEndDisplaying cell: UICollectionViewCell,
                                 forItemAt indexPath: IndexPath) {
        
        if photos[indexPath.item].postType == advengers.postType.audio.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "audioCell", for: indexPath as IndexPath) as! AudioCollectionViewCell
            
            print("Se fue la Cel de Audio")
            cell.audioPlayer?.stop()
        }
    }
 */
    
}



/*
func didLike(for cell: AnnotatedPhotoCell) {

print("llego al protocolo")
guard let indexPath = collectionView?.indexPath(for: cell) else { return }

var post =  self.photos[indexPath.item]
print(post.message)



guard let postId = post.postID else { return }

guard let uid = Auth.auth().currentUser?.uid else { return }

let values = [uid: post.hasLiked == true ? 0 : 1]
Database.database().reference().child("likes").child(postId).updateChildValues(values) { (err, _) in

if let err = err {
print("Failed to like post:", err)
return
}

print("Successfully liked post.")

post.hasLiked = !post.hasLiked

self.photos[indexPath.item] = post

self.collectionView?.reloadItems(at: [indexPath])

}
}
*/

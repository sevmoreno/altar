

import UIKit
import AVFoundation
import Firebase

class PhotoStreamViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, HomePostCellDelegate,textOnlyCellDelegate  {
    
    func didLike(for cell: textOnlyCell) {
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
    
    
   func didLike(for cell: AnnotatedPhotoCell) {
          
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
      
      
      func didTapComment(post: Posts) {
          print("Message coming from HomeController")
          print(post.message)
          let commentsController = CommentsController(collectionViewLayout: UICollectionViewFlowLayout())
          commentsController.post = post
          navigationController?.pushViewController(commentsController, animated: true)
      }
      
      
    
    let cellId = "cellId"
    var photos = [Posts] ()
    
    override func viewDidLoad() {
        
        collectionView?.register(AnnotatedPhotoCell.self, forCellWithReuseIdentifier: "OtraPostCell")
        collectionView?.register(textOnlyCell.self, forCellWithReuseIdentifier: "textOnlyCelll")
        
        collectionView?.register(PhotoTextoCollectionViewCell.self, forCellWithReuseIdentifier: "textImageCell")
        
        
        collectionView?.register(AudioCollectionViewCell.self, forCellWithReuseIdentifier: "audioCell")
        
        collectionView?.backgroundColor = .lightGray

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Prayer", style: .plain, target: self, action: #selector(addprayer))
        navigationItem.title = advengers.shared.currentChurch
        
        
        


       // collectionView?.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
        loadCurrentUserInfo ()
        fetchPost ()
    
        
    }
    
    @objc func addprayer () {
        
        performSegue(withIdentifier: "prueba", sender: self)

    }
    
    
    func fetchPost () {
        print("Fechea ")
        advengers.shared.postPrayFeed.queryOrderedByKey().observe(.value) { (data) in
            
            self.photos.removeAll()
            
            if let postfeed = data.value as? [String:NSDictionary] {
                
                for (_,value) in postfeed
                {

                    
                    let temporarioPost = Posts (dictionary: value as! [String : Any])
                    
                   
                    self.photos.append(temporarioPost)
                    self.collectionView.reloadData()

                    
                }
                
                
            }
        }
    }
    
    func loadCurrentUserInfo () {
           
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
               
           }
           
           
           
       }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

           return 3.0
   
   }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           
 
        if photos[indexPath.row].postType == advengers.postType.textOnly.rawValue {
            
     
                                             let botones: CGFloat = 50.0
                                             let usuarioInfo: CGFloat = 50.0
                                   
                                             let dummyframe = CGRect(x: 0, y: 0, width: view.frame.width, height: 1000)
                                             let dummycell = textOnlyCell (frame: dummyframe)
                                             dummycell.captionLabel.text = photos[indexPath.row].message
                                        
                                             
                                             

                                            let size = CGSize(width: view.frame.width, height: .infinity)
                                            let texto = dummycell.captionLabel.sizeThatFits(size)
                                            

                       return CGSize(width: view.frame.width, height:  usuarioInfo + botones + texto.height + 10 )
            
        }
        
        if photos[indexPath.row].postType == advengers.postType.textImage.rawValue {
            
            let botones: CGFloat = 50.0
                                  let usuarioInfo: CGFloat = 50.0
                        
                                  let dummyframe = CGRect(x: 0, y: 0, width: view.frame.width, height: 1000)
                                  let dummycell = textOnlyCell (frame: dummyframe)
                                  dummycell.captionLabel.text = photos[indexPath.row].message
                             
                                  
                                  

                                 let size = CGSize(width: view.frame.width, height: .infinity)
                                 let texto = dummycell.captionLabel.sizeThatFits(size)
            
             let imageRatio = CGFloat(photos[indexPath.row].photoW! / photos[indexPath.row].photoH!)
                                 

            return CGSize(width: view.frame.width, height:  usuarioInfo + botones + texto.height + 10 + (view.frame.width /  imageRatio) )
                  
        
        }
            
            if photos[indexPath.row].postType == advengers.postType.audio.rawValue {
              let botones: CGFloat = 50.0
              let usuarioInfo: CGFloat = 50.0
                                     

                return CGSize(width: view.frame.width, height:  usuarioInfo + botones + 100 )
                
                
                
            
                
            
            }
        
        
        
        else {
            

                        let botones: CGFloat = 50.0
                        let usuarioInfo: CGFloat = 50.0
              
     
                       
                       let imageRatio = CGFloat(photos[indexPath.row].photoW! / photos[indexPath.row].photoH!)
                        

                   return CGSize(width: view.frame.width, height:  usuarioInfo + botones + (view.frame.width /  imageRatio)  )
        
        }
            
  
       
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       

         return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch photos[indexPath.item].postType {
            
        case advengers.postType.imageOnly.rawValue:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OtraPostCell", for: indexPath as IndexPath) as! AnnotatedPhotoCell
            cell.contentView.backgroundColor = .white
            cell.post = photos[indexPath.item]
            return cell
            
            
        case advengers.postType.textOnly.rawValue:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "textOnlyCelll", for: indexPath as IndexPath) as! textOnlyCell
            cell.contentView.backgroundColor = .white
            cell.delegate = self
            cell.post = photos[indexPath.item]
            return cell
            
        //textImage
        
        case advengers.postType.textImage.rawValue:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "textImageCell", for: indexPath as IndexPath) as! PhotoTextoCollectionViewCell
        cell.contentView.backgroundColor = .white
        cell.post = photos[indexPath.item]
        return cell
        
        case advengers.postType.audio.rawValue:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "audioCell", for: indexPath as IndexPath) as! AudioCollectionViewCell
        cell.contentView.backgroundColor = .white
        cell.post = photos[indexPath.item]
        return cell
            
        default:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "textOnlyCelll", for: indexPath as IndexPath) as! textOnlyCell
            cell.contentView.backgroundColor = .white
            cell.post = photos[indexPath.item]
            cell.delegate = self
            return cell
        }

        
      
    }
    
}


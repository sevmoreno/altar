

import UIKit
import AVFoundation
import Firebase

class PhotoStreamViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
   
    
    let cellId = "cellId"
    var photos = [Posts] ()
    
    override func viewDidLoad() {
        
        collectionView?.register(AnnotatedPhotoCell.self, forCellWithReuseIdentifier: "OtraPostCell")
        collectionView?.register(textOnlyCell.self, forCellWithReuseIdentifier: "textOnlyCelll")
        collectionView?.backgroundColor = .white

       // collectionView?.backgroundColor = .clear
        collectionView?.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
        
        fetchPost ()
    
        
    }
    
    func fetchPost () {
        print("Fechea ")
        advengers.shared.postPrayFeed.queryOrderedByKey().observe(.value) { (data) in
            
            self.photos.removeAll()
            
            if let postfeed = data.value as? [String:NSDictionary] {
                
                for (_,value) in postfeed
                {
                    //      let eachpost = value as! [String:Any]
                    
                    let temporarioPost = Posts (dictionary: value as! [String : Any])
                    
                    /*
                     temporarioPost.author = value["author"] as? String
                     temporarioPost.photoImage = value["pathtoPost"] as? String
                     temporarioPost.likes = value["prays"] as? Int
                     temporarioPost.userPhoto = value["userPhoto"] as! String
                     temporarioPost.postID = value["postID"] as! String
                     temporarioPost.userID = value["userid"] as? String
                     temporarioPost.postType = value["postType"] as? String
                     temporarioPost.message = value["message"] as? String
                     */
                    self.photos.append(temporarioPost)
                    self.collectionView.reloadData()
                    print("Cargo uno")
                    // self.feedCollections.reloadData()
                    
                    //  self.feedCollection.reloadData()
                    
                    
                    
                }
                
                
            }
        }
    }

    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        
        switch photos[indexPath.item].postType {
        case advengers.postType.imageOnly.rawValue:
           
            var height: CGFloat = 40 + 8 + 8 //username userprofileimageview
            height += view.frame.width
            height += 50
            height += 60
            
            return CGSize(width: view.frame.width, height: height)
            
        default:
            var height: CGFloat = 40 + 8 + 8 //username userprofileimageview
            height += view.frame.width

            
            return CGSize(width: view.frame.width, height: 100)
        }
        
        //     let photoTemp = CustomImageView()
        //  photoTemp.loadImage(urlString: posts[indexPath.row].imageUrl)
        //     let altura = photoTemp.image!.size.height
        
        // var height: CGFloat = 40 + 8 + 8 //username userprofileimageview
       
        
        /*
         let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
         let dummyCell = HomePostCell(frame: frame)
         // dummyCell.comment = comments[indexPath.item]
         let photoTemp = CustomImageView()
         photoTemp.loadImage(urlString: posts[indexPath.row].imageUrl)
         dummyCell.photoImageView = photoTemp
         dummyCell.layoutIfNeeded()
         
         let targetSize = CGSize(width: view.frame.width, height: 1000)
         let estimatedSize = dummyCell.systemLayoutSizeFitting(targetSize)
         
         let height = max(40 + 8 + 8, estimatedSize.height)
         return CGSize(width: view.frame.width, height: height)
         */
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       

         return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch photos[indexPath.item].postType {
        case advengers.postType.imageOnly.rawValue:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OtraPostCell", for: indexPath as IndexPath) as! AnnotatedPhotoCell
            cell.post = photos[indexPath.item]
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "textOnlyCelll", for: indexPath as IndexPath) as! textOnlyCell
            cell.post = photos[indexPath.item]
            return cell
        }
        
        
        
        
        
        // cell.photo = photos[indexPath.item]
        //  cell.imageView.image = photos[indexPath.row].image
        //  cell.captionLabel.text = photos[indexPath.row].caption
        //  cell.commentLabel.text = photos[indexPath.row].comment
        //   alturaTexto = cell.captionLabel.bounds.height + cell.commentLabel.bounds.height
        //    print ("Esto es alutratexte ANTES DEl delegate \(alturaTexto)")
        
      
    }
    
}



/*

class PhotoStreamViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  var photos = [Posts] ()
  var alturaTexto: CGFloat = 0.0
  
    @IBOutlet var referenciaCollection: UICollectionView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
   
    collectionView?.register(AnnotatedPhotoCell.self, forCellWithReuseIdentifier: "OtraPostCell")
    collectionView?.backgroundColor = .white
    //let photo = Posts(dictionary: )
   // var photo = Photo (caption: "hola", comment: "pepe", image: UIImage(named: "1")!)
  //  photos.append(photo)
    
   // photo = Photo (caption: "", comment: "fdsfdsfdss  ", image: UIImage(named: "2")!)
  //  photos.append(photo)
    
  //  photo = Photo (caption: "fsdfdsfs", comment: "fdsfdsfdss", image: UIImage(named: "3")!)
 //   photos.append(photo)
    
 //   photo = Photo (caption: "fsdfdsfs", comment: "fdsfdsfdss", image: UIImage(named: "4")!)
 //   photos.append(photo)
    
  //  if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
  //    layout.delegate = self
  //  }
 //   if let patternImage = UIImage(named: "1") {
 //     view.backgroundColor = UIColor(patternImage: patternImage)
 //   }
    collectionView?.backgroundColor = .clear
    collectionView?.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
    
     fetchPost ()
  }
    
    
    func fetchPost () {
        print("Fechea ")
        advengers.shared.postPrayFeed.queryOrderedByKey().observe(.value) { (data) in
            
            self.photos.removeAll()
            
            if let postfeed = data.value as? [String:NSDictionary] {
                
                for (_,value) in postfeed
                {
                    //      let eachpost = value as! [String:Any]
                    
                    let temporarioPost = Posts (dictionary: postfeed)
                    
                    /*
                     temporarioPost.author = value["author"] as? String
                     temporarioPost.photoImage = value["pathtoPost"] as? String
                     temporarioPost.likes = value["prays"] as? Int
                     temporarioPost.userPhoto = value["userPhoto"] as! String
                     temporarioPost.postID = value["postID"] as! String
                     temporarioPost.userID = value["userid"] as? String
                     temporarioPost.postType = value["postType"] as? String
                     temporarioPost.message = value["message"] as? String
                     */
                    self.photos.append(temporarioPost)
                    self.collectionView.reloadData()
                    print("Cargo uno")
                    // self.feedCollections.reloadData()
                    
                    //  self.feedCollection.reloadData()
                    
                    
                    
                }
                
                
            }
        }
    }
}



extension PhotoStreamViewController: UICollectionViewDelegateFlowLayout {
    
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    print (photos.count)
    return photos.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OtraPostCell", for: indexPath as IndexPath) as! AnnotatedPhotoCell
    
    
   // cell.photo = photos[indexPath.item]
  //  cell.imageView.image = photos[indexPath.row].image
  //  cell.captionLabel.text = photos[indexPath.row].caption
  //  cell.commentLabel.text = photos[indexPath.row].comment
 //   alturaTexto = cell.captionLabel.bounds.height + cell.commentLabel.bounds.height
 //    print ("Esto es alutratexte ANTES DEl delegate \(alturaTexto)")
    
    cell.post = photos[indexPath.item]
    
   // cell.delegate = self
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
    return CGSize(width: itemSize, height: itemSize)
  }
}

extension PhotoStreamViewController: PinterestLayoutDelegate {
  func collectionView(
    _ collectionView: UICollectionView,
    heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
    //return photos[indexPath.item].image.size.height
   
 //  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath as IndexPath) as! AnnotatedPhotoCell
    print ("Esto es alutratexte en el delegate \(alturaTexto)")
    
    return 200.0 + alturaTexto
  }
}
*/




import UIKit
import AVFoundation
import Firebase

class PhotoStreamViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
   
    
    let cellId = "cellId"
    var photos = [Posts] ()
    
    override func viewDidLoad() {
        
        collectionView?.register(AnnotatedPhotoCell.self, forCellWithReuseIdentifier: "OtraPostCell")
        collectionView?.register(textOnlyCell.self, forCellWithReuseIdentifier: "textOnlyCelll")
        collectionView?.backgroundColor = .lightGray
       // navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icon-share").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleLogOut))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Prayer", style: .plain, target: self, action: #selector(addprayer))

       // collectionView?.backgroundColor = .clear
       // collectionView?.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
        loadCurrentUserInfo ()
        fetchPost ()
    
        
    }
    
    @objc func addprayer () {
        
        performSegue(withIdentifier: "prueba", sender: self)
       // let signUpController = PrayPostViewController()
              //navigationController?.pushViewController(signUpController, animated: true)
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
                    
                   
                    self.photos.append(temporarioPost)
                    self.collectionView.reloadData()
                   
                    // self.feedCollections.reloadData()
                    
                    //  self.feedCollection.reloadData()
                    
                    
                    
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
    
    /*
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        switch photos[indexPath.item].postType {
        case advengers.postType.imageOnly.rawValue:
            

            var height: CGFloat = 80 + 8 + 8 //username userprofileimageview
            height += view.frame.width
            height += 50
            height += 60
            
            return CGSize(width: view.frame.width, height: height)
      
            
        default:


            let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
            let dummyCell = textOnlyCell(frame: frame)
            dummyCell.post = photos[indexPath.item]
            dummyCell.layoutIfNeeded()
            
            let targetSize = CGSize(width: view.frame.width, height: 1000)
            let estimatedSize = dummyCell.systemLayoutSizeFitting(targetSize)
            
            let height = max(20 + 8 + 8, estimatedSize.height)
            print("Esta es la altura")
            print(height)
            return CGSize(width: view.frame.width, height: height)
            
 
        }

    }
    
 */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

           return 3.0
   
   }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           
        
        /*
        switch photos[indexPath.row].postID {
        case advengers.postType.imageOnly.rawValue:
        */
        
        if photos[indexPath.row].postType == advengers.postType.textOnly.rawValue {
            
            print("sizeForItemAt")
                                             print("Numero:3")
                                             let botones: CGFloat = 50.0
                                             let usuarioInfo: CGFloat = 50.0
                                   
                                             let dummyframe = CGRect(x: 0, y: 0, width: view.frame.width, height: 1000)
                                             let dummycell = textOnlyCell (frame: dummyframe)
                                             dummycell.captionLabel.text = photos[indexPath.row].message
                                        
                                             
                                             

                                            let size = CGSize(width: view.frame.width, height: .infinity)
                                            let texto = dummycell.captionLabel.sizeThatFits(size)
                                            
                                          //  let imageRatio = CGFloat(photos[indexPath.row].photoW! / photos[indexPath.row].photoH!)
                                             

                                     
                                             
                       return CGSize(width: view.frame.width, height:  usuarioInfo + botones + texto.height )
            
        } else {
            print("sizeForItemAt")
                        print("Numero:3")
                        let botones: CGFloat = 50.0
                        let usuarioInfo: CGFloat = 50.0
              
                     //   let dummyframe = CGRect(x: 0, y: 0, width: view.frame.width, height: 1000)
                      //  let dummycell = AnnotatedPhotoCell (frame: dummyframe)
                       // dummycell.textView.text = photos[indexPath.row].message
                   
                  

                      //  let size = CGSize(width: view.frame.width, height: .infinity)
                       // let texto = dummycell.textView.sizeThatFits(size)
        
        
                       
                       let imageRatio = CGFloat(photos[indexPath.row].photoW! / photos[indexPath.row].photoH!)
                        

                   return CGSize(width: view.frame.width, height:  usuarioInfo + botones + (view.frame.width /  imageRatio) )
        
        }
            
            
            /*
         case advengers.postType.textOnly.rawValue:
        
            print("sizeForItemAt")
                                  print("Numero:3")
                                  let botones: CGFloat = 50.0
                                  let usuarioInfo: CGFloat = 50.0
                        
                                  let dummyframe = CGRect(x: 0, y: 0, width: view.frame.width, height: 1000)
                                  let dummycell = textOnlyCell (frame: dummyframe)
                                  dummycell.captionLabel.text = photos[indexPath.row].message
                             
                                  
                                  

                                 let size = CGSize(width: view.frame.width, height: .infinity)
                                 let texto = dummycell.captionLabel.sizeThatFits(size)
                                 
                               //  let imageRatio = CGFloat(photos[indexPath.row].photoW! / photos[indexPath.row].photoH!)
                                  

                          
                                  
            return CGSize(width: view.frame.width, height:  usuarioInfo + botones + texto.height )
       
        
        default:
       
            return CGSize(width: view.frame.width, height:  800)
            
            
     
        }
        
        
            
    */
        
       
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
            cell.post = photos[indexPath.item]
            return cell
            
        default:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "textOnlyCelll", for: indexPath as IndexPath) as! textOnlyCell
            cell.contentView.backgroundColor = .white
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


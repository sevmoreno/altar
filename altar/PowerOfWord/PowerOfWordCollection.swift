//
//  PowerOfWordCollectionViewCell.swift
//  altar
//
//  Created by Juan Moreno on 1/3/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//


import UIKit
import AVFoundation
import Firebase

class PowerOfWordCollectionView: UICollectionViewController,  UICollectionViewDelegateFlowLayout  {
    
    
       let cellId = "cellId"
       var devos = [Devo] ()
       
       override func viewDidLoad() {
           
           collectionView?.register(DevotionalCollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerWord")

        
           collectionView?.register(DevotionalCollectionViewCell.self, forCellWithReuseIdentifier: "oldWord")
          // collectionView?.register(textOnlyCell.self, forCellWithReuseIdentifier: "textOnlyCelll")
           collectionView?.backgroundColor = .lightGray

           //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Prayer", style: .plain, target: self, action: #selector(addprayer))
        
            navigationItem.title = advengers.shared.currentChurch
        
        if advengers.shared.isPastor {
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Devotional", style: .plain, target: self, action: #selector(addDevotional))
            
        }
        
        loadDevocionales ()
        
            
     //      loadCurrentUserInfo ()
     //      fetchPost ()
       
           
       }
    
    func loadDevocionales () {
        
      //  let referenciaDB = Database.database()
        
        Database.database().reference().child ("devocionales").child(advengers.shared.currentChurch).queryOrderedByKey().observe(.value) { (data) in
                   
                  // self.photos.removeAll()
                   
                   if let devoFeed = data.value as? [String:NSDictionary] {
                       
                       for (_,value) in devoFeed
                       {

                        var devocional  = Devo ()
                        
                        devocional.title = value["title"] as? String
                        devocional.message = value["texto"] as? String
                        devocional.urltexto = value["urltexto"] as? String
                        devocional.creationDate = value["creationDate"] as? String
                      //  print(value)
                     //   print(devocional.title!)
                   //     print(devocional.message!)
                        self.devos.append(devocional)
                        
                        
                        //   let temporarioPost = Posts (dictionary: value as! [String : Any])
                           
                          
           //                self.photos.append(temporarioPost)
             //              self.collectionView.reloadData()

                        self.collectionView.reloadData()
                       }
                       
                       
                   }
               }
        
        
    }
    
    
    
    
       
       @objc func addDevotional () {
           
           performSegue(withIdentifier: "devotionalCreator", sender: self)

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
    
    
    
 // ------------------------------------------------------------------------ HEADER  -----------------------------------------------------------------------------------
    
  /*
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerWord", for: indexPath) as! DevotionalCollectionViewCell
        header.viewGeneral.backgroundColor = .red
        
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if devos.count == 1 {
            
            return CGSize(width: view.frame.width, height: view.frame.height)
            
        } else {
        
        
        return CGSize(width: view.frame.width, height: view.frame.height)
            
            
        }
        
        
    }
    
*/
    
    // ------------------------------------------------------------------------------------------------------------------------------------------------------------------
    
    // ------------------------------------------------------------------ COLLECTION CELLS -----------------------------------------------------------------------------

       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

              return 3.0
      
      }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
              

        /*
           
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

           
                          
                          let imageRatio = CGFloat(photos[indexPath.row].photoW! / photos[indexPath.row].photoH!)
                           

                      return CGSize(width: view.frame.width, height:  usuarioInfo + botones + (view.frame.width /  imageRatio) )
           
           }
               
 
          */
        
     //   switch devos.count {
       // case 1:
            return CGSize(width: view.frame.width, height:  view.frame.height )
   //     default:
     //       return CGSize(width: view.frame.width, height:  500 )
        //}
            
            

        
      
       }
       
       
       override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          
          print ("Devos Count")
          print(devos.count)
        
          return devos.count
        
            // return photos.count
       }
       
       override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           
        
        /*
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
           
   */
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "oldWord", for: indexPath)
        
        
        return cell
        
       }
 
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "ADevo", sender: self)
        
        print("El Contenido de la sellecion")
        print(devos[indexPath.row].title)
        print(devos[indexPath.row].message)
        
        
        advengers.shared.devocionalSeleccinado = devos[indexPath.row]
     //  let a = DevocionalSeleccionado ()
        
     //   a.devo = devos[indexPath.row]
        
        
        
    }
    
    

        
       
    
}

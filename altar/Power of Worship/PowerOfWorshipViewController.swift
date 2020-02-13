//
//  PowerOfWorshipViewController.swift
//  altar
//
//  Created by Juan Moreno on 1/6/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import UIKit
import AVFoundation
// import WebKit
// import Alamofire
import Firebase



class PowerOfWorshipViewController:  UIViewController{
    
 func loadCurrentChurch (codigo: String) {
       
     //  let referenciaDB = Database.database()
       
       // .observeSingleEvent(of: .value, with: { (snapshot) in
       
       print("Este es el codigo")
       print(codigo)
       
       let userPostRef = Database.database().reference().child("Churchs").child(codigo)
         //let userPostRef = Database.database().reference().child("Media_Channels")
       userPostRef.observeSingleEvent(of: .value, with: { (data) in
           
           print("Entro a ver")
           print(data.value)
            if let devoFeed = data.value as? [String:Any] {
    
                                   
                                   advengers.shared.currentChurchInfo = Church(dictionary: devoFeed)
                                   
                                   print("Esta es la info de la church:")
                                   print(advengers.shared.currentChurchInfo.name)
                                   print(advengers.shared.currentChurchInfo.uidChurch)
                                   

                              }
           
           
          }, withCancel: { (err) in
           print("Failed to fetch like info for post:", err)
          })

       
   }
  
    /*
    func loadActiveChannel (codigo: String) {
        
      //  let referenciaDB = Database.database()
        
        // .observeSingleEvent(of: .value, with: { (snapshot) in
        
        print("Este es el codigo")
        print(codigo)
        
        let userPostRef = Database.database().reference().child("Media_Channels").child(codigo)
          //let userPostRef = Database.database().reference().child("Media_Channels")
        userPostRef.observeSingleEvent(of: .value, with: { (data) in
            
            print("Entro a ver")
            print(data.value)
             if let devoFeed = data.value as? [String:Any] {
     
                                    
                self.channelActivo = wChannel(dictionary: devoFeed)
                                    
                print("Esta es la info del active channel:")
                print(self.channelActivo.church)
                print(self.channelActivo.title)
                                    

                               }
            
            
           }, withCancel: { (err) in
            print("Failed to fetch like info for post:", err)
           })

        
    }
     */
    
  //  var channelActivo = wChannel(dictionary: ["":""])
    
        var audioPlayer: AVAudioPlayer?
        let storage = Storage.storage()
        var delegate: AudibleDelegate?
                 
        var isPlaying = false
                 
    
       lazy var statusAudio: UILabel = {
              let label2 = UILabel ()
              label2.font = UIFont(name: "Avenir-Medium", size: 12)
              label2.text = "Loading audio file ..."
              label2.textColor = .white
              //   button.setImage(UIImage(named: "cellPrayIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
              // button.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
              return label2
          }()
       
       
       
       
       lazy var praysDate: UILabel = {
           let label2 = UILabel ()
           label2.font = UIFont(name: "Avenir-Medium", size: 12)
           label2.text = "You prayed 1"
           label2.textColor = .lightGray
     
           return label2
       }()
       
       
       lazy var likeCount: UILabel = {
           let label2 = UILabel ()
           label2.font = UIFont(name: "Avenir-Medium", size: 15)
           label2.text = "0000"
      
           return label2
       }()
       
       
       lazy var commentCount: UILabel = {
           let label2 = UILabel ()
           label2.font = UIFont(name: "Avenir-Medium", size: 15)
           label2.text = "    "
     
           return label2
       }()
       
       
       let backgroundChannel: CustomImageView = {
           let iv = CustomImageView()
           iv.contentMode = .scaleAspectFill
           iv.clipsToBounds = true
           iv.backgroundColor = .blue
           return iv
       }()
       
       lazy var audioView: UIButton = {
           let iv = UIButton(type: .system)
          // iv.setTitle("Play", for: .normal)
           iv.setImage(#imageLiteral(resourceName: "payAudio").withRenderingMode(.alwaysOriginal), for: .normal)
         //  iv.setTitleColor(.black, for: .normal)
           //  iv.contentMode = .scaleAspectFill
           iv.layer.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
           
           
           
        


         
           iv.addTarget(self, action: #selector (hadlePlay), for: .touchUpInside)
           return iv
       }()
       
       

       lazy var audioViewBack: UIView = {
           
           let a = UIView()
           let fondo: String = {
               
               return "fondo" + String(Int.random(in: 1..<5))
           } ()
           
           let imagen = UIImageView(image: UIImage(named: fondo))
           
           imagen.contentMode = .scaleAspectFit
       
        //   a.bounds = CGRect(x: 0, y: 0, width: frame.width, height: 80)
           a.addSubview(imagen)
           a.alpha = 0.6
           
           
           return a
       } ()
       
    
       
       
       
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
       
        @objc func Logout () {
           try! Auth.auth().signOut()
       }
       
       
       @objc func addPlaylist () {
           
           performSegue(withIdentifier: "addPlaylist", sender: self)
       }

    
    override func viewDidLoad() {
        
        
        // TODO: REFACTORIAR, OJO CON LAS FUNCONES QUE EJCUTAN LOS BOTONES // ----------------------------
                 // ---------------------------------------------------------------------------------------------
                 navigationController?.navigationBar.backgroundColor = advengers.shared.colorBlue
                 navigationController?.navigationBar.barTintColor = advengers.shared.colorBlue
                 
                 navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "settingsincon"), style: .plain, target: self, action: #selector(advengers.shared.settings))
          
                 navigationItem.leftBarButtonItem?.tintColor = advengers.shared.colorOrange
                 
                 
                 let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,
                                       NSAttributedString.Key.font:UIFont(name: "Avenir-Heavy", size: 15)]
                 navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
                 
                 
                 
                 
                 if advengers.shared.isPastor {
                     
                    // navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+ Devotional", style: .plain, target: self, action: #selector(addDevotional))
                    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Select Channel", style: .plain, target: self, action: #selector(addPlaylist))
                     
                 }
          
                 let textAttributes2 = [NSAttributedString.Key.foregroundColor: advengers.shared.colorOrange,
                                               NSAttributedString.Key.font:UIFont(name: "Avenir-Heavy", size: 12)]
                 
                 navigationItem.rightBarButtonItem?.setTitleTextAttributes(textAttributes2 as [NSAttributedString.Key : Any], for: .normal)
                 navigationItem.rightBarButtonItem?.tintColor = advengers.shared.colorOrange
                 
                 navigationItem.title = advengers.shared.currentChurch
                 
                 // -----------------------------------------------------------------------------------------
        
            
        view.addSubview(backgroundChannel)
        
        backgroundChannel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
         loadCurrentChurch(codigo: "66888A34-D2C7-43A8-AAE4-655DA8285541")
        
          print(advengers.shared.currentChurchInfo.channelActive)
        
        //   loadActiveChannel(codigo: advengers.shared.currentChurchInfo.channelActive)
          


    }
    
      @objc func hadlePlay ()  {
                  
                  
                  isPlaying = !isPlaying
                  
                  if isPlaying{
                      audioView.setImage(#imageLiteral(resourceName: "pausebutton").withRenderingMode(.alwaysOriginal), for: .normal)
                  
                  statusAudio.isHidden = false
                      
//                  let httpsReference = storage.reference(forURL: post!.photoImage)
//
//                  httpsReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
//                      if let error = error {
//                          // Uh-oh, an error occurred!
//                      } else {
//
//
//                          self.playContent(data: data!)
//                          self.statusAudio.isHidden = true
//
//
//                      }
//
//
//
//                  }
//
//
//                  let url = URL(fileURLWithPath: post!.photoImage)
//
//                  print ("Click ok")
//
//                  print(url.absoluteString)
//
//
//                  } else {
//
//                      audioView.setImage(#imageLiteral(resourceName: "payAudio").withRenderingMode(.alwaysOriginal), for: .normal)
//                      audioPlayer?.stop()
//                  }
                  
              }
              
        func playContent (data: Data)
                  
              {
                  
                  
                  do {
                      
                      audioPlayer = try AVAudioPlayer(data: data)
                      audioPlayer?.play()
                      print("Playing ....")
                  } catch {
                      print ("No Playing")
                      //print(url.absoluteString)
                  }
                  
                  
                  
                  
              }
              

           
       }


    
}


//
//  PowerOfWorshipViewController.swift
//  altar
//
//  Created by Juan Moreno on 1/6/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import UIKit
import AVFoundation
import WebKit
import Alamofire
import Firebase



class PowerOfWorshipViewController:  UIViewController{
    
    var videos: [Video] = {
           var kanyeChannel = Channel()
           kanyeChannel.name = "KanyeIsTheBestChannel"
           kanyeChannel.profileImageName = "kanye_profile"
           
           var blankSpaceVideo = Video()
           blankSpaceVideo.title = "Taylor Swift - Blank Space"
           blankSpaceVideo.thumbnailImageName = "taylor_swift_blank_space"
           blankSpaceVideo.channel = kanyeChannel
           blankSpaceVideo.numberOfViews = 23932843093
           
           var badBloodVideo = Video()
           badBloodVideo.title = "Taylor Swift - Bad Blood featuring Kendrick Lamar"
           badBloodVideo.thumbnailImageName = "taylor_swift_bad_blood"
           badBloodVideo.channel = kanyeChannel
           badBloodVideo.numberOfViews = 57989654934
           
           return [blankSpaceVideo, badBloodVideo]
       }()
    
    @IBOutlet weak var playerWeb: WKWebView!
    var videoURL:URL!  // has the form "https://www.youtube.com/embed/videoID"
    var didLoadVideo = false
    
    
    override func viewDidLoad() {
        
        print("Conectando a Youtube")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create Playlist", style: .plain, target: self, action: #selector(addPlaylist))
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(Logout))
        

    
        
       // videoURL = URL(string: "https://www.youtube.com/embed/F4sTcCcVkPw")
       // playerWeb.configuration.mediaTypesRequiringUserActionForPlayback = []
        
        
   //     fetchVideos()
        
        
    }
    
    @objc func Logout () {
        try! Auth.auth().signOut()
    }
    
    
    @objc func addPlaylist () {
        
        performSegue(withIdentifier: "addPlaylist", sender: self)
    }
    /*
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Size of the webView is used to size the YT player frame in the JS code
        // and the size of the webView is only known in `viewDidLayoutSubviews`,
        // however, this function is called again once the HTML is loaded, so need
        // to store a bool indicating whether the HTML has already been loaded once
        if !didLoadVideo {
            playerWeb.loadHTMLString(embedVideoHtml, baseURL: nil)
            didLoadVideo = true
        }
    }
*/
    

    func fetchVideos() {
        let url = NSURL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        URLSession.shared.dataTask(with: url! as URL) { (data, response, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                self.videos = [Video]()
                
                for dictionary in json as! [[String: AnyObject]] {
                    
                    let video = Video()
                    video.title = dictionary["title"] as? String
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    
                    let channelDictionary = dictionary["channel"] as! [String: AnyObject]
                    
                    let channel = Channel()
                    channel.name = channelDictionary["name"] as? String
                    channel.profileImageName = channelDictionary["profile_image_name"] as? String
                    
                    video.channel = channel
                    
                    self.videos.append(video)
                    print (self.videos[0].channel)
                    print (self.videos[0].thumbnailImageName)
                    print (self.videos[0].title)
                    
                }
                
             //   self.collectionView?.reloadData()
                
            } catch let jsonError {
                print(jsonError)
            }
            
            
            
        }.resume()
        

    }
 


}


        /*  --------------- como que funciona
        var mywkwebview: WKWebView?
        let mywkwebviewConfig = WKWebViewConfiguration()

        mywkwebviewConfig.allowsInlineMediaPlayback = true
        mywkwebview = WKWebView(frame: self.view.frame, configuration: mywkwebviewConfig)

        let myURL = URL(string: "https://www.youtube.com/embed/F4sTcCcVkPw?playsinline=1?autoplay=1")
        var youtubeRequest = URLRequest(url: myURL!)

        mywkwebview?.load(youtubeRequest)
        
        guard let webView = mywkwebview else { return }
        
        
        self.view.addSubview(webView)
 
 */
/*
      //  let urlString = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"
        
        //https://www.youtube.com/watch?v=F4sTcCcVkPw
        
        let urlString = "https://www.youtube.com/watch?v=F4sTcCcVkPw"
        
             if let url = NSURL(string: urlString) {
                let player = AVPlayer(url: url as URL)
                 
                 let playerLayer = AVPlayerLayer(player: player)
                 view.layer.addSublayer(playerLayer)
                playerLayer.frame = self.view.frame
                 
                 player.play()
                
                
             }
 
  */

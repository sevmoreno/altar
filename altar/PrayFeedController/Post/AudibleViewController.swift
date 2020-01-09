//
//  AudibleViewController.swift
//  altar
//
//  Created by Juan Moreno on 1/8/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import Firebase

class AudibleViewController: UIViewController, AVAudioRecorderDelegate {
    
    let viewToRercord: UIView = {
           
           let imagen = UIView ()
          
           return imagen
       } ()
    
    let playRercord: UIButton = {
             
             let imagen = UIButton ()
            imagen.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
             imagen.addTarget(self, action: #selector (playAudio), for: .touchUpInside)
                
        
            
             return imagen
         } ()
    
    
    
    let postRercord: UIButton = {
             
             let boton = UIButton ()
             boton.layer.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
             boton.addTarget(self, action: #selector (postAudio), for: .touchUpInside)
             boton.setTitle("Post", for: .normal)
                
        
            
             return boton
         } ()
    
    var activeMemory: URL!
    var urlTemporario: URL!
    var audioRecorder: AVAudioRecorder?
    var grabacionPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        checkPermissions()
   
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(memoryLongPress))
            recognizer.minimumPressDuration = 0.25
            viewToRercord.addGestureRecognizer(recognizer)
            viewToRercord.layer.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
            viewToRercord.layer.borderColor = UIColor.white.cgColor
            viewToRercord.layer.borderWidth = 3
            viewToRercord.layer.cornerRadius = 10
        
        view.addSubview(viewToRercord)
        
        view.addSubview(playRercord)
        
        view.addSubview(postRercord)
        
        viewToRercord.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 400, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 60, height: 60)
        viewToRercord.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        playRercord.anchor(top: viewToRercord.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 60, height: 60)
        playRercord.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        postRercord.anchor(top: playRercord.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 60, height: 60)
        postRercord.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
      
        // Do any additional setup after loading the view.
    }
    
    @objc func playAudio ()  {
        
        
        let url = urlTemporario

        do {
            grabacionPlayer = try AVAudioPlayer(contentsOf: url!)
            grabacionPlayer?.play()
        } catch {
            
            print("No Cargo")
            // couldn't load file :(
        }
        
        
    }
    
    @objc func memoryLongPress (sender: UILongPressGestureRecognizer) {
        
        if sender.state == .began {
          
            urlTemporario = getDocumentsDirectory()
                   
            urlTemporario = urlTemporario.appendingPathComponent("recording.m4a")
            
            recordMemory()
        } else if sender.state == .ended {
            print ("OKEY")
            finishRecording(success: true)
            
        }

        
        
    }
    
    func recordMemory() {
        
        
        
        viewToRercord.backgroundColor = .red

        // this just saves me writing AVAudioSession.sharedInstance() everywhere
        let recordingSession = AVAudioSession.sharedInstance()

        do {
            // 2. configure the session for recording and playback through the speaker
            try recordingSession.setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
            try recordingSession.setActive(true)

            // 3. set up a high-quality recording session
            
            /*
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 2,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
 */
            let settings:[String:Any] = [AVFormatIDKey:kAudioFormatAppleLossless,
            AVEncoderAudioQualityKey:AVAudioQuality.max.rawValue,
            AVEncoderBitRateKey:320000,
            AVNumberOfChannelsKey:2,
            AVSampleRateKey:44100.0 ] as [String : Any]

            // 4. create the audio recording, and assign ourselves as the delegate
          audioRecorder = try AVAudioRecorder(url: urlTemporario, settings: settings)
          audioRecorder?.delegate = self
          audioRecorder?.record()
            
         
            } catch let error {
            // failed to record!
            print("Failed to record: \(error)")
             finishRecording(success: false)
                }
 
 
            }
    
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    

    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }

    func finishRecording(success: Bool) {
        // 1
        viewToRercord.backgroundColor = UIColor.darkGray

        // 2
        audioRecorder?.stop()

        
        /*
        if success {
            do {
                let memoryAudioURL = activeMemory.appendingPathExtension("m4a")
                let fm = FileManager.default

                            // 4
                if fm.fileExists(atPath: memoryAudioURL.path) {
                                try fm.removeItem(at: memoryAudioURL)
                            }

                            // 5
                 try fm.moveItem(at: recordingURL, to: memoryAudioURL)

                            // 6
                           // transcribeAudio(memory: activeMemory)
                        } catch let error {
                            print("Failure finishing recording: \(error)")
                        }
                    }
  */
        
                }

    func checkPermissions() {
        // check status for all three permissions
        let photosAuthorized = PHPhotoLibrary.authorizationStatus() == .authorized
        let recordingAuthorized = AVAudioSession.sharedInstance().recordPermission == .granted
     //   let transcibeAuthorized = SFSpeechRecognizer.authorizationStatus() == .authorized

        // make a single boolean out of all three
        let authorized = photosAuthorized && recordingAuthorized
        // if we're missing one, show the first run screen
        if authorized == false {
            
            requestPhotosPermissions()
           // if let vc = storyboard?.instantiateViewController(withIdentifier: "FirstRun") {
            //    navigationController?.present(vc, animated: true)
            print("Falta permiso")
            }
        }
    
    func requestPhotosPermissions() {
        PHPhotoLibrary.requestAuthorization { [unowned self] authStatus in
            DispatchQueue.main.async {
                if authStatus == .authorized {
                    self.requestRecordPermissions()
                } else {
                    print(" ok ")
                }}}}
    
    func requestRecordPermissions() {
        AVAudioSession.sharedInstance().requestRecordPermission() { [unowned self] allowed in
            
            DispatchQueue.main.async {
                        if allowed {
                            //
                              //self.requestTranscribePermissions()
                        } else {
                            print("Recording permission was declined; please enable it in settings then tap Continue again.")
                        }
                    }
                }
            }

   
    
    @objc func postAudio () {
        
        AppDelegate.instance().showActivityIndicatior()
              
              let uid = Auth.auth().currentUser?.uid
        
              let nombreToDisplay = advengers.shared.currenUSer["name"] ?? "Unknow"
              let userphot = advengers.shared.currenUSer["photoURL"] ?? "No cargo"
              
              let key = advengers.shared.postPrayFeed.childByAutoId().key
              
             // let imageRef = advengers.shared.PostPrayStorage.child(uid!).child("\(key!).jpg")

              
              
             
        
               let data = try! Data(contentsOf: urlTemporario)
               let storageRef = Storage.storage().reference().child("Videos").child(uid!).child(key!)
               let putAudio = storageRef.putData(data, metadata: nil
                          , completion: { (metadata, error) in
                              if let error = error {
                                  print ("Error subiendo Audio a Firebase")
                              }else{
                                 
                                storageRef.downloadURL(completion: { (url, error) in
                                    if let url = url {
                                        
                                        let feed = ["userid": uid,
                                                    "pathtoPost":url.absoluteString,
                                                    "prays": 0,
                                                    "author": nombreToDisplay,
                                                    "userPhoto": userphot,
                                                    "postID": key,
                                                    "postType": advengers.postType.audio.rawValue,
                                                    "message": "audio" as String,
                                                    "imagH:": 0.0,
                                                    "imagW:": 0.0
                                            
                                            
                                                    ] as! [String:Any]
                                        
                                        let postfeed = ["\(key!)" : feed] as! [String:Any]
                                        
                                        advengers.shared.postPrayFeed.updateChildValues(postfeed)
                                        
                                        AppDelegate.instance().dismissActivityIndicator()
                                        
                                        _ = self.navigationController?.popViewController(animated: true)
                                        
                                        
                                    }
                                })
                                
                              }
                      })
        
                    putAudio.resume()
        
                    
        
    }
    


        

        
        
        
   /*
        func convertVideo(toMPEG4FormatForVideo inputURL: URL, outputURL: URL, handler: @escaping (AVAssetExportSession) -> Void) {
            try! FileManager.default.removeItem(at: outputURL as URL)
            let asset = AVURLAsset(url: inputURL as URL, options: nil)

            let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality)!
            exportSession.outputURL = outputURL
            exportSession.outputFileType = .mp4
            exportSession.exportAsynchronously(completionHandler: {
                handler(exportSession)
            })
        }
        
    }
  
*/

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    

    
    

}
//
//  PrayViewController.swift
//  altar
//
//  Created by Juan Moreno on 9/13/19.
//  Copyright © 2019 Juan Moreno. All rights reserved.
//

import UIKit
import Firebase

class UsersViewController: UIViewController, UIScrollViewDelegate {
    

    @IBOutlet weak var tablaUsuarios: UITableView!
    
    @IBOutlet weak var contenedor: UIView!
    
    var users = [User] ()
    @IBOutlet weak var pageController: UIPageControl!
    var slides:[Slide3Type] = []
    var eventos:[Event] = []
    @IBOutlet var scrollView: UIScrollView!
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

            let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
            pageController.currentPage = Int(pageIndex)

            let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
            let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x

      //       vertical
            let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
            let currentVerticalOffset: CGFloat = scrollView.contentOffset.y

            let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
            let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset


            /*
             * below code changes the background color of view on paging the scrollview
             */
    //        self.scrollView(scrollView, didScrollToPercentageOffset: percentageHorizontalOffset)


            /*
             * below code scales the imageview on paging the scrollview
//             */
//            let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
//
//            if(percentOffset.x > 0 && percentOffset.x <= 0.25) {
//
//                slides[0].photoImageView.transform = CGAffineTransform(scaleX: (0.25-percentOffset.x)/0.25, y: (0.25-percentOffset.x)/0.25)
//                slides[1].photoImageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.25, y: percentOffset.x/0.25)
//
//            } else if(percentOffset.x > 0.25 && percentOffset.x <= 0.50) {
//                slides[1].photoImageView.transform = CGAffineTransform(scaleX: (0.50-percentOffset.x)/0.25, y: (0.50-percentOffset.x)/0.25)
//                slides[2].photoImageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.50, y: percentOffset.x/0.50)
//
//            } else if(percentOffset.x > 0.50 && percentOffset.x <= 0.75) {
//                slides[2].photoImageView.transform = CGAffineTransform(scaleX: (0.75-percentOffset.x)/0.25, y: (0.75-percentOffset.x)/0.25)
//                slides[3].photoImageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.75, y: percentOffset.x/0.75)
//
//            } else if(percentOffset.x > 0.75 && percentOffset.x <= 1) {
//                slides[3].photoImageView.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.25, y: (1-percentOffset.x)/0.25)
//                slides[4].photoImageView.transform = CGAffineTransform(scaleX: percentOffset.x, y: percentOffset.x)
//            }
        }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
         /*
          *
          */
        setupSlideScrollView(slides: slides)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name(rawValue: "loadEvent"), object: nil)
       // loadEvent
     //   contenedor.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    
        
        tablaUsuarios.backgroundColor = advengers.shared.colorBlue
        
        tablaUsuarios.delegate = self
        tablaUsuarios.dataSource = self
        
        view.backgroundColor = advengers.shared.colorBlue
        scrollView.delegate = self
        
        
      //  tablaUsuarios.register(UsuariosUITableTableViewCell.self, forCellReuseIdentifier: "cell")
      //  pageController.numberOfPages = slides.count
    //    pageController.currentPage = 0
    //    view.bringSubview(toFront: pageControl)
        
    //    pageController.numberOfPages = 6
        
     //   navigationItem.title = advengers.shared.currentChurch
        
        // TODO: REFACTORIAR, OJO CON LAS FUNCONES QUE EJCUTAN LOS BOTONES // ----------------------------
                      // ---------------------------------------------------------------------------------------------
                      navigationController?.navigationBar.backgroundColor = advengers.shared.colorBlue
                      navigationController?.navigationBar.barTintColor = advengers.shared.colorBlue
                      
                      navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "settingsincon"), style: .plain, target: self, action: #selector(logout))
               
                      navigationItem.leftBarButtonItem?.tintColor = advengers.shared.colorOrange
                      
                      
                      let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,
                                            NSAttributedString.Key.font:UIFont(name: "Avenir-Heavy", size: 15)]
                      navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
                      
                      
                      
                      
                      if advengers.shared.isPastor {
                          
                          navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+ Event", style: .plain, target: self, action: #selector(addEnvent))
                          
                      }
               
                      let textAttributes2 = [NSAttributedString.Key.foregroundColor: advengers.shared.colorOrange,
                                                    NSAttributedString.Key.font:UIFont(name: "Avenir-Heavy", size: 15)]
                      
                      navigationItem.rightBarButtonItem?.setTitleTextAttributes(textAttributes2 as [NSAttributedString.Key : Any], for: .normal)
                      navigationItem.rightBarButtonItem?.tintColor = advengers.shared.colorOrange
                      
                      navigationItem.title = advengers.shared.currentChurch
                      
                      // -----------------------------------------------------------------------------------------
               
        
        loadEvents(completionHandler: { (success) -> Void in
            

            if success {
                self.slides = self.createSlides()
                self.setupSlideScrollView(slides: self.slides)
                
                
                print("HEy")
                
                for ele in self.slides {
                    
                   print(ele.usernameLabel.text)
                }
                
                
                for ele in self.eventos {
                    
                    print(ele.title)
                }
            }
            
        })
       
        retriveUsers ()
        // Do any additional setup after loading the view.
    }
//    func createSlides() -> [Slide] {
//
//        let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
//        slide1.imageView.image = UIImage(named: "fondo1")
//        slide1.title.text = "A real-life bear"
////        slide1.labelDesc.text = "Did you know that Winnie the chubby little cubby was based on a real, young bear in London"
//
//        let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
//        slide2.imageView.image = UIImage(named: "fondo2")
//        slide2.title.text = "A real-life bear"
//
//        return [slide1, slide2]
//    }
    
    func loadEvents (completionHandler: @escaping (_ success:Bool) -> Void) {
           //            guard let currentChurchID = advengers.shared.currenUSer["churchID"] as? String else { return }
           //                   let userPostRef = Database.database().reference().child("Events").child(currentChurchID)
        
         //  let referenciaDB = Database.database()
           
           // .observeSingleEvent(of: .value, with: { (snapshot) in
            guard let currentChurchID = advengers.shared.currenUSer["churchID"] as? String else { return }
            Database.database().reference().child ("Events").child(currentChurchID).observeSingleEvent(of: .value, with: { (data) in
               
               
                if let devoFeed = data.value as? [String:NSDictionary] {
                                      
                                      for (_,value) in devoFeed
                                      {

                                        let even  = Event (dictionary: value as! [String : Any])
              
                             
                                       
                                       
                                       self.eventos.append(even)
                                       
                                       
                                        let a = Slide3Type ()
                                        
                                        a.even?.photoURL = even.photoURL
                                        a.even?.title = even.title
                                        
                                        self.slides.append(a)
                                       //   let temporarioPost = Posts (dictionary: value as! [String : Any])
                                          
                                         
                          //                self.photos.append(temporariost)
                            //              self.collectionView.reloadData()

                                       // self.scrollView.reloadData()
                                      }
                                      
                                       completionHandler(true)
                                  }
               
               
              }, withCancel: { (err) in
               print("Failed to fetch like info for post:", err)
               completionHandler(false)
              })
    }
    
    
        func createSlides() -> [Slide3Type] {
            
//
            var fechados = [Slide3Type] ()
            for elementos in eventos {
                
                let slide1 = Slide3Type ()
                
               
                slide1.photoImageView.loadImage(urlString: elementos.photoURL)
                slide1.usernameLabel.text =  elementos.title
                
                fechados.append(slide1)
            }
//            guard let currentChurchID = advengers.shared.currenUSer["churchID"] as? String else { return }
//                   let userPostRef = Database.database().reference().child("Events").child(currentChurchID)
//
//            let slide1 = Slide3Type ()
//            slide1.photoImageView.image = UIImage(named: "fondo1")
//          slide1.usernameLabel.text = "A real-life bear"
    //        slide1.labelDesc.text = "Did you know that Winnie the chubby little cubby was based on a real, young bear in London"
    
//            let slide2 = Slide3Type ()
//            slide2.photoImageView.image = UIImage(named: "fondo1")
//          slide2.usernameLabel.text = "A real-life bear"
    
            return fechados
        }
    
//
    func setupSlideScrollView(slides : [Slide3Type]) {
          scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 383)
          scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: 383)
          scrollView.isPagingEnabled = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
          tap.numberOfTapsRequired = 2
          scrollView.addGestureRecognizer(tap)
        pageController.numberOfPages = slides.count
          scrollView.contentInsetAdjustmentBehavior = .never
          for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: 383)
            scrollView.addSubview(slides[i])
          }
      }
    
    @objc func doubleTapped () {
        print ("Double tap")
        print (pageController.currentPage)
           advengers.shared.eventolSeleccinado = eventos[pageController.currentPage]
        
        let devocionalSeleccionado = EventoSeleccionado ()
       // performSegue(withIdentifier: "aEvent", sender: self)
       navigationController?.pushViewController(devocionalSeleccionado, animated: true)
           
    }
    
    @objc func addEnvent()  {
        
        performSegue(withIdentifier: "addEvent", sender: self)
    }
    
    func retriveUsers () -> Void {
        
        advengers.shared.usersStatusRef.queryOrderedByKey().observe(.value) { (datasnap) in
            let usersRead = datasnap.value as! [ String : NSDictionary]
            //self.users.removeAll()
            
            for (_,value) in usersRead {
                
                print("heeyyy")
                
                print(datasnap.value)
                
                if let userid = value["userid"] as? String {
                    
                     print("Entra")
                     print(userid)
                    
                    if userid != Auth.auth().currentUser?.uid
                    {
                        if advengers.shared.currentChurch == value["church"] as? String {
                            
                            let userToShow = User()
                            userToShow.setup(uid: value["userid"] as? String ?? "", dictionary:  value as! [String : Any])
                            
//                            let userToShow = User(uid: value["userid"] as? String ?? "", dictionary: value as! [String : Any])
//                            userToShow.userID = value["userid"] as? String ?? ""
//                            userToShow.fullName = value["name"] as? String ?? ""
//                            userToShow.email = value["email"] as? String ?? ""
//                            userToShow.photoUser = value["photoURL"] as? String ?? ""
                            
                            self.users.append(userToShow)
                            self.tablaUsuarios.reloadData()
                          
                        }
                        
                        
                    }
                }
            }
           
            
            
        }
     // advengers.shared.usersStatusRef.removeAllObservers()
        
    }

    @IBAction func logout(_ sender: Any) {
        
       
               let settingsController = SettingsViewController()
              // navigationController?.pushViewController(signUpController, animated: true)
               
                present(settingsController, animated: true, completion: nil)
        
    }
    
    @IBAction func reloadData(_ sender: Any) {
        
        
        print(self.users.count)
         self.tablaUsuarios.reloadData()
        
    }
    
}



extension UsersViewController: UITableViewDelegate, UITableViewDataSource {


func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   // return users.count
    
    return users.count
    
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
    
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellA", for: indexPath) as! UsuariosUITableTableViewCell
    
    cell.foto.loadImage(urlString: users[indexPath.row].photoUser)
    cell.nombre.text = users[indexPath.row].fullName
        
        //users[indexPath.row].fullName ?? "No name"
   // cell.user = users[indexPath.row]
    
//
//     if users.count != nil {
//
//     if let titulo = cell.viewWithTag(200) as? UILabel
//
//     {
//     titulo.text = users[indexPath.row].fullName
//
//     }
//
//     cell.nombre.text = users[indexPath.row].fullName
//     cell.userId = users[indexPath.row].userID
//    cell.foto.downloadImage(imgURL: users[indexPath.row].photoUser)
//
//                            }
 
   // cell.backgroundColor = .red
    
    return cell
    
}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let chat = ChatViewController ()
        chat.user2Name = users[indexPath.row].fullName
        chat.user2UID = users[indexPath.row].uid
        chat.user2ImgUrl = users[indexPath.row].photoUser
        navigationController?.pushViewController(chat, animated: true)
        
        
    }
    
}



extension UsersViewController: UITextViewDelegate {
    
    
}

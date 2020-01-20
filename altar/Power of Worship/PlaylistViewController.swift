//
//  PlaylistViewController.swift
//  altar
//
//  Created by Juan Moreno on 1/16/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import UIKit

class PlaylistViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search Song", style: .plain, target: self, action: #selector(searchSong))
        view.backgroundColor  = .yellow

        // Do any additional setup after loading the view.
    }
    

    @objc func searchSong () {
        
         performSegue(withIdentifier: "searchSong", sender: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

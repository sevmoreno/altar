//
//  DevocionalSeleccionado.swift
//  altar
//
//  Created by Juan Moreno on 1/20/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import Foundation
import UIKit

class DevocionalSeleccionado: UIViewController {
    
    var devo = Devo()
    
    let textoDevocional: UITextView = {
        
        let a = UITextView ()
        
        
        return a
        
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        devo = advengers.shared.devocionalSeleccinado
        
        view.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
       // textoDevocional.loadAttributedText(urlString: devo.urltexto)
        
        view.addSubview(textoDevocional)
        
        textoDevocional.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 0)
        
        print(devo.urltexto)
       print(devo.title)
        guard let url = URL(string: devo.urltexto) else { return }
            
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                if let err = err {
                    print("Failed to fetch HTML:", err)
                    return
                }
                
                
               // if let attributedString = try! NSAttributedString(data: data!, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                let attributedString = try! NSAttributedString(data: data!, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
                    print("Este es el texto que bajo")
                    print(attributedString)
                    
                   DispatchQueue.main.async {
                    self.textoDevocional.attributedText = attributedString
                    }
          //
               
        }.resume()
        
        
        
    }
}

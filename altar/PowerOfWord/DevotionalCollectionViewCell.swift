//
//  DevotionalCollectionViewCell.swift
//  altar
//
//  Created by Juan Moreno on 1/6/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import UIKit

class DevotionalCollectionViewCell: UICollectionViewCell {
    
    let viewGeneral: UIView  = {
        let a = UIView ()
        a.backgroundColor = .cyan
        
        
        return a
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(viewGeneral)
        viewGeneral.translatesAutoresizingMaskIntoConstraints = false
        viewGeneral.heightAnchor.constraint(equalToConstant: 140).isActive = true
        viewGeneral.widthAnchor.constraint(equalToConstant: 140).isActive = true
        viewGeneral.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        viewGeneral.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        
        
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

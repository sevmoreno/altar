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
        
        addSubview(viewGeneral)
        
        
        
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

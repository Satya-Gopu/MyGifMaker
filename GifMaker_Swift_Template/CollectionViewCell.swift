//
//  CollectionViewCell.swift
//  GifMaker_Swift_Template
//
//  Created by Satyanarayana Gopu on 4/21/17.
//  Copyright © 2017 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var cellImage: UIImageView!
    
    func configurecell(gif : Gif){
        
        cellImage.image = gif.gifImage
    }
    
    
    
}

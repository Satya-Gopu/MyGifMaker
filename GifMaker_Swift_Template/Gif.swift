//
//  Gif.swift
//  GifMaker_Swift_Template
//
//  Created by Satyanarayana Gopu on 4/20/17.
//  Copyright © 2017 Gabrielle Miller-Messner. All rights reserved.
//

import Foundation
import UIKit

class Gif{
    
    var url : URL!
    var caption : String!
    var gifImage : UIImage!
    var videourl: URL!
    var gifData : NSData!
    
    
    init(gifUrl: URL, videourl: URL, caption: String!){
        
          self.url = gifUrl
        self.videourl = videourl
        self.caption = caption
        self.gifImage = UIImage.gif(url: gifUrl.absoluteString)!
        self.gifData = nil
    }
    
    init(name : String){
        
        self.gifImage = UIImage.gif(name: name)!
        
    }
    
    
    
    
    
    
}

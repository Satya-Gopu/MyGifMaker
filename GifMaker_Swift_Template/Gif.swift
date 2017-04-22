//
//  Gif.swift
//  GifMaker_Swift_Template
//
//  Created by Satyanarayana Gopu on 4/20/17.
//  Copyright © 2017 Gabrielle Miller-Messner. All rights reserved.
//

import Foundation
import UIKit

class Gif : NSObject, NSCoding{
    
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
    
    required init?(coder aDecoder: NSCoder) {
        self.url = aDecoder.decodeObject(forKey: "url") as! URL
        self.caption = aDecoder.decodeObject(forKey: "caption") as? String
        self.videourl = aDecoder.decodeObject(forKey: "videourl") as! URL
        self.gifImage = aDecoder.decodeObject(forKey: "gifImage") as! UIImage
        self.gifData = aDecoder.decodeObject(forKey: "gifData") as? NSData
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.url, forKey: "url")
        aCoder.encode(self.caption, forKey: "caption")
        aCoder.encode(self.videourl, forKey: "videourl")
        aCoder.encode(self.gifImage, forKey: "gifImage")
        aCoder.encode(self.gifData, forKey: "gifData")
    }
    
    
}

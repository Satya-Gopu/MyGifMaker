//
//  DetailViewController.swift
//  GifMaker_Swift_Template
//
//  Created by Satyanarayana Gopu on 4/21/17.
//  Copyright © 2017 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var gif : Gif!
    
    @IBOutlet weak var image: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.image.image = UIImage.gif(url: self.gif.url.absoluteString)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func share(sender : Any){
    
        let imageData = NSData(contentsOf: self.gif!.url)!
        let itemArray = [imageData]
        
        let activity = UIActivityViewController(activityItems: itemArray, applicationActivities: nil)
        
        activity.completionWithItemsHandler = {(activity, completed, dono, error) in
            if(completed){
                
                self.navigationController?.popToRootViewController(animated: true)
            }
            
        }
        self.present(activity, animated: true, completion: nil)
    
    
    }
    
    @IBAction func dismiss(){
        
        self.dismiss(animated: true, completion: nil)
        
    }


}

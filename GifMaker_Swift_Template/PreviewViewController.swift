//
//  PreviewViewController.swift
//  GifMaker_Swift_Template
//
//  Created by Satyanarayana Gopu on 4/18/17.
//  Copyright © 2017 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {
    
    var gif : Gif!

    @IBOutlet weak var image: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.image.image = UIImage.gif(url: self.gif.url.absoluteString)
    }

    @IBAction func share(_ sender: Any) {
        
        let data = NSData(contentsOf: (self.gif?.url)!)!
        let activityarray = [data]
        
        var activity = UIActivityViewController(activityItems: activityarray as! [Any], applicationActivities: nil)
        
        activity.completionWithItemsHandler = {(activity, completed, donno, err0r) in
            if(completed){
                
                self.dismiss(animated: true, completion: nil)
            }
            
        }
        
        self.present(activity, animated: true, completion: nil)
        
    }
    
    @IBAction func save(_ sender: Any) {
    }
    
    

}

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
    }
    
    @IBAction func save(_ sender: Any) {
    }
    
    

}

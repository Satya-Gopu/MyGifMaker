//
//  GifEditorViewController.swift
//  GifMaker_Swift_Template
//
//  Created by Satyanarayana Gopu on 4/18/17.
//  Copyright © 2017 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

class GifEditorViewController: UIViewController {
    
    var gifurl : NSURL? = nil

    @IBOutlet weak var gifImage: UIImageView!
    
    @IBOutlet weak var caption: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let url = gifurl{
        super.viewWillAppear(animated)
        self.gifImage.image = UIImage.gif(url: (url.absoluteString)!)
        }
    }

    
    

}

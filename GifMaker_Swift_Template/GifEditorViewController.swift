//
//  GifEditorViewController.swift
//  GifMaker_Swift_Template
//
//  Created by Satyanarayana Gopu on 4/18/17.
//  Copyright © 2017 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

class GifEditorViewController: UIViewController, UITextFieldDelegate {
    
    var gif: Gif?
    @IBOutlet weak var gifImage: UIImageView!
    @IBOutlet weak var captionText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let url = self.gif?.url{
        self.gifImage.image = UIImage.gif(url: (url.absoluteString))
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardwillshow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardwillhide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
            
            
        }
    }
    
    
    @IBAction func presentPreview(){
        
        var preview = self.storyboard?.instantiateViewController(withIdentifier: "PreviewViewController") as! PreviewViewController
        
        let regift = Regift(sourceFileURL: (self.gif?.videourl)!, destinationFileURL: nil, frameCount: framecount, delayTime: delatTime, loopCount: loopcount)
        let font = self.captionText.font
        let gifurl = regift.createGif(caption: self.captionText.text, font: font)
        
        let newgif = Gif(gifUrl: gifurl!, videourl: (self.gif?.videourl)!, caption: self.captionText.text)
        preview.gif = newgif
        preview.delegate = self.navigationController?.viewControllers[0] as? PreviewViewControllerDelegate
        self.navigationController?.pushViewController(preview, animated: true)
        
    }
    
    func keyboardwillshow(notification: NSNotification){
        let keyboardSize = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as! NSValue
        let keyboardheight = keyboardSize.cgRectValue.height
        if (self.view.center.y >= 0){
            
            self.view.frame.origin.y -= keyboardheight
            
        }
        
    }

    func keyboardwillhide(notification: NSNotification){
        let keyboardSize = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as! NSValue
        let keyboardheight = keyboardSize.cgRectValue.height
        if (self.view.frame.origin.y <= 0){
            
            self.view.frame.origin.y += keyboardheight
            
            
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}


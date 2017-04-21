//
//  UIViewController+Record.swift
//  GifMaker_Swift_Template
//
//  Created by Satyanarayana Gopu on 4/19/17.
//  Copyright © 2017 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit
import Foundation
import MobileCoreServices

let framecount = 16
let delatTime:Float = 0.2
let loopcount = 0

extension UIViewController{
    
    @IBAction func LaunchVideoCamera(sender: AnyObject){
        if(!UIImagePickerController.isSourceTypeAvailable(.camera)){
            self.launchPhotoLibrary()
        }
        else{
            let alert = UIAlertController(title: "create new gif", message: "", preferredStyle: .actionSheet)
            let action1 = UIAlertAction(title: "camera", style: .default, handler: { action in
                self.launchcamera()
            })
            let action2 = UIAlertAction(title: "photo Library", style: .default, handler: {action in
                self.launchPhotoLibrary()
                
            })
            let action3 = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
            alert.addAction(action1)
            alert.addAction(action2)
            alert.addAction(action3)
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    func launchPhotoLibrary(){
        
        let recordViewController = UIImagePickerController()
        recordViewController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        recordViewController.mediaTypes = [kUTTypeMovie as String]
        recordViewController.allowsEditing = false
        recordViewController.delegate = self
        self.present(recordViewController, animated: true, completion: nil)
        
        
    }
    func launchcamera(){
        let recordViewController = UIImagePickerController()
        recordViewController.sourceType = UIImagePickerControllerSourceType.camera
        recordViewController.mediaTypes = [kUTTypeMovie as String]
        recordViewController.allowsEditing = false
        recordViewController.delegate = self
        self.present(recordViewController, animated: true, completion: nil)
        
        
        
    }
    
    
}

extension UIViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        
        if mediaType == kUTTypeMovie as String{
            let mediaUrl = info[UIImagePickerControllerMediaURL] as! NSURL
            UISaveVideoAtPathToSavedPhotosAlbum(mediaUrl.path!, nil, nil, nil)
            dismiss(animated: true, completion: nil)
            self.convertVideoToGif(videoUrl: mediaUrl)
            
        }
        
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func convertVideoToGif(videoUrl: NSURL){
        
        let regift = Regift(sourceFileURL: videoUrl as URL, frameCount: framecount, delayTime: delatTime)
        let gifurl = regift.createGif()
        
        var gif = Gif(gifUrl: gifurl!, videourl: videoUrl as URL, caption: nil)
        self.displayGif(gif : gif)
        
    }
    
    func displayGif(gif : Gif){
        
        var editor = self.storyboard?.instantiateViewController(withIdentifier: "GifEditorViewController") as! GifEditorViewController
        editor.gif = gif
        self.navigationController?.pushViewController(editor, animated: true)
        
    }
    
}

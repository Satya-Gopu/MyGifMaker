//
//  UIViewController+Record.swift
//  GifMaker_Swift_Template
//
//  Created by Satyanarayana Gopu on 4/19/17.
//  Copyright © 2017 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation
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
            let alert = UIAlertController(title: "create new gif", message: nil, preferredStyle: .actionSheet)
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
        recordViewController.allowsEditing = true
        recordViewController.delegate = self
        self.present(recordViewController, animated: true, completion: nil)
        
        
    }
    func launchcamera(){
        let recordViewController = UIImagePickerController()
        recordViewController.sourceType = UIImagePickerControllerSourceType.camera
        recordViewController.mediaTypes = [kUTTypeMovie as String]
        recordViewController.allowsEditing = true
        recordViewController.delegate = self
        self.present(recordViewController, animated: true, completion: nil)
        
        
        
    }
    
    
}

extension UIViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        //picker.allowsEditing = true
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        let start = info["_UIImagePickerControllerVideoEditingStart"] as? NSNumber
        let stop = info["_UIImagePickerControllerVideoEditingEnd"] as? NSNumber
        var duration : Float!
        if start != nil{
            duration = stop!.floatValue - start!.floatValue
        }
        if mediaType == kUTTypeMovie as String{
            let mediaUrl = info[UIImagePickerControllerMediaURL] as! NSURL
            UISaveVideoAtPathToSavedPhotosAlbum(mediaUrl.path!, nil, nil, nil)
            dismiss(animated: true, completion: nil)
            self.convertVideoToGif(videoUrl: mediaUrl, start: start, duration:duration)
            
        }
        
    }
    /*
    func cropVideoToSquare(videoUrl: NSURL, start : NSNumber?, duration : Float?){
        //create avasset
        let avasset = AVAsset(url: videoUrl as URL)
        let videoTrack = avasset.tracks(withMediaType: AVMediaTypeVideo)[0]
        
        //crop to square
        var videocomposition = AVMutableVideoComposition(propertiesOf: avasset)
        videocomposition.renderSize = CGSize(width: videoTrack.naturalSize.height, height: videoTrack.naturalSize.height)
        videocomposition.frameDuration = CMTime(value: 1, timescale: 30)
        
        //var instruction = AVMutableVideoCompositionInstruction()
        //instruction.timeRange = CMTimeRange(
        
    }
    */
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func convertVideoToGif(videoUrl: NSURL, start : NSNumber?, duration : Float?){
        
        let regift : Regift!
        
        if let start = start{
            
            regift = Regift(sourceFileURL: videoUrl as URL, destinationFileURL: nil, startTime: start as! Float, duration: duration!, frameRate: 15, loopCount: 0)
        
        }
        else{
                
                regift = Regift(sourceFileURL: videoUrl as URL, frameCount: framecount, delayTime: delatTime)
                
                
            }
        
        let gifurl = regift.createGif()
        
        let gif = Gif(gifUrl: gifurl!, videourl: videoUrl as URL, caption: nil)
        
        self.displayGif(gif : gif)
        
    }
    
    func displayGif(gif : Gif){
        
        var editor = self.storyboard?.instantiateViewController(withIdentifier: "GifEditorViewController") as! GifEditorViewController
        editor.gif = gif
        self.navigationController?.pushViewController(editor, animated: true)
        
    }
    
}

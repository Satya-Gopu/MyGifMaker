//
//  SavedGifController.swift
//  GifMaker_Swift_Template
//
//  Created by Satyanarayana Gopu on 4/21/17.
//  Copyright © 2017 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit
import Foundation

class SavedGifController: UIViewController{
    
    var gifsFilePath: String {
        let directories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        //let directories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsPath = directories[0].path
        let gifsPath = documentsPath.appending("/savedGifs")
        //let gifsPath = documentsPath.stringByAppendingString("/savedGifs")
        return gifsPath
    }
    
    
    var gifs  = [Gif]()
    
    @IBOutlet weak var stack: UIStackView!
    
    @IBOutlet weak var collection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let archived = NSKeyedUnarchiver.unarchiveObject(withFile: gifsFilePath){
            
            self.gifs = archived as! [Gif]
            
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.view.alpha = 1
        super.viewWillAppear(animated)
        if let archived = NSKeyedUnarchiver.unarchiveObject(withFile: gifsFilePath){
            
            self.gifs = archived as! [Gif]
            
        }
        self.collection.reloadData()
        self.stack.isHidden = (self.gifs.count != 0)
    }
  
}

extension SavedGifController : PreviewViewControllerDelegate{
    
    func savegif(gif: Gif) {
        gif.gifData = NSData(contentsOf: gif.url)
        self.gifs.append(gif)
        NSKeyedArchiver.archiveRootObject(self.gifs, toFile: gifsFilePath)
    }
    
}

extension SavedGifController : UICollectionViewDataSource, UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return 5
        return self.gifs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        cell.configurecell(gif: self.gifs[indexPath.item])
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detail = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detail.gif = self.gifs[indexPath.row]
        self.present(detail, animated: true, completion: {
            self.view.alpha = 0
        })
        
    }
    
}


extension SavedGifController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availwidth = (self.collection.frame.width - 2 * 12)/2
        return CGSize(width: availwidth, height: availwidth)
        
    }
    
}

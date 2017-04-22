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
        print("unarchived")
        if let archived = NSKeyedUnarchiver.unarchiveObject(withFile: gifsFilePath){
            
            self.gifs = archived as! [Gif]
            
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collection.reloadData()
        self.stack.isHidden = (self.gifs.count != 0)
    }
  
}

extension SavedGifController : PreviewViewControllerDelegate{
    
    func savegif(gif: Gif) {
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
        
        cell.cellImage.image = UIImage.gif(url: self.gifs[indexPath.row].url.absoluteString)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detail = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        detail.gif = self.gifs[indexPath.row]
        
        self.present(detail, animated: true, completion: nil)
        
    }
    
}


extension SavedGifController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availwidth = (self.collection.frame.width - 2 * 12)/2
        return CGSize(width: availwidth, height: availwidth)
        
    }
    /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }*/
    
    
    
    
    
}

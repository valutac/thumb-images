//
//  ViewController.swift
//  thumb images
//
//  Created by Aji Achmad Mustofa on 3/9/18.
//  Copyright © 2018 Valutac. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate, UICollectionViewDelegateFlowLayout {
    var dirPaths:Array<String> = []
    @IBOutlet weak var imageCollection:         UICollectionView!
    @IBOutlet weak var thumbImageCollection:    UICollectionView!
    
    override func viewDidLoad() {
        dirPaths    = Bundle.main.paths(forResourcesOfType: "jpeg", inDirectory: "")
        imageCollection.reloadData()
        thumbImageCollection.reloadData()
        let indexPath = IndexPath.init(row: 0, section: 0)
        thumbImageCollection.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.centeredHorizontally)
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dirPaths.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case thumbImageCollection:
            let cell            = collectionView.dequeueReusableCell(withReuseIdentifier: "thumbImageCell", for: indexPath) as! thumbImageCell
            let pathImage       = dirPaths[indexPath.row]
            let imageURL        = URL(fileURLWithPath: pathImage)
            let image           = UIImage(contentsOfFile: imageURL.path)
            cell.image.image    = image
            return cell
        default:
            let cell            = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! imageCell
            let pathImage       = dirPaths[indexPath.row]
            let imageURL        = URL(fileURLWithPath: pathImage)
            let image           = UIImage(contentsOfFile: imageURL.path)
            cell.image.image    = image
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case thumbImageCollection:
            return CGSize(width: 70, height: 70)
        default:
            return imageCollection.frame.size
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if thumbImageCollection == collectionView {
            imageCollection.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == imageCollection {
            thumbImageCollection.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.init(rawValue: 0))
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == imageCollection {
            let pages = floor(imageCollection.contentOffset.x / imageCollection.frame.size.width)
            if(Int(pages) > 0 && Int(pages) <= dirPaths.count){
                let indexPath = IndexPath.init(row: Int(pages), section: 0)
                thumbImageCollection.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
                thumbImageCollection.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.init(rawValue: 0))
            }
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let pages = floor(imageCollection.contentOffset.x / imageCollection.frame.size.width)
        let indexPath = IndexPath.init(row: Int(pages), section: 0)
        if scrollView == imageCollection {
            if(Int(pages) > 0 && Int(pages) <= dirPaths.count){
                thumbImageCollection.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
            }
        }else{
            thumbImageCollection.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.init(rawValue: 0))
        }
    }


}


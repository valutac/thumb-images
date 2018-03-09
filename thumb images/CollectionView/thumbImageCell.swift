//
//  thumbImageCell.swift
//  thumb images
//
//  Created by Aji Achmad Mustofa on 3/9/18.
//  Copyright © 2018 Valutac. All rights reserved.
//

import UIKit

class thumbImageCell: UICollectionViewCell {
    @IBOutlet weak var image:       UIImageView!
    @IBOutlet weak var backImage:   UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        backImage.layer.borderColor     = UIColor.gray.cgColor
        backImage.layer.borderWidth     = 2;
        backImage.layer.cornerRadius    = 4;
        backImage.layer.masksToBounds   = true;
    }
    override var isSelected: Bool{
        didSet {
            if isSelected{
                backImage.layer.borderColor    = UIColor.red.cgColor
            }else{
                backImage.layer.borderColor     = UIColor.gray.cgColor
            }
        }
    }
}

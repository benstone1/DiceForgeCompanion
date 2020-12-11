//
//  DieFaceCollectionViewCell.swift
//  DiceForgeCompanion
//
//  Created by Benjamin Stone on 12/10/20.
//  Copyright © 2020 Benjamin Stone. All rights reserved.
//

import UIKit

class DieFaceCollectionViewCell: UICollectionViewCell {

    @IBOutlet var dieFaceImageView: UIImageView!
    
    var dieFace: DieFace? {
        didSet {
            dieFaceImageView.image = dieFace?.image ?? UIImage(systemName: "questionmark")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

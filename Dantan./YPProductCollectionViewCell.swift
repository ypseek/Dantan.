//
//  YPProductCollectionViewCell.swift
//  Dantan.
//
//  Created by mac on 2017/10/20.
//  Copyright © 2017年 huahan. All rights reserved.
//

import UIKit

class YPProductCollectionViewCell: UICollectionViewCell {

    var product : YPProduct? {
        didSet{
            let url = product!.cover_image_url
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

//
//  YPHomeCell.swift
//  Dantan.
//
//  Created by mac on 2017/10/20.
//  Copyright © 2017年 huahan. All rights reserved.
//

import UIKit
import Kingfisher

protocol YPHOmeCellDelegate : NSObjectProtocol {
    func homeCellFavoriteCickBtn(button : UIButton)
}

class YPHomeCell: UITableViewCell {

    weak var delegate : YPHOmeCellDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var bgImageView: UIImageView!
    
    @IBOutlet weak var favoriteBtn: UIButton!
    
    var homeItem : YPHomeItem? {
        didSet {
            let url = homeItem?.cover_image_url
            bgImageView.kf.setImage(with: URL(string: url!)!, placeholder: nil, options: nil, progressBlock: nil) { (image, error, cacheType, imageURL) in
               
            }
            titleLabel.text = homeItem!.title
            favoriteBtn.setTitle(" " + String(homeItem!.likes_count!) + " ", for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        favoriteBtn.layer.cornerRadius = favoriteBtn.height * 0.5
        favoriteBtn.layer.masksToBounds = true
        favoriteBtn.layer.rasterizationScale = UIScreen.main.scale
        favoriteBtn.layer.shouldRasterize = true
        bgImageView.layer.cornerRadius = kCornerRadius
        bgImageView.layer.masksToBounds = true
        bgImageView.layer.shouldRasterize = true
        bgImageView.layer.rasterizationScale = UIScreen.main.scale
        // Initialization code
    }

    @IBAction func favorite(_ sender: UIButton) {
        delegate?.homeCellFavoriteCickBtn(button: sender)
    }
    
}

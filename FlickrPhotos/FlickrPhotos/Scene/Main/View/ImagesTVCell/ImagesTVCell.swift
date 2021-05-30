//
//  ImagesTVCell.swift
//  FlickrPhotos
//
//  Created by Ahmed Abuelmagd on 30/05/2021.
//

import UIKit
import Kingfisher

class ImagesTVCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.setShadow(cRadius: 11)
        img.layer.cornerRadius = 11
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func initCell(cellData: Photo){
//        let adsUrl = "https://farm66.static.flickr.com/65535/50397567507_855de8e6a9.jpg"
        if let url = URL(string: cellData.imageUrl) {
            img.kf.indicatorType = .activity
            img.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), options: [.transition(.fade(1))])
        }
    }
    
}

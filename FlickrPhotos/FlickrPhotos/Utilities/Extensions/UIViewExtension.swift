//
//  UIViewExtension.swift
//  FlickrPhotos
//
//  Created by Ahmed Abuelmagd on 30/05/2021.
//

import UIKit

extension UIView {
    
    func setShadow(scale: Bool = true, cRadius: Int) {
        //shadow
        layer.shadowRadius = 5
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
        self.layer.cornerRadius = CGFloat(cRadius)
        self.clipsToBounds = true
        layer.masksToBounds = false
    }
    func setBorder(color: UIColor, width: CGFloat, corderRadius: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
        self.layer.cornerRadius = corderRadius
        self.clipsToBounds = true
    }

}

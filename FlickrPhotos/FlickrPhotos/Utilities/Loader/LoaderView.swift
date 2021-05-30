//
//  LoaderView.swift
//  FlickrPhotos
//
//  Created by Ahmed Abuelmagd on 30/05/2021.
//


import UIKit
import NVActivityIndicatorView

class LoaderView: UIView {
    func showLoader()  {
        let color = hexStringToUIColor(hex: "F7941D")
        let size: CGFloat =  UIScreen.main.traitCollection.horizontalSizeClass == .regular ? 100.0 : 50.0
        let loader = NVActivityIndicatorView(frame: CGRect(x:center.x - (size / 2) ,y:center.y - (size / 2),width:size,height:size), type: .ballSpinFadeLoader, color: color, padding: nil)
        self.addSubview(loader)
        loader.startAnimating()
    }
}

//
//  Config.swift
//  FlickrPhotos
//
//  Created by Ahmed Abuelmagd on 30/05/2021.
//

import UIKit

struct Config {
    static let API_KEY = "d17378e37e555ebef55ab86c4180e8dc"
    static let METHOD = "flickr.photos.search"
    static let FORMAT = "json"
    static let URL = "https://www.flickr.com"
    static let BASE_URL = Config.URL + "/services/"

}
enum Images {
    static let placeholder = UIImage(named: "image")
}

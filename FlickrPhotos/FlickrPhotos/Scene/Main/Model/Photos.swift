//
//  Photos.swift
//  FlickrPhotos
//
//  Created by Ahmed Abuelmagd on 30/05/2021.
//

struct Photos : Codable {
    var page : Int?
    var pages : Int?
    var perpage : Int?
    var total : Int?
    var photo : [Photo]?
}
